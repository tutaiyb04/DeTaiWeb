<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.fshop.dao.ProductDAO, com.fshop.model.Product, java.util.List" %>
<%
    ProductDAO dao = new ProductDAO();
    String categoryIdParam = request.getParameter("categoryId");
    List<Product> list;
    
    if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
        try{
            int categoryId = Integer.parseInt(categoryIdParam);
        list = dao.getProductsByCategory(categoryId);
        } catch (Exception e){
            list = dao.listAll(); // Nếu lỗi parse, hiển thị tất cả
        }
    } else {
        list = dao.listAll(); // Không có tham số -> hiển thị tất cả
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
        <!-- Khu vực chính: 2 cột -->
        <div class="main-container">
            <div class="content-wrapper">
                <!-- Cột trái: Danh mục -->
                <aside class="category-sidebar">
                    <h3>Danh mục sản phẩm</h3>
                    <ul>
                        <li><a href="sanpham.jsp">Tất cả sản phẩm</a></li>
                        <li><a href="sanpham.jsp?categoryId=1">Sofa</li>
                        <li><a href="sanpham.jsp?categoryId=2">Bàn ghế</a></li>
                        <li><a href="sanpham.jsp?categoryId=3">Giường ngủ</a></li>
                        <li><a href="sanpham.jsp?categoryId=4">Tủ & Kệ</a></li>
                        <li><a href="sanpham.jsp?categoryId=5">Trang trí</a></li>
                    </ul>
                </aside>
                
                <!-- Cột phải: Danh sách sản phẩm -->
                <section class="products-section">
                    <h2><%= (categoryIdParam == null ? "Các sản phẩm" : "Sản phẩm theo danh mục") %></h2>
                    <div class="product-grid">
                        <%
                            if (list != null && !list.isEmpty()){
                                for (Product p : list){
                        %>
                        <div class="product-card">
                            <img src="<%= p.getHinhAnh() %>" alt="<%= p.getTenSanPham() %>">
                            <h4><%= p.getTenSanPham() %></h4>
                            <p><%= p.getMoTa() %></p>
                            <div class="price"><%= String.format("%,.0f", p.getGia()) %> VNÐ</div>
                            <button class="btn-buy">Mua ngay</button>
                        </div>
                        <%      } 
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
