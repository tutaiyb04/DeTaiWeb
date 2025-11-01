<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css">
        <title>Liên Hệ</title>
    </head>
    <body>
        <jsp:include page="includes/header.jsp" />
           <style>
.contact-section {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    background-color: #fffaf3;
    padding: 50px 60px;
    border-radius: 12px;
    border: 2px solid #c45a00;
    width: 80%;
    margin: 50px auto;
    box-shadow: 0 6px 15px rgba(0,0,0,0.1);
    gap: 40px;
    flex-wrap: wrap;
}

/* --- Cột bên trái: Thông Tin Liên Hệ --- */
.contact-info {
    flex: 1;
    min-width: 300px;
    font-size: 19px;
    line-height: 1.9;
    color: #3a2a18;
}

.contact-info h3 {
    color: #c45a00;
    font-size: 26px;
    font-weight: 700;
    margin-bottom: 20px;
}

.contact-info b {
    color: #2a1e0a;
}

.contact-info a {
    color: #c45a00;
    text-decoration: none;
    font-weight: 500;
}

.contact-info a:hover {
    text-decoration: underline;
}

/* --- Cột bên phải: Form gửi tin nhắn --- */
.contact-form {
    flex: 1;
    min-width: 350px;
    background: #fff;
    border: 1px solid #c45a00;
    border-radius: 10px;
    padding: 25px 30px;
    box-shadow: 0 3px 10px rgba(0,0,0,0.05);
}

.contact-form h3 {
    color: #c45a00;
    font-size: 24px;
    font-weight: 700;
    margin-bottom: 20px;
    text-align: center;
}

.contact-form input,
.contact-form textarea {
    width: 100%;
    padding: 12px;
    margin-bottom: 15px;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 16px;
    outline: none;
}

.contact-form input:focus,
.contact-form textarea:focus {
    border-color: #c45a00;
    box-shadow: 0 0 4px rgba(196, 90, 0, 0.3);
}

.contact-form button {
    width: 100%;
    background-color: #c45a00;
    color: white;
    font-size: 18px;
    font-weight: 600;
    border: none;
    padding: 12px;
    border-radius: 8px;
    cursor: pointer;
    transition: 0.3s;
}

.contact-form button:hover {
    background-color: #a44a00;
}
</style>

<div class="contact-section">
    <!-- Cột trái: Thông Tin Liên Hệ -->
    <div class="contact-info">
        <h3>🔑 Thông Tin Liên Hệ</h3>
        <p><b>Địa chỉ:</b> Số 218, Đường Lĩnh Nam, Vĩnh Hưng, Hoàng Mai, Hà Nội</p>
        <p><b>Hotline:</b> <a href="tel:0344076552">0344 076 552</a></p>
        <p><b>Email:</b> <a href="mailto:daominhtuan584@gmail.com">daominhtuan584@gmail.com</a></p>
        <p><b>Giờ làm việc:</b> Thứ 2 – CN: 8h00 – 21h00</p>
    </div>

    <!-- Cột phải: Form Gửi Tin Nhắn -->
    <div class="contact-form">
        <h3>📞 Gửi Tin Nhắn</h3>
     <form action="SendMailServlet" method="post">
    <input type="text" name="name" placeholder="Họ và tên" required>
    <input type="email" name="email" placeholder="Email" required>
    <textarea name="message" rows="4" placeholder="Nội dung liên hệ..." required></textarea>
    <button type="submit">Gửi Ngay</button>
</form>
    </div>
</div>
        <jsp:include page="includes/footer.jsp" />
    </body>
</html>
