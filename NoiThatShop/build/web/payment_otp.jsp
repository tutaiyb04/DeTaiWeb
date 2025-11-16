<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác Thực Thanh Toán</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* (Style giữ nguyên) */
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 20px; }
        .otp-box { max-width: 400px; margin: 50px auto; background-color: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); text-align: center; }
        .otp-box h1 { color: #2980b9; font-size: 24px; margin-bottom: 20px; }
        .otp-box input[type="text"] { width: 100%; padding: 10px; margin-bottom: 15px; font-size: 18px; text-align: center; border: 2px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .otp-box button { width: 100%; padding: 10px; background-color: #4CAF50; color: white; border: none; border-radius: 4px; cursor: pointer; }
        .error-message { color: red; margin-top: 10px; }
        .success-code { font-weight: bold; color: #4CAF50; }
    </style>
</head>
<body>

    <div class="otp-box">
        <% 
            String orderId = request.getParameter("orderId");
            String attempt = request.getParameter("attempt");
            String method = request.getParameter("method");
            String errorCode = request.getParameter("error");
            
            // 🚀 SỬA LỖI: Lấy mã xác thực (VALID_CODE) trực tiếp từ Session
            String VALID_CODE = (String) session.getAttribute("sentCode"); 
            
            // Nếu truy cập lần đầu từ trang QR, VALID_CODE sẽ là mã ngẫu nhiên.
            // Nếu truy cập lại do lỗi (attempt != null), VALID_CODE vẫn là mã trong Session.
            String SENT_CODE = VALID_CODE; 
        %>
        
        <h1>Xác Thực Thanh Toán <%= method.toUpperCase() %></h1>
        
        <% 
            if (errorCode != null) {
        %>
            <p class="error-message">Mã xác thực không hợp lệ. Vui lòng kiểm tra lại mã đã nhận.</p>
        <%
            }
        %>
        
        <p>Vui lòng nhập **Mã 6 Số** được gửi đến ứng dụng Ví của bạn sau khi quét mã QR.</p>
        
        <p style="font-size: 14px;">(Mã thành công: <span class="success-code"><%= VALID_CODE != null ? VALID_CODE : "N/A" %></span>)</p>

        <form action="payment_otp.jsp" method="POST">
            <input type="hidden" name="orderId" value="<%= orderId %>">
            <input type="hidden" name="method" value="<%= method %>">
            <input type="text" name="otp_input" maxlength="6" placeholder="Nhập Mã 6 Số" required>
            <button type="submit">Xác Nhận Thanh Toán</button>
        </form>
        
        <% 
        // 🚀 LOGIC KIỂM TRA MÃ OTP
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String otpInput = request.getParameter("otp_input");
            
            // KIỂM TRA ĐIỀU KIỆN 1: Mã xác thực có trong session không
            if (SENT_CODE == null) {
                // Mã đã hết hạn hoặc bị xóa khỏi Session.
                // Chuyển hướng người dùng về trang quét mã QR ban đầu.
                // LƯU Ý: Nếu không muốn mất ID đơn hàng, bạn cần chuyển hướng về OrderServlet để tạo lại luồng.
                response.sendRedirect("checkout.jsp?error=session_expired"); 
                return;
            } else if (otpInput.equals(SENT_CODE)) {
                // KIỂM TRA ĐIỀU KIỆN 2: Mã nhập có khớp với mã ngẫu nhiên
                session.removeAttribute("sentCode"); // Xóa mã xác thực
                
                // Chuyển hướng đến trang xác nhận thành công
                response.sendRedirect("confirmation.jsp?orderId=" + orderId + "&status=paid");
                return;
            } else {
                // Mã nhập sai, chuyển hướng về trang này kèm lỗi
                response.sendRedirect("payment_otp.jsp?orderId=" + orderId + "&method=" + method + "&attempt=1&error=invalid");
                return;
            }
        }
        %>
    </div>

</body>
</html>