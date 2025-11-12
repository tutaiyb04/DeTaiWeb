package com.fshop.serverlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.UUID;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.DBConection;
import com.fshop.dao.NguoiDungDAO;
import jakarta.servlet.annotation.WebServlet;
import util.EmailUtil;

@WebServlet("/xulyquenmatkhau")
public class XuLyQuenMatKhauServlet extends HttpServlet {
    private static final long seriolVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("quenmatkhau.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String emailHoacTenDangNhap = request.getParameter("emailHoacTenDangNhap");

        if (emailHoacTenDangNhap == null || emailHoacTenDangNhap.trim().isEmpty()) {
            response.sendRedirect("quenmatkhau.jsp?error=invalid_input");
            return;
        }
        
        String input = emailHoacTenDangNhap.trim();
        Connection conn = null;

        try {
            conn = DBConection.getConnection();
            if (conn == null) {
                response.sendRedirect("quenmatkhau.jsp?error=system_error"); 
                return;
            }
            
            NguoiDungDAO nguoiDungDAO = new NguoiDungDAO(conn);

            // 1. Tìm kiếm Email người dùng
            String emailNguoiDung = nguoiDungDAO.timEmailHoacTenDangNhap(input);

            if (emailNguoiDung != null) {
                // 2. Tạo và Lưu Token
                String resetToken = UUID.randomUUID().toString();
                
                boolean tokenSaved = nguoiDungDAO.luuResetToken(input, resetToken);
                
                if (tokenSaved) {
                    // 3. Gửi email
                    boolean emailSent = EmailUtil.sendResetEmail(emailNguoiDung, resetToken);
                    
                    if (emailSent) {
                        // Thành công: chuyển hướng kèm thông báo đã gửi email
                        response.sendRedirect("quenmatkhau.jsp?success=email_sent");
                    } else {
                        // Lỗi gửi email
                        response.sendRedirect("quenmatkhau.jsp?error=email_send_failed");
                    }
                } else {
                    // Lỗi DB khi lưu token
                    response.sendRedirect("quenmatkhau.jsp?error=system_error");
                }

            } else {
                // Thất bại: Không tìm thấy tài khoản
                response.sendRedirect("quenmatkhau.jsp?error=not_found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("quenmatkhau.jsp?error=internal_server_error");
        } finally {
            // Đảm bảo kết nối được đóng
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
