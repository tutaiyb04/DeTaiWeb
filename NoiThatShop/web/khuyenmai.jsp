<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.fshop.model.Product, java.util.List, com.fshop.dao.ProductDAO" %>

<%!
    // Giữ nguyên khối Declaration
    double calculateDiscountPercentage(double originalPrice, double currentPrice) {
        if (originalPrice <= 0 || originalPrice == currentPrice) return 0;
        return ((originalPrice - currentPrice) / originalPrice) * 100;
    }
%>

<%
    // 🚀 THAY THẾ LOGIC TỰ GỌI DAO
    ProductDAO dao = new ProductDAO();
    List<Product> list;
    try {
        // Gọi DAO trực tiếp để lấy sản phẩm giảm giá
        list = dao.listAllDiscounted(); 
    } catch (Exception e) {
        e.printStackTrace();
        list = null; // Gán null nếu có lỗi
    }
    // Biến 'list' giờ đã chứa dữ liệu
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="css/khuyenmai.css">
    <link rel="stylesheet" href="css/style.css">
    <title>Khuyến Mãi</title>
</head>
<script>
  // Tự động hiển thị popup khi trang tải xong
  window.onload = function() {
    document.getElementById("promoPopup").style.display = "flex";
  };

  // Hàm đóng popup
  function closePopup() {
    document.getElementById("promoPopup").style.display = "none";
  }
</script>

<body>
    <div id="promoPopup" class="popup-container" style="display: none;">
        <div class="popup-content">
            <span class="close-btn" onclick="closePopup()">&times;</span>
            <img src="images/quangcao.jpg" alt="Khuyến mãi" class="popup-image">
        </div>
    </div>
    <jsp:include page="includes/header.jsp" />
    <h1 class="promo-title">🎉 ƯU ĐÃI KHỦNG – <span>GIẢM GIÁ ĐẾN 50%</span> 🎉</h1>
    
    <div class="promo-banner">
      <img src="images/Flash.jpg" alt="Banner khuyến mãi" class="banner-img">
    </div>

    <div class="product-list">
        <%
            if (list != null && !list.isEmpty()) {
                for (Product p : list) {
                    double currentPrice = p.getGia();
                    double originalPrice = 0.0;
                    String discountText = "-SALE-";
                    
                    // 🚀 LOGIC GIẢ ĐỊNH TÍNH GIÁ GỐC (Dựa trên dữ liệu gốc của bạn)
                    // Cần CÓ cột GiaGoc trong DB để làm việc này chính xác.
                    switch (p.getId()) {
                        case 2: originalPrice = 12990000.00; discountText = "-30%"; break; // Sofa Góc L Shape
                        case 7: originalPrice = 1290000.00; discountText = "-40%"; break; // Bộ Bàn Trà Scandi
                        case 5: originalPrice = 7490000.00; discountText = "-20%"; break; // Sofa Bed Tiện Dụng
                        case 10: originalPrice = 290000.00; discountText = "-35%"; break; // Ghế Ăn Eames
                        case 15: originalPrice = 2190000.00; discountText = "-25%"; break; // Tấm Nệm Foam 20cm
                        case 12: originalPrice = 599000.00; discountText = "-50%"; break; // Bàn Vi Tính Compact
                        case 18: originalPrice = 1290000.00; discountText = "-45%"; break; // Giường tầng bé yêu
                        case 22: originalPrice = 1990000.00; discountText = "-30%"; break; // Kệ Tivi Nordic
                        case 3: originalPrice = 450000.00; discountText = "-30%"; break; // Ghế Đôn Milan
                        case 9: originalPrice = 1690000.00; discountText = "-30%"; break; // Bàn Trang Điểm Lily
                        default: originalPrice = currentPrice; discountText = "-SALE-"; break;
                    }

                    // Nếu giá gốc được xác định, sử dụng hàm tính phần trăm (Tuy nhiên, phần trăm đã được hardcode trong discountText)
                    // double discountPercentage = calculateDiscountPercentage(originalPrice, currentPrice);
        %>
        <div class="product-card">
            <div class="discount-label"><%= discountText %></div>
            
            <img src="<%= p.getHinhAnh() %>" alt="<%= p.getTenSanPham() %>">
            <h3><%= p.getTenSanPham() %></h3>
            <div class="price">
                <span class="new"><%= String.format("%,.0f VNĐ", currentPrice) %></span>
                <% if (originalPrice > currentPrice) { %>
                    <span class="old"><%= String.format("%,.0f VNĐ", originalPrice) %></span>
                <% } %>
            </div>
            
            <div class="button-group">
                 <a href="CartServlet?action=add&productId=<%= p.getId() %>" class="btn-add-to-cart">Thêm vào giỏ hàng</a>
                 <a href="CartServlet?action=buy&productId=<%= p.getId() %>" class="btn-buy">Mua ngay</a>
            </div>
        </div>
        <%
                }
            } else {
        %>
            <p style="text-align: center; width: 100%; margin: 50px 0;">Hiện tại không có chương trình khuyến mãi nào.</p>
        <%
            }
        %>
    </div>
    <jsp:include page="includes/footer.jsp" />
</body>
</html>