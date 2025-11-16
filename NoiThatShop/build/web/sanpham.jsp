<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.fshop.dao.ProductDAO" %>
<%@ page import="com.fshop.model.Product" %>
<%@ page import="java.util.List" %>

<%
    ProductDAO dao = new ProductDAO();
    String categoryIdParam = request.getParameter("categoryId");
    List<Product> list;

    if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
        try {
            int categoryId = Integer.parseInt(categoryIdParam);
            list = dao.getProductsByCategoryNonDiscounted(categoryId);
        } catch (Exception e) {
            list = dao.listAllNonDiscounted();
        }
    } else {
        list = dao.listAllNonDiscounted();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="css/spstyle.css">
    <title>Sản phẩm - THT Furniture</title>
</head>

<body>
<jsp:include page="includes/header.jsp" />

<div class="main-container">
    <div class="content-wrapper">

        <aside class="category-sidebar">
            <h3>Danh mục sản phẩm</h3>
            <ul>
                <li><a href="sanpham.jsp">Tất cả sản phẩm</a></li>
                <li><a href="sanpham.jsp?categoryId=1">Sofa</a></li>
                <li><a href="sanpham.jsp?categoryId=2">Bàn ghế</a></li>
                <li><a href="sanpham.jsp?categoryId=3">Giường ngủ</a></li>
                <li><a href="sanpham.jsp?categoryId=4">Tủ & Kệ</a></li>
                <li><a href="sanpham.jsp?categoryId=5">Trang trí</a></li>
            </ul>
        </aside>

        <section class="products-section">
            <h2><%= (categoryIdParam == null ? "Các sản phẩm" : "Sản phẩm theo danh mục") %></h2>
            <div class="product-grid">

                <%
                    if (list != null && !list.isEmpty()) {
                        for (Product p : list) {
                %>

                <div class="product-card">
                    <img src="<%= p.getHinhAnh() %>" alt="<%= p.getTenSanPham() %>">
                    <h4><%= p.getTenSanPham() %></h4>
                    <p><%= p.getMoTa() %></p>
                    <div class="price"><%= String.format("%,.0f", p.getGia()) %> VNÐ</div>
                    <div class="button-group"> 
                        <a href="CartServlet?action=add&productId=<%= p.getId() %>" class="btn-add-to-cart">Thêm vào giỏ hàng</a>
                        <a href="CartServlet?action=buy&productId=<%= p.getId() %>" class="btn-buy">Mua ngay</a>
                    </div>
                </div>

                <%
                        }
                    } else {
                %>

                <p>Không có sản phẩm nào trong danh mục này.</p>

                <%
                    }
                %>
            </div>
        </section>

    </div>
</div>

<jsp:include page="includes/footer.jsp" />
</body>
</html>
