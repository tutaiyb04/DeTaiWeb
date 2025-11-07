package com.fshop.serverlet;

import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Properties;

public class SendMailServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        final String adminEmail = "tutaiyb2411@gmail.com";
        final String adminPassword = "cayrznhtooeqmtur"; // ← BỎ KHOẢNG TRẮNG

        // === SMTP SSL – ổn định nhất ===
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true"); // dùng TLS
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com"); 


        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(adminEmail, adminPassword);
            }
        });

        try {
            // Tạo message
            MimeMessage msg = new MimeMessage(session);

            msg.setFrom(new InternetAddress(adminEmail));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(adminEmail));

            // Subject UTF-8
            msg.setSubject("Tin nhắn liên hệ từ khách hàng: " + name, "UTF-8");

            // Nội dung mail UTF-8
            String content = "Tên khách: " + name + "\n"
                    + "Email: " + email + "\n\n"
                    + "Nội dung:\n" + message;

            // Quan trọng: set UTF-8 cho nội dung
            msg.setText(content, "UTF-8");

            // Optional: thêm header đúng chuẩn UTF-8
            msg.setHeader("Content-Type", "text/plain; charset=UTF-8");

            // Gửi mail
            Transport.send(msg);

            response.sendRedirect("lienhe.jsp?msg=success");

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("lienhe.jsp?msg=error");
            }
        }
}
