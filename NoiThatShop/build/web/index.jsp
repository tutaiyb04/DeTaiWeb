<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.fshop.dao.ProductDAO, com.fshop.model.Product, java.util.List" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Nội Thất Shop</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<jsp:include page="includes/header.jsp" />

<!-- 🟠 Banner toàn chiều ngang -->
<div class="main-banner">
    <img src="images/banner.png" alt="Banner nội thất">
</div>

<!-- 🟤 Phần nội dung chính -->
<div class="main-container">
    <main class="products-section">
        <h2 class="section-title">Sản phẩm nổi bật</h2>
        <div class="product-grid">
            <%
                ProductDAO dao = new ProductDAO();
                List<Product> list = dao.listAll();
                int count = 0;
                for (Product p : list) {
                    if (count >= 12) break; // chỉ hiện 6 sản phẩm đầu tiên
                    count++;
            %>
            <div class="product-card">
                <img src="<%= p.getHinhAnh() %>" alt="<%= p.getTenSanPham() %>">
                <h4><%= p.getTenSanPham() %></h4>
                <p><%= p.getMoTa() %></p>
                <div class="price"><%= String.format("%,.0f", p.getGia()) %> VNĐ</div>
                <button class="btn-buy">Mua ngay</button>
            </div>
            <% } %>
        </div>
    </main>
</div>

<jsp:include page="includes/footer.jsp" />

</body>
</html>
