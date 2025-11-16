<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.fshop.model.CartItem, java.util.Map" %>
<%
    Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
    double tempTotal = 0;
    if (cart != null) {
        for (CartItem item : cart.values()) {
            tempTotal += item.getTotalPrice();
        }
    }
    double shippingFee = 0; 
    // Giả sử phí vận chuyển Miễn phí
    double grandTotal = tempTotal + shippingFee;
%>

<!DOCTYPE html>
<html>
<head>
    <title>Giỏ Hàng Của Bạn</title>
    <link rel="stylesheet" href="css/giohangstyle.css">
    <jsp:include page="includes/header.jsp" /> 
</head>
<body>

<div class="content-wrap"> <div class="checkout-container">
        <div class="main-content">
            <h1>Giỏ Hàng Của Bạn</h1>
            
            <div class="content-card product-list-card">
                <h2>Các Sản Phẩm Đã Thêm</h2>
                
                <% if (cart != null && !cart.isEmpty()) { %>
                    <table class="cart-table">
                        <thead>
                            <tr>
                                <th>Sản phẩm</th>
        
                            <th>Giá đơn vị</th>
                                <th>Số lượng</th>
                                <th>Thành tiền</th>
                    
                            <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                            for (CartItem item : cart.values()) { %>
                                <tr>
                                    <td><%= item.getProduct().getTenSanPham() %></td>
                                    
                                <td><%= String.format("%,.0f VNĐ", item.getProduct().getGia()) %></td>
                                    
                                    <td>
                                    
                                <form action="CartServlet" method="POST" id="updateForm<%= item.getProduct().getId() %>">
                                            <input type="hidden" name="action" value="update"/>
                                            <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>"/>
        
                                          <div class="quantity-control">
                                                <button type="button" onclick="changeQuantity(<%= item.getProduct().getId() %>, -1)">-</button>
                
                                <input type="number" name="quantity" value="<%= item.getQuantity() %>" min="1" onchange="submitForm(<%= item.getProduct().getId() %>)">
                                                <button type="button" onclick="changeQuantity(<%= item.getProduct().getId() %>, 1)">+</button>
            
                                      </div>
                                        </form>
                                    </td>
        
                                    
                                    <td><%= String.format("%,.0f VNĐ", item.getTotalPrice()) %></td>
                                    
        
                                    <td>
                                        <a href="CartServlet?action=remove&productId=<%= item.getProduct().getId() %>">Xóa</a>
                                    
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
            
        <% } else { %>
                    <p style="text-align: center; padding: 20px;">Giỏ hàng của bạn đang trống.</p>
                <% } %>
                
            </div>

            <div class="bottom-action-bar">
                <a href="sanpham.jsp" class="btn-continue-shopping">← Tiếp tục mua sắm</a>
            </div>
            
        </div>
        
        <div class="sidebar">
            <div class="content-card summary-card">
                <h2>Tóm Tắt Đơn Hàng</h2>
                <div class="summary-item">
                    <span class="label">Tạm tính (Tổng giá trị sản phẩm):</span>
                    <span class="value"><%= String.format("%,.0f ₫", tempTotal) %></span>
                </div>
                <div class="summary-item">
                    <span class="label">Phí vận chuyển:</span>
                    <span class="value free-shipping">Miễn phí (Đối với thanh toán trực tuyến)</span>
                </div>
        
            <div class="summary-total">
                    <span class="label">Tổng Thanh Toán:</span>
                    <span class="value total-price"><%= String.format("%,.0f ₫", grandTotal) %></span>
                </div>
            </div>

            <a href="checkout.jsp" class="btn-checkout-confirm">
            TIẾN HÀNH THANH TOÁN
            </a>
        </div>
    </div>

    <script>
        // Giữ lại hàm changeQuantity và submitForm cho giỏ hàng
        function changeQuantity(productId, delta) {
            // ... (Code JavaScript đã cung cấp trước đó) ...
            const form = document.getElementById('updateForm' + productId);
        const input = form.querySelector('input[name="quantity"]');
            
            let newQuantity = parseInt(input.value) + delta;
        if (newQuantity < 1) {
                newQuantity = 1;
        }
            
            input.value = newQuantity;
            form.submit();
        }
        
        function submitForm(productId) {
            document.getElementById('updateForm' + productId).submit();
        }
    </script>

</div> <jsp:include page="includes/footer.jsp" />
</body>
</html>