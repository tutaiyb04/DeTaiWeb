<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<header class="site-header">
    <div class="header-container">
        <div class="header-left">
            <img src="images/logo.png" alt="Logo" class="logo">
            <h1>Nội Thất Shop</h1>
        </div>
        <div class="header-right">
            <span>Hotline: 0344 076 552</span> |
            <%
            String tenDangNhap = (String) session.getAttribute("tenDangNhap");
            if (tenDangNhap == null) {
            %>
            <a href="dangnhap.jsp" style="color:white; text-decoration:none;">Đăng nhập</a> |
            <a href="dangky.jsp" style="color:white; text-decoration:none;">Đăng ký</a> |
        <% 
 } else { 
        %>
            Xin chào, <strong><%= tenDangNhap %></strong> |
            <a href="dangxuat.jsp" style="color:white; text-decoration:none;">Đăng xuất</a> |
        <% 
            } 
        %>
            <a href="giohang.jsp">Giỏ hàng</a>
            
           
        </div>
    </div>

    <nav class="top-menu">
        <ul>
            <li><a href="index.jsp">Trang chủ</a></li>
            <li><a href="sanpham.jsp">Sản phẩm</a></li>
            <li><a href="gioithieu.jsp">Giới thiệu</a></li>
            <li><a href="lienhe.jsp">Liên hệ</a></li>
            <li><a href="khuyenmai.jsp">Khuyến mãi</a></li>
          
        </ul>
    </nav>
</header>
