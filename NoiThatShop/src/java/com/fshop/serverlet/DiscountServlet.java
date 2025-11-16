package com.fshop.serverlet;

import com.fshop.dao.ProductDAO;
import com.fshop.model.Product;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/khuyenmai") // Đường dẫn mới để truy cập trang khuyến mãi
public class DiscountServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        ProductDAO dao = new ProductDAO();
        try {
            // 1. Lấy danh sách sản phẩm giảm giá từ DAO
            List<Product> discountedProducts = dao.listAllDiscounted(); 
            
            // 2. Đặt danh sách vào request scope
            req.setAttribute("discountedProducts", discountedProducts);
            
            // 3. Chuyển tiếp đến trang JSP để hiển thị
            RequestDispatcher rd = req.getRequestDispatcher("khuyenmai.jsp");
            rd.forward(req, resp);
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Lỗi khi lấy sản phẩm giảm giá: " + e.getMessage());
        }
    }
}