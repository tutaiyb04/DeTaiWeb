package com.fshop.serverlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import com.fshop.dao.NguoiDungDAO;
import com.fshop.model.NguoiDung;
import util.DBConection;

@WebServlet("/dangky")
public class DangKyServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String tenDangNhap = request.getParameter("tenDangNhap");
        String hoTen = request.getParameter("hoTen");
        String email = request.getParameter("email");
        String soDienThoai = request.getParameter("soDienThoai");
        String diaChi = request.getParameter("diaChi");
        String matKhau = request.getParameter("matKhau");

        NguoiDung user = new NguoiDung(tenDangNhap, hoTen, email, soDienThoai, diaChi, matKhau);
        NguoiDungDAO dao = new NguoiDungDAO(DBConection.getConnection());

        boolean ok = dao.dangKy(user);
        if (ok) {
            // Chuyển sang trang đăng nhập kèm thông báo thành công
            response.sendRedirect("dangnhap.jsp?success=1");
        } else {
            response.sendRedirect("dangky.jsp?error=1");
        }
    }
}
