package com.fshop.serverlet;

import com.fshop.dao.OrderDAO; 
import com.fshop.model.CartItem;
import com.fshop.model.NguoiDung; 
import com.fshop.dao.CartDAO; 
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map; 

@WebServlet(name = "OrderServlet", urlPatterns = {"/OrderServlet"})
public class OrderServlet extends HttpServlet {

    // Khai báo các DAO
    private final OrderDAO orderDAO = new OrderDAO();
    private final CartDAO cartDAO = new CartDAO();
    
    // --- PHƯƠNG THỨC HỖ TRỢ: Lấy User ID ---
    private int getUserId(HttpSession session) {
        NguoiDung user = (NguoiDung) session.getAttribute("nguoidung");
        return user != null ? user.getId() : 0; 
    }

    // --- PHƯƠNG THỨC HỖ TRỢ: Xử lý Yêu cầu POST ---
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8"); // Đảm bảo tiếng Việt
        HttpSession session = request.getSession();
        int userId = getUserId(session);
        
        // 1. KIỂM TRA ĐIỀU KIỆN TIÊN QUYẾT
        if (userId == 0) {
            session.setAttribute("preLoginURL", "checkout.jsp");
            response.sendRedirect("dangnhap.jsp");
            return;
        }
        
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("giohang.jsp?error=emptycart");
            return;
        }

        try {
            // 2. THU THẬP THÔNG TIN TỪ FORM
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String addressDetail = request.getParameter("addressDetail");
            String notes = request.getParameter("notes");
            String paymentMethod = request.getParameter("paymentMethod");
            
            String fullAddress = addressDetail;
            
            // 3. TÍNH TOÁN LẠI (TRÊN SERVER)
            double tempTotal = 0;
            for (CartItem item : cart.values()) {
                tempTotal += item.getTotalPrice(); 
            }
            
            // 🚀 LOGIC TÍNH PHÍ VẬN CHUYỂN DỰA TRÊN PHƯƠNG THỨC THANH TOÁN
            double shippingFee = 0;
            
            if ("cod".equals(paymentMethod)) {
                shippingFee = 50000; // 50,000 VND nếu chọn Thanh toán khi nhận hàng
            } else {
                shippingFee = 0; // Miễn phí cho các phương thức khác
            }
            
            double discount = 500000;
            
            double grandTotal = tempTotal + shippingFee - discount;
            if (grandTotal < 0) grandTotal = 0;

            // 4. LƯU ĐƠN HÀNG VÀO DB
            int newOrderId = orderDAO.saveOrderTransaction(
                userId, fullName, phone, email, fullAddress, notes, 
                paymentMethod, tempTotal, shippingFee, discount, grandTotal, // 🚀 Dùng shippingFee ĐÃ TÍNH TOÁN
                cart 
            );

            if (newOrderId > 0) {
                // 5. XỬ LÝ THANH TOÁN
                
                if ("cod".equals(paymentMethod)) {
                    // Xử lý COD: Xóa giỏ hàng Session và DB
                    session.removeAttribute("cart");
                    cartDAO.deleteAllCartItems(userId); 
                    
                    // Chuyển hướng đến trang xác nhận
                    response.sendRedirect("confirmation.jsp?orderId=" + newOrderId);
                    
                } else {
                    // Xử lý Thanh toán Trực tuyến (Giả lập)
                    session.removeAttribute("cart");
                    cartDAO.deleteAllCartItems(userId); 
                    
                    response.sendRedirect("payment_processing.jsp?orderId=" + newOrderId + "&method=" + paymentMethod);
                }
                
            } else {
                // Lỗi khi tạo đơn hàng
                response.sendRedirect("error.jsp?msg=DbError");
            }

        } catch (Exception e) {
            e.printStackTrace();
            // Lỗi hệ thống hoặc lỗi DB
            response.sendRedirect("error.jsp?msg=SystemError");
        }
    }
}