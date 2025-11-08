<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng ký thành công</title>
    <style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f3f3f3;
        text-align: center;
        padding-top: 100px;

        /* 🔽 Thêm ảnh nền */
        background-image: url('gallery-phong-khach-picart-01.jpg'); /* Đường dẫn đến ảnh */
        background-size: cover;      /* Ảnh phủ kín màn hình */
        background-position: center; /* Căn giữa ảnh */
        background-repeat: no-repeat;/* Không lặp lại ảnh */
    }

    .success-box {
        background: white;
        display: inline-block;
        padding: 30px 50px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }

    h2 { color: #28a745; }

    a {
        display: inline-block;
        margin-top: 20px;
        background-color: #d2691e;
        color: white;
        padding: 10px 20px;
        border-radius: 5px;
        text-decoration: none;
    }

    a:hover {
        background-color: #a0522d;
    }
</style>
</head>
<body>
<div class="success-box">
    <h2>🎉 Đăng ký thành công!</h2>
    <p>Chào mừng <strong><%= request.getAttribute("tenDangNhap") %></strong> đến với Nội Thất Shop.</p>
    <a href="dangnhap.jsp">👉 Đăng nhập ngay</a>
</div>
    <script>
setTimeout(() => {
    window.location.href = "dangnhap.jsp";
}, 4000);
</script>
</body>
</html>
