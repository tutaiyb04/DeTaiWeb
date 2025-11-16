<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.fshop.model.CartItem, com.fshop.model.NguoiDung, java.util.Map" %>
<%
    // Lấy giỏ hàng từ session
    Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
    double tempTotal = 0;
    
    if (cart != null) {
        for (CartItem item : cart.values()) {
            tempTotal += item.getTotalPrice(); // Tính tổng tiền sản phẩm
        }
    }
    
    // 🚀 LÔ-GIC MẶC ĐỊNH CHO PHÍ VẬN CHUYỂN TRÊN GIAO DIỆN:
    // Vì COD được chọn mặc định, ta đặt shippingFee ban đầu là 50000.
    double shippingFee = 50000; // 🚀 ĐỊNH NGHĨA SHIPPINGFEE LÀ 50000 CHO LẦN TẢI ĐẦU TIÊN
    
    // Giả sử có mã giảm giá (Hardcode để minh họa)
    double discount = 500000;
    
    double grandTotal = tempTotal + shippingFee - discount;
    if (grandTotal < 0) grandTotal = 0;
    
    // Logic tải dữ liệu người dùng
    NguoiDung user = (NguoiDung) session.getAttribute("nguoidung");

    String defaultFullName = (user != null && user.getHoTen() != null) ? user.getHoTen() : "";
    String defaultPhone = (user != null && user.getSoDienThoai() != null) ? user.getSoDienThoai() : "";
    String defaultEmail = (user != null && user.getEmail() != null) ? user.getEmail() : "";
    String defaultAddressDetail = (user != null && user.getDiaChi() != null) ? user.getDiaChi() : "";
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh Toán | Nội Thất Shop</title>
    <link rel="stylesheet" href="css/checkout.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    
    <div class="checkout-container">
        <h1>Tiến Hành Thanh Toán</h1>

        <div class="checkout-content">
            
            <div class="checkout-form">
                
                <form action="OrderServlet" method="POST"> 
                    <section class="section-block">
                        <h2><i class="fas fa-map-marker-alt"></i> Thông tin Giao hàng</h2>
                        
                        <div class="guest-checkout-prompt">
                            <% if (user == null) { %>
                                <p>Bạn đã có tài khoản? <a href="dangnhap.jsp">Đăng nhập ngay</a></p>
                            <% } else { %>
                                <p>Đã đăng nhập với tên: <strong><%= user.getTenDangNhap() %></strong></p>
                            <% } %>
                        </div>
                        
                        <div class="form-group">
                            <label for="fullName">Họ và Tên (*)</label>
                            <input type="text" id="fullName" name="fullName" value="<%= defaultFullName %>" required>
                        </div>
                        <div class="form-group">
                            <label for="phone">Số Điện Thoại (*)</label>
                            <input type="tel" id="phone" name="phone" value="<%= defaultPhone %>" required>
                        </div>
                        <div class="form-group">
                            <label for="email">Email (*)</label>
                            <input type="email" id="email" name="email" value="<%= defaultEmail %>" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="addressDetail">Địa chỉ chi tiết (*)</label>
                            <input type="text" id="addressDetail" name="addressDetail" value="<%= defaultAddressDetail %>" required>
                            </div>
                        
                        <div class="form-group">
                            <label for="notes">Ghi chú cho đơn hàng</label>
                            <textarea id="notes" name="notes" rows="3" placeholder="Ví dụ: Xin giao hàng sau 17h, gọi điện trước khi đến..."></textarea>
                        </div>
                    </section>
                    
                    <section class="section-block">
                        <h2><i class="fas fa-credit-card"></i> Phương thức Thanh toán</h2>
                        
                        <div class="payment-options">
                            <label class="payment-option">
                                <input type="radio" name="paymentMethod" value="cod" checked>
                                <i class="fas fa-truck"></i> Thanh toán khi nhận hàng (COD)
                            </label>
                            <label class="payment-option">
                                <input type="radio" name="paymentMethod" value="momo">
                                <i class="fas fa-wallet"></i> Ví điện tử (Momo, ZaloPay...)
                            </label>
                            <label class="payment-option">
                                <input type="radio" name="paymentMethod" value="card">
                                <i class="fas fa-credit-card-alt"></i> Thẻ Tín dụng/Ghi nợ (Visa, Mastercard)
                            </label>
                            <label class="payment-option">
                                <input type="radio" name="paymentMethod" value="bank">
                                <i class="fas fa-university"></i> Chuyển khoản Ngân hàng
                            </label>
                        </div>
                    </section>

                    <button type="submit" class="place-order-btn">HOÀN TẤT ĐẶT HÀNG</button>
                </form> 
            </div>
            
            <div class="order-summary">
                <h2><i class="fas fa-receipt"></i> Đơn Hàng Của Bạn</h2>
                
                <div class="summary-item-list">
                    
                    <% if (cart != null && !cart.isEmpty()) { %>
                        <% for (CartItem item : cart.values()) { %>
                            <div class="summary-item">
                                <img src="<%= item.getProduct().getHinhAnh() %>" 
                                     alt="<%= item.getProduct().getTenSanPham() %>" 
                                     class="summary-item-img">
                                <div class="summary-item-details">
                                    <p><%= item.getProduct().getTenSanPham() %> (x<%= item.getQuantity() %>)</p>
                                    <span><%= String.format("%,.0f VND", item.getTotalPrice()) %></span>
                                </div>
                            </div>
                        <% } %>
                    <% } else { %>
                        <p>Giỏ hàng trống.</p>
                    <% } %>
                    
                </div>
                
                <hr>
                
                <div class="summary-line">
                    <span>Tạm tính (SP)</span>
                    <span><%= String.format("%,.0f VND", tempTotal) %></span>
                </div>
                <div class="summary-line discount-line">
                    <span>Mã giảm giá</span>
                    <span>-<%= String.format("%,.0f VND", discount) %></span>
                </div>
                <div class="summary-line shipping-line">
                    <span>Phí vận chuyển</span>
                    <span id="summary-shipping-value"><%= String.format("%,.0f VND", shippingFee) %></span>
                </div>
                
                <div class="summary-line total-line">
                    <strong>Tổng Thanh Toán</strong>
                    <strong id="summary-total-value"><%= String.format("%,.0f VND", grandTotal) %></strong>
                </div>
                
                <div class="security-info">
                    <i class="fas fa-shield-alt"></i> Thông tin của bạn được bảo mật tuyệt đối.
                </div>
            </div>
            
        </div>
    </div>
