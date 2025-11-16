<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác Nhận Đơn Hàng</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 20px; }
        .confirmation-box { max-width: 600px; margin: 50px auto; background-color: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); text-align: center; }
        .confirmation-box h1 { color: #4CAF50; font-size: 28px; margin-bottom: 15px; }
        .confirmation-box i.fa-check-circle { font-size: 50px; color: #4CAF50; margin-bottom: 20px; }
        .confirmation-box p { font-size: 16px; color: #555; line-height: 1.6; }
        .confirmation-box a { display: inline-block; padding: 10px 20px; margin-top: 25px; background-color: #007bff; color: white; text-decoration: none; border-radius: 4px; transition: background-color 0.3s; }
        .confirmation-box a:hover { background-color: #0056b3; }
    </style>
</head>
<body>

    <div class="confirmation-box">
        <i class="fas fa-check-circle"></i>
        <h1>ĐẶT HÀNG THÀNH CÔNG!</h1>
        <p>Cảm ơn quý khách đã tin tưởng và đặt hàng tại Nội Thất Shop.</p>
        
        <% 
            // Lấy ID đơn hàng từ URL (OrderServlet gửi kèm theo)
            String orderId = request.getParameter("orderId");
            if (orderId != null) {
        %>
            <p style="font-size: 18px; font-weight: bold; color: #333;">Mã đơn hàng của quý khách là: #<%= orderId %></p>
        <% } %>
        
        <p>Đơn hàng của bạn đang được xử lý. Chúng tôi sẽ liên hệ sớm để xác nhận chi tiết giao hàng.</p>
        
        <a href="index.jsp">Quay về Trang chủ</a>
    </div>

</body>
</html>