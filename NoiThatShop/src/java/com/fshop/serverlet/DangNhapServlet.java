package com.fshop.serverlet;

import com.fshop.dao.NguoiDungDAO;
import com.fshop.dao.CartDAO; 
import com.fshop.model.NguoiDung;
import com.fshop.model.CartItem; 
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.Map; 
import util.DBConection;

@WebServlet("/dangnhap")
public class DangNhapServlet extends HttpServlet {
    
    // 🚀 PHƯƠNG THỨC MỚI: Xử lý yêu cầu GET để hiển thị trang JSP
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Chuyển tiếp yêu cầu đến trang dangnhap.jsp để hiển thị form
        request.getRequestDispatcher("dangnhap.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String tenDangNhap = request.getParameter("tenDangNhap");
        String matKhau = request.getParameter("matKhau");

        try (java.sql.Connection conn = DBConection.getConnection()){
            
            NguoiDungDAO dao = new NguoiDungDAO(conn);
            NguoiDung user = dao.dangNhap(tenDangNhap, matKhau);

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("nguoidung", user);
                session.setAttribute("tenDangNhap", user.getTenDangNhap());
                
                // --- LOGIC GỘP GIỎ HÀNG VĨNH VIỄN ---
                
                int userId = user.getId(); 
                CartDAO cartDAO = new CartDAO();
                
                // 1. Lấy giỏ hàng TẠM THỜI hiện có trong Session (Guest Cart)
                @SuppressWarnings("unchecked")
                Map<Integer, CartItem> guestCart = (Map<Integer, CartItem>) session.getAttribute("cart");
                
                // 2. Tải giỏ hàng VĨNH VIỄN (từ DB)
                Map<Integer, CartItem> persistentCart = cartDAO.getCartByUserId(userId);
                
                // 3. GỘP GIỎ HÀNG: Gộp Guest Cart vào Persistent Cart (và cập nhật DB)
                if (guestCart != null && !guestCart.isEmpty()) {
                    for (CartItem guestItem : guestCart.values()) {
                        int pid = guestItem.getProduct().getId();
                        int newQuantity;

                        if (persistentCart.containsKey(pid)) {
                            // Cộng dồn số lượng
                            newQuantity = persistentCart.get(pid).getQuantity() + guestItem.getQuantity();
                        } else {
                            // Thêm mới
                            newQuantity = guestItem.getQuantity();
                        }
                        
                        // Cập nhật DB (Đây là bước lưu lại giỏ hàng gộp vào DB)
                        cartDAO.saveOrUpdateCartItem(userId, pid, newQuantity);
                    }
                    
                    // Sau khi cập nhật DB, TẢI LẠI Persistent Cart để đảm bảo Session Map có Product chi tiết
                    // (Điều này quan trọng vì guestCart có thể thiếu chi tiết Product)
                    persistentCart = cartDAO.getCartByUserId(userId); 
                }
                
                // 4. Lưu giỏ hàng ĐÃ GỘP (PersistentCart) vào Session
                session.setAttribute("cart", persistentCart);
                
                // ------------------------------------------------------------------

                // CHUYỂN HƯỚNG VỀ TRANG TRƯỚC KHI ĐĂNG NHẬP
                String preLoginURL = (String) session.getAttribute("preLoginURL");
                
                if (preLoginURL != null && !preLoginURL.isEmpty())
                {
                    session.removeAttribute("preLoginURL"); 
                    response.sendRedirect(preLoginURL);     
                } else {
                    response.sendRedirect("index.jsp");     
                }
                
            } else {
                response.sendRedirect("dangnhap.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("dangnhap.jsp?error=99"); 
        }
    }
}