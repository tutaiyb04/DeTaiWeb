<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Random" %> 
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh Toán Bằng QR</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 20px; }
        .payment-box { max-width: 500px; margin: 50px auto; background-color: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); text-align: center; }
        .payment-box h1 { color: #d82d8b; font-size: 24px; margin-bottom: 20px; }
        .qr-code img { 
            /* Đảm bảo kích thước khớp với kích thước trong QrGeneratorServlet (250x250) */
            width: 250px; 
            height: 250px; 
            border: 1px solid #ccc; 
            border-radius: 5px;
            margin: 10px auto;
        }
        .status-message { font-size: 16px; color: #555; line-height: 1.6; margin-top: 15px; }
        .otp-code { color: blue; font-weight: bold; margin-top: 10px; }
        
        /* Style cho nút TIẾP THEO */
        .btn-next {
            display: block;
            width: 80%;
            padding: 12px;
            margin: 20px auto 0;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }
        .btn-next:hover {
            background-color: #0056b3;
        }
    </style>
    
    <% 
        String orderId = request.getParameter("orderId");
        String method = request.getParameter("method");
        
        // TẠO VÀ LƯU MÃ 6 SỐ NGẪU NHIÊN
        Random random = new Random();
        int otpCode = 100000 + random.nextInt(900000); 
        String randomCode = String.valueOf(otpCode);
        
        // Lưu mã ngẫu nhiên vào Session để kiểm tra ở trang sau (BẮT BUỘC)
        session.setAttribute("sentCode", randomCode); 
    %>
    
</head>
<body>

    <div class="payment-box">
        <h1>Xác nhận Mã OTP qua <%= method.toUpperCase() %></h1>
        
        <p class="status-message">Vui lòng sử dụng ứng dụng Ví để quét mã QR **hoặc nhấn TIẾP THEO** để giả lập nhận mã OTP:</p>
        
        <div class="qr-code">
            <img src="qr-generate?code=OTP-<%= randomCode %>-ID<%= orderId %>" alt="Mã QR thanh toán">
        </div>
        
        <p style="margin-top: 20px; font-size: 16px; font-weight: bold; color: #333;">
            Mã OTP đã được tạo và gửi đến điện thoại/ứng dụng của bạn.
        </p>
        <p style="font-size: 14px; color: #555;">
            Sau khi nhận mã, vui lòng nhấn TIẾP THEO để nhập mã và hoàn tất giao dịch.
        </p>
        
        <a href="payment_otp.jsp?orderId=<%= orderId %>&method=<%= method %>" class="btn-next">
            TIẾP THEO
        </a>
    </div>

</body>
</html>