package com.fshop.serverlet;

import com.fshop.dao.ProductDAO;
import com.fshop.dao.CartDAO;
import com.fshop.model.CartItem;
import com.fshop.model.Product;
import com.fshop.model.NguoiDung;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;
import java.util.HashMap;


@WebServlet(name = "CartServlet", urlPatterns = {"/CartServlet"})
public class CartServlet extends HttpServlet {

    // Khai báo DAO để có thể sử dụng ở nhiều nơi
    private final ProductDAO productDAO = new ProductDAO();
    private final CartDAO cartDAO = new CartDAO();

    // --- PHƯƠNG THỨC HỖ TRỢ: Lấy User ID ---
    private int getUserId(HttpSession session) {
        NguoiDung user = (NguoiDung) session.getAttribute("nguoidung");
        return user != null ? user.getId() : 0; 
    }

    // --- PHƯƠNG THỨC HỖ TRỢ: Lấy hoặc tạo Cart từ Session ---
    private Map<Integer, CartItem> getOrCreateCart(HttpSession session) {
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute("cart", cart);
        }
        return cart;
    }
    
    // --- PHƯƠNG THỨC HỖ TRỢ: Tải lại Giỏ hàng từ DB vào Session ---
    // (Giữ nguyên, nhưng ít được dùng trong doGet/doPost sau khi sửa)
    private void reloadCartFromDB(HttpSession session, int userId) throws Exception {
        Map<Integer, CartItem> reloadedCart = cartDAO.getCartByUserId(userId);
        session.setAttribute("cart", reloadedCart);
    }
    
    // ------------------------------------------------------------------
    // 1. XỬ LÝ YÊU CẦU GET (Thêm/Mua ngay/Xóa)
    // ------------------------------------------------------------------
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String tenDangNhap = (String) session.getAttribute("tenDangNhap");
        String action = request.getParameter("action");
        String productIdParam = request.getParameter("productId");
        
        // 🚀 BỎ QUA KIỂM TRA ĐĂNG NHẬP Ở ĐÂY để cho phép giỏ hàng tạm thời (Guest Cart)
        
        int userId = getUserId(session);
        
        if (productIdParam == null || productIdParam.isEmpty()) {
            response.sendRedirect("sanpham.jsp");
            return;
        }
        
        int productId;
        try {
            productId = Integer.parseInt(productIdParam);
        } catch (NumberFormatException e) {
            response.sendRedirect("sanpham.jsp");
            return;
        }

        try {
            // Lấy Cart (Dù đã đăng nhập hay chưa)
            Map<Integer, CartItem> currentCart = getOrCreateCart(session);
            
            if ("add".equals(action) || "buy".equals(action)) {
                
                // 1. Tính toán số lượng mới
                CartItem existingItem = currentCart.get(productId);
                int newQuantity = (existingItem != null) ? existingItem.getQuantity() + 1 : 1;
                
                // 2. Lấy hoặc cập nhật thông tin Product
                Product product;
                if (existingItem != null) {
                    product = existingItem.getProduct();
                } else {
                    product = productDAO.getProductById(productId); // 🚀 Lấy chi tiết Product
                }
                
                if (product == null) {
                     response.sendRedirect("sanpham.jsp?error=product_not_found");
                     return;
                }
                
                // 3. Cập nhật Giỏ hàng trong SESSION
                currentCart.put(productId, new CartItem(product, newQuantity));
                
                // 4. Cập nhật vào DB CHỈ KHI ĐÃ ĐĂNG NHẬP (Persistent Cart)
                if (userId > 0) {
                    cartDAO.saveOrUpdateCartItem(userId, productId, newQuantity);
                }

                if ("add".equals(action)) {
                    String referer = request.getHeader("Referer");
                    if (referer != null && !referer.isEmpty()) {
                        response.sendRedirect(referer); 
                    } else {
                        response.sendRedirect("sanpham.jsp"); 
                    }
                } else { // action="buy"
                    // Chuyển sang trang thanh toán
                    response.sendRedirect("checkout.jsp"); 
                }
                
            } else if ("remove".equals(action)) {
                
                // 1. Xóa khỏi Session
                currentCart.remove(productId);
                
                // 2. Xóa khỏi DB CHỈ KHI ĐÃ ĐĂNG NHẬP
                if (userId > 0) {
                    cartDAO.deleteCartItem(userId, productId);
                }
                
                // Không cần reloadCartFromDB vì Session đã được cập nhật trực tiếp
                response.sendRedirect("giohang.jsp");
                
            } else {
                 response.sendRedirect("sanpham.jsp");
            }
            
        } catch (Exception e) {
            e.printStackTrace(); 
            response.sendRedirect("sanpham.jsp"); 
        }
    }

    // ------------------------------------------------------------------
    // 2. XỬ LÝ YÊU CẦU POST (Cập nhật số lượng từ trang giỏ hàng)
    // ------------------------------------------------------------------

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        String productIdParam = request.getParameter("productId");
        
        int userId = getUserId(session);
        
        if (productIdParam == null || productIdParam.isEmpty()) {
            response.sendRedirect("giohang.jsp");
            return;
        }

        try {
            int productId = Integer.parseInt(productIdParam);
            Map<Integer, CartItem> currentCart = getOrCreateCart(session); // Lấy Cart từ Session
            
            if ("update".equals(action)) {
                String quantityParam = request.getParameter("quantity");
                int newQuantity = Integer.parseInt(quantityParam);
                
                if (newQuantity <= 0) newQuantity = 1; // Bảo đảm số lượng tối thiểu là 1

                // 1. Cập nhật vào SESSION
                CartItem itemToUpdate = currentCart.get(productId);
                if (itemToUpdate != null) {
                    itemToUpdate.setQuantity(newQuantity);
                } else {
                    // Trường hợp cập nhật một item không có trong Session (hiếm)
                    Product product = productDAO.getProductById(productId);
                    if (product != null) {
                         currentCart.put(productId, new CartItem(product, newQuantity));
                    }
                }
                
                // 2. Cập nhật vào DB CHỈ KHI ĐÃ ĐĂNG NHẬP
                if (userId > 0) {
                    cartDAO.saveOrUpdateCartItem(userId, productId, newQuantity);
                }

            } else if ("remove".equals(action)) {
                // Xử lý xóa
                currentCart.remove(productId);
                if (userId > 0) {
                   cartDAO.deleteCartItem(userId, productId);
                }
            }
            
            // Không cần reloadCartFromDB vì Session đã được cập nhật trực tiếp
            response.sendRedirect("giohang.jsp");
            
        } catch (NumberFormatException e) {
             e.printStackTrace();
             response.sendRedirect("giohang.jsp");
        } catch (Exception e) {
             e.printStackTrace();
             response.sendRedirect("giohang.jsp");
        }
    }
}