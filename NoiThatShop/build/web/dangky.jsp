<!DOCTYPE html>
<html>
<head>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <title>Đăng ký tài khoản</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 400px;
            margin: 50px auto;
            background-color: white;
            padding: 30px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 10px;
        }

        h2 {
            text-align: center;
            color: #d2691e;
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        input[type="tel"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            width: 100%;
            background-color: #d2691e;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }

        input[type="submit"]:hover {
            background-color: #a0522d;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Đăng ký tài khoản</h2>
    <form action="dangky" method="post">
    <label>Tên đăng nhập:</label>
    <input type="text" name="tenDangNhap" required>

    <label>Họ tên:</label>
    <input type="text" name="hoTen" required>

    <label>Email:</label>
    <input type="email" name="email" required>

    <label>Số điện thoại:</label>
    <input type="tel" name="soDienThoai" required>

    <label>Địa chỉ:</label>
    <input type="text" name="diaChi">

    <label>Mật khẩu:</label>
    <input type="password" name="matKhau" required>

    <input type="submit" value="Đăng ký">
</form>
    <p style="text-align:center;">
        <a href="dangnhap.jsp">Đã có tài khoản? Đăng nhập ngay</a>
    </p>
    
    <p style="text-align:center;">
        <a href="index.jsp">Về trang chủ</a>
    </p>
</div>

</body>
</html>
