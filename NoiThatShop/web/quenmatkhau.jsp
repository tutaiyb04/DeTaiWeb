<%-- 
    Document   : quenmatkhau
    Created on : Nov 8, 2025, 4:42:08 PM
    Author     : FPT SHOP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quên Mật Khẩu</title>
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
                color: #b45f06;
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
                background-color: #fee2e2; /* Red-100 */
                color: #dc2626; /* Red-600 */
                border: 1px solid #dc2626;
            }

            .message.success {
                background-color: #d1fae5; /* Green-100 */
                color: #059669; /* Green-600 */
                border: 1px solid #059669;
            }

            input[type="text"], input[type="email"] {
                width: 100%;
                padding: 14px 18px;
                margin-bottom: 15px;
                border: 1px solid #cbd5e1; /* Slate-300 */
                border-radius: 8px;
                box-sizing: border-box;
                font-size: 1rem;
                transition: border-color 0.3s, box-shadow 0.3s;
            }

            input[type="text"]:focus, input[type="email"]:focus {
                border-color: #b45f06;
                outline: none;
                box-shadow: 0 0 0 3px rgba(0, 0, 0 , 0.2);
            }
            
             button[type="submit"] {
                width: 100%;
                background-color: #b45f06; /* Indigo-600 */
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
                background-color: #6b3f0a; /* Indigo-700 */
                transform: translateY(-1px);
            }
            
            .auth-links-container {
                margin-top: 25px;
                padding-top: 20px;
                border-top: 1px solid #e2e8f0; /* Slate-200 */
            }
            .auth-links-row {
                display: flex;
                justify-content: space-between;
                margin-bottom: 15px;
            }
            
            .auth-links-container a, .home-link-container a {
                color: #b45f06; /* Indigo-600 */
                text-decoration: none;
                font-size: 0.9rem;
                font-weight: 500;
                transition: color 0.2s;
            }
            
            .auth-links-container a:hover, .home-link-container a:hover {
                color: #3b82f6; /* Blue-500 */
                text-decoration: none;
            }
            
            .home-link-container {
                margin-top: 15px;
            }
            
            /* Responsive adjustments for smaller screens */
            @media (max-width: 480px) {
            .box {
                padding: 30px 20px;
                margin: 10px;
            }
            h2 {
                font-size: 1.6rem;
            }
            .auth-links-row {
                flex-direction: column;
                gap: 10px;
            }
            .auth-links-container a {
                text-align: center;
                display: block;
            }
        </style>
    </head>
    <body>
        <div class="box">
            <h2>Quên Mật Khẩu</h2>
            <!-- Hiển thị thông báo sau khi Servlet xử lý và chuyển hướng -->
            <% 
                String error = request.getParameter("error");
                String success = request.getParameter("success");
            %>
            
            <% 
                if (error != null) { %>
                <p class="message error">
                <% 
                    if ("not_found".equals(error)) {
                        out.print("Không tìm thấy tài khoản. Email hoặc Tên đăng nhập không tồn tại.");
                    } else if ("invalid_input".equals(error)) {
                        out.print("Vui lòng nhập Email hoặc Tên đăng nhập hợp lệ.");
                    } else if ("email_send_failed".equals(error)) {
                        out.print("Lỗi gửi email. Vui lòng thử lại sau hoặc liên hệ hỗ trợ.");
                    } else {
                        out.print("Lỗi hệ thống không xác định. Vui lòng thử lại.");
                    }
                %>
                </p>
            <% } %>

            <% if (success != null) { %>
                <p class="message success">
                    Yêu cầu đã được gửi thành công. Vui lòng kiểm tra hộp thư email của bạn để lấy liên kết đặt lại mật khẩu. (Liên kết sẽ hết hạn sau 60 phút)
                </p>
            <% } %>
            
            <p font-size: 0.95rem; color: #475569; margin-bottom: 25px;>
                Vui lòng nhập địa chỉ email hoặc Tên đăng nhập của bạn. Chúng tôi sẽ gửi một liên kết đặt lại mật khẩu.
            </p>
            
            <form action="xulyquenmatkhau" method="post">
                <input type="text" name="emailHoacTenDangNhap" placeholder="Email hoặc Tên đăng nhập" required>
                <button type="submit">Gửi Yêu Cầu Đặt Lại</button>
            </form>
            
            <div class="auth-links-container">
                <div class="auth-links-row">
                    <a href="dangnhap.jsp">Quay lại Đăng nhập</a>
                </div>
                
                <div class="home-link-container">
                    <a href="index.jsp">Về trang chủ</a>
                </div>
            </div>
        </div>
    </body>
</html>