</body>

<script>
    // 1. Khai báo các biến và các phần tử cần thiết
    const COD_FEE = 50000;
    const SUMMARY_SHIPPING = document.getElementById('summary-shipping-value');
    const SUMMARY_TOTAL = document.getElementById('summary-total-value');
    
    // Lấy các giá trị cố định từ JSP
    const tempTotal = <%= tempTotal %>;
    const discount = <%= discount %>;
    
    const paymentOptions = document.querySelectorAll('input[name="paymentMethod"]');

    // 2. Hàm tính toán và cập nhật giao diện
    function updateSummary() {
        let currentShippingFee = 0;
        let selectedMethod = document.querySelector('input[name="paymentMethod"]:checked').value;
        
        // Logic phí vận chuyển: Nếu là COD, tính phí 50,000đ
        if (selectedMethod === 'cod') {
            currentShippingFee = COD_FEE;
            SUMMARY_SHIPPING.innerHTML = formatCurrency(COD_FEE);
        } else {
            // Các phương thức khác: Miễn phí
            currentShippingFee = 0;
            SUMMARY_SHIPPING.innerHTML = 'Miễn phí';
        }
        
        // Tính tổng tiền
        let newGrandTotal = tempTotal + currentShippingFee - discount;
        if (newGrandTotal < 0) newGrandTotal = 0;
        
        SUMMARY_TOTAL.innerHTML = formatCurrency(newGrandTotal);
    }

    // Hàm định dạng tiền tệ
    function formatCurrency(amount) {
        return amount.toLocaleString('vi-VN') + ' VND';
    }

    // 3. Gắn sự kiện khi thay đổi phương thức thanh toán
    paymentOptions.forEach(radio => {
        radio.addEventListener('change', updateSummary);
    });
    
    // Chạy lần đầu để thiết lập trạng thái mặc định (COD)
    updateSummary(); 
</script>
</html>