package com.fshop.serverlet;

import com.fshop.dao.NguoiDungDAO;
import com.fshop.model.NguoiDung;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import Database.DBConnect;

@WebServlet("/dangnhap")
public class DangNhapServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String tenDangNhap = request.getParameter("tenDangNhap");
        String matKhau = request.getParameter("matKhau");

        NguoiDungDAO dao = new NguoiDungDAO(DBConnect.getConnection());
        NguoiDung user = dao.dangNhap(tenDangNhap, matKhau);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("nguoidung", user);
            session.setAttribute("tenDangNhap", user.getTenDangNhap());
            response.sendRedirect("index.jsp"); // về trang chính
        } else {
            response.sendRedirect("dangnhap.jsp?error=1");
        }
    }
}
