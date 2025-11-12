package com.fshop.serverlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection; // Sửa lỗi import từ jakarta.jms.Connection
import java.sql.SQLException;
import com.fshop.dao.NguoiDungDAO;
import util.DBConection;

@WebServlet("/datlaimatkhau")
public class DatLaiMatKhau extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    String token = request.getParameter("token");
        
        if (token == null || token.isEmpty()) {
            // Lỗi: Không có token trong URL
            response.sendRedirect("datlaimatkhau.jsp?error=invalid_token");
            return;
        }
        
        Connection conn = null;
        try {
            conn = DBConection.getConnection();
            NguoiDungDAO dao = new NguoiDungDAO(conn);
            
            // 1. Kiểm tra token có hợp lệ và chưa hết hạn không
            if (dao.kiemTraTokenHopLe(token)) {
                // Token hợp lệ, chuyển tiếp để hiển thị form
                request.getRequestDispatcher("datlaimatkhau.jsp").forward(request, response);
            } else {
                // Token không hợp lệ hoặc đã hết hạn
                response.sendRedirect("datlaimatkhau.jsp?error=expired");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("datlaimatkhau.jsp?error=system_error");
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         request.setCharacterEncoding("UTF-8");
   request.setCharacterEncoding("UTF-8");
        
        String token = request.getParameter("token");
        String matKhauMoi = request.getParameter("matKhauMoi");
        String xacNhanMatKhau = request.getParameter("xacNhanMatKhau");
        
        if (token == null || matKhauMoi == null || xacNhanMatKhau == null) {
            response.sendRedirect("datlaimatkhau.jsp?error=system_error");
            return;
        }

        // 1. Kiểm tra khớp mật khẩu
        if (!matKhauMoi.equals(xacNhanMatKhau)) {
            response.sendRedirect("datlaimatkhau.jsp?token=" + token + "&error=mismatch");
            return;
        }

        Connection conn = null;
        try {
            conn = DBConection.getConnection();
            NguoiDungDAO dao = new NguoiDungDAO(conn);

            // 2. Kiểm tra lại token lần nữa trước khi cập nhật
            if (!dao.kiemTraTokenHopLe(token)) {
                 response.sendRedirect("datlaimatkhau.jsp?error=expired");
                 return;
            }
            
            // 3. Thực hiện đặt lại mật khẩu (UPDATE mat_khau và XÓA token)
            // LƯU Ý: matKhauMoi cần được mã hóa trước khi đưa vào hàm datLaiMatKhau
            boolean success = dao.datLaiMatKhau(token, matKhauMoi);

            if (success) {
                // Đặt lại thành công
                response.sendRedirect("datlaimatkhau.jsp?success=true");
            } else {
                // Lỗi DB hoặc token bị xóa bởi tiến trình khác
                response.sendRedirect("datlaimatkhau.jsp?token=" + token + "&error=system_error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("datlaimatkhau.jsp?token=" + token + "&error=system_error");
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
