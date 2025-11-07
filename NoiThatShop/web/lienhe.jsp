<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/lienhestyle.css">
        <title>Liên Hệ</title>
    </head>
    
    <body class="page-container"> 
        
        <div class="content-wrap">

            <jsp:include page="includes/header.jsp" />

            <div class="contact-section">
                <div class="contact-info">
                    <h3>🔑 Thông Tin Liên Hệ</h3>
                    <p><b>Địa chỉ:</b> Số 218, Đường Lĩnh Nam, Vĩnh Hưng, Hoàng Mai, Hà Nội</p>
                    <p><b>Hotline:</b> <a href="tel:0344076552">0344 076 552</a></p>
                    <p><b>Email:</b> <a href="mailto:daominhtuan584@gmail.com">daominhtuan584@gmail.com</a></p>
                    <p><b>Giờ làm việc:</b> Thứ 2 – CN: 8h00 – 21h00</p>
                </div>

                <div class="contact-form">
                    <h3>📞 Gửi Tin Nhắn</h3>

                    <%
                        String status = request.getParameter("msg");
                        if ("success".equals(status)) {
                    %>
                        <p class="msg-success">✅ Gửi tin nhắn thành công!</p>
                    <%
                        } else if ("error".equals(status)) {
                    %>
                        <p class="msg-error">❌ Gửi tin nhắn thất bại. Vui lòng thử lại!</p>
                    <%
                        }
                    %>

                    <form action="${pageContext.request.contextPath}/SendMailServlet" method="post">
                        <input type="text" name="name" placeholder="Họ và tên" required>
                        <input type="email" name="email" placeholder="Email" required>
                        <textarea name="message" rows="4" placeholder="Nội dung liên hệ..." required></textarea>
                        <button type="submit">Gửi Ngay</button>
                    </form>
                </div>
            </div>

        </div> <jsp:include page="includes/footer.jsp" />      
    </body>
</html>