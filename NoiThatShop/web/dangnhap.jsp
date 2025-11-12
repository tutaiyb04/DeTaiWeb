<!DOCTYPE html>
<html lang="vi">
<head>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <title>Đăng nhập</title>
    <style>
        body { 
            font-family: "Segoe UI", sans-serif;
            background: #f5f2eb; 
        }
        
        .box { 
            width: 450px; 
            margin: 80px auto; 
            background: white; 
            border-radius: 10px; 
            padding: 40px; 
            box-shadow: 0 2px 10px rgba(0,0,0,0.2); 
        }
        h2 { 
            color: #b45f06; 
            text-align: center; 
        }
        input { 
            width: 100%; 
            padding: 10px; 
            margin: 10px 0; 
            border: 1px solid #ccc; 
            border-radius: 5px; 
        }
        button { 
            width: 100%; 
            padding: 10px; 
            background: #b45f06; 
            color: white; 
            border: none; 
            border-radius: 5px; 
            font-weight: bold; 
            cursor: pointer; 
        }
        /* Thay thế các khối CSS gây lỗi từ dòng 40 trở đi bằng code này */
        .auth-links-container{
            margin-top: 15px;
        }
        
        .auth-links-row{
            width: 100%;
            display: flex;
            justify-content: space-between;
            flex-wrap: nowrap;
            margin-bottom: 5px;
            padding: 0;
        }
        .auth-links-row a{
            white-space: nowrap;
            text-decoration: none;
            color: #b45f06;
        }
        
        .home-link-container {
            margin-top: 10px;
            text-align: center;
        }
        
        .home-link-container a{
            text-decoration: none;
            color: #b45f06;
        }
    </style>
</head>
<body>
    <div class="box">
        <h2>Đăng nhập</h2>

        <% if (request.getParameter("error") != null) { %>
            <p style="color:red;">Tên đăng nhập hoặc mật khẩu không đúng.</p>
        <% } %>

        <% if (request.getParameter("success") != null) { %>
            <p style="color:green;">Đăng ký thành công! Mời bạn đăng nhập.</p>
        <% } %>

        <form action="dangnhap" method="post">
            <input type="text" name="tenDangNhap" placeholder="Tên đăng nhập" required>
            <input type="password" name="matKhau" placeholder="Mật khẩu" required>
            <button type="submit">Đăng nhập</button>
        </form>
     
        <div class="auth-links-container">
            <div class="auth-links-row">
                <a href="dangky.jsp">Chưa có tài khoản? Đăng ký ngay</a>
                <a href="quenmatkhau.jsp">Quên mật khẩu?</a>
            </div>

            <div class="home-link-container">
                <a href="index.jsp">Về trang chủ</a>
            </div>
        </div>
    </div>
</body>
</html>
