<%-- 
    Document   : datlaimatkhau
    Created on : Nov 11, 2025, 5:39:19 PM
    Author     : FPT SHOP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đặt Lại Mật Khẩu Mới</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap');
             body{
            font-family: 'Inter', sans-serif;
            background: #f5f2eb;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
            box-sizing: border-box;
        }
        
        .box{
            background: white;
            padding: 40px 30px;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
            text-align: center;
            transition: all 0.3s ease;
        }
        
        h2{
            margin-bottom: 30px;
            color: #b45f06; /* Màu nâu chủ đạo */
            font-size: 1.8rem;
            font-weight: 700;
        }
        
        /* Message Styles */
        .message {
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 8px;
            text-align: left;
            font-size: 0.9rem;
            font-weight: 600;
        }
        
        .message.error {
            background-color: #fee2e2;
            color: #dc2626;
            border: 1px solid #dc2626;
        }

        .message.success {
            background-color: #d1fae5;
            color: #059669;
            border: 1px solid #059669;
        }

        input[type="password"] {
            width: 100%;
            padding: 14px 18px;
            margin-bottom: 15px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 1rem;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        input[type="password"]:focus {
            border-color: #b45f06;
            outline: none;
            box-shadow: 0 0 0 3px rgba(180, 95, 6, 0.2);
        }
        
        button[type="submit"] {
            width: 100%;
            background-color: #b45f06;
            color: white;
            padding: 15px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 600;
            transition: background-color 0.3s, transform 0.1s;
            margin-top: 5px;
        }

        button[type="submit"]:hover {
            background-color: #6b3f0a;
            transform: translateY(-1px);
        }
        
        .auth-links-container {
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #e2e8f0;
        }
        
        .auth-links-container a {
            color: #b45f06; 
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 500;
            transition: color 0.2s;
        }
        
        .auth-links-container a:hover {
            color: #924c04; 
            text-decoration: underline;
        }
        
        /* Responsive adjustments */
        @media (max-width: 480px) {
            .box { padding: 30px 20px; margin: 10px; }
            h2 { font-size: 1.6rem; }
        }
        </style>
    </head>
    <body>
         <div class="box">
        <h2>Đặt Lại Mật Khẩu</h2>
        
        <% 
            String token = request.getParameter("token");
            String error = request.getParameter("error");
            String success = request.getParameter("success");
        %>
        
        <%-- Ưu tiên hiển thị thông báo thành công trước --%>
        <% if ("true".equals(success)) { %>
            <p class="message success">
                ✅ Chúc mừng! Mật khẩu của bạn đã được đặt lại thành công.
            </p>
            <div class="auth-links-container">
                <a href="dangnhap.jsp">Đi đến trang Đăng nhập</a>
            </div>

        <% } else if (error != null) { %>
            <p class="message error">
                <%
                    if ("expired".equals(error)) {
                        out.print("Liên kết khôi phục đã hết hạn. Vui lòng gửi yêu cầu đặt lại mật khẩu mới.");
                    } else if ("mismatch".equals(error)) {
                        out.print("Mật khẩu mới và mật khẩu xác nhận không khớp.");
                    } else if ("not_found".equals(error)) {
                        out.print("Token không hợp lệ. Vui lòng kiểm tra lại liên kết.");
                    } else if ("system_error".equals(error)) {
                        out.print("Lỗi hệ thống. Vui lòng thử lại sau.");
                    } else {
                        out.print("Có lỗi xảy ra. Vui lòng thử lại.");
                    }
                %>
            </p>

        <% } else if (token == null || token.isEmpty()) { %>
            <p class="message error">
                Liên kết khôi phục không hợp lệ. Vui lòng quay lại trang Quên Mật Khẩu để gửi yêu cầu mới.
            </p>
            <div class="auth-links-container">
                <a href="quenmatkhau.jsp">Quay lại Quên Mật Khẩu</a>
            </div>

        <% } %>

        <%-- Chỉ hiển thị form khi có token hợp lệ và chưa thành công --%>
        <% if (token != null && !token.isEmpty() && success == null) { %>
            <p style="font-size: 0.95rem; color: #475569; margin-bottom: 25px;">
                Vui lòng nhập mật khẩu mới cho tài khoản của bạn.
            </p>

            <form action="datlaimatkhau" method="post">
                <input type="hidden" name="token" value="<%= token %>"> 
                <input type="password" name="matKhauMoi" placeholder="Mật khẩu mới (ít nhất 6 ký tự)" required minlength="6">
                <input type="password" name="xacNhanMatKhau" placeholder="Xác nhận mật khẩu mới" required minlength="6">
                <button type="submit">Đặt Lại Mật Khẩu</button>
            </form>

            <div class="auth-links-container">
                <a href="dangnhap.jsp">Quay lại Đăng nhập</a>
            </div>
        <% } %>  
    </div>
    </body>
</html>
