/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailUtil {
    // THÔNG TIN CẤU HÌNH GỬI EMAIL (Bạn phải sử dụng Mật khẩu ứng dụng - App Password của Gmail)
    private static final String ADMIN_EMAIL = "daominhtuan584@gmail.com";
    private static final String ADMIN_PASSWORD = "lsqamewvhfaoizxa"; // Mật khẩu ứng dụng

    private static Properties getMailProperties() {
        Properties props = new Properties();
        // Cấu hình SMTP SSL/TLS cho Gmail
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true"); 
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        return props;
    }

    /**
     * Gửi email đặt lại mật khẩu đến người dùng.
     * @param recipientEmail Email người dùng nhận.
     * @param resetToken Mã token khôi phục mật khẩu.
     * @return true nếu gửi thành công.
     */
    public static boolean sendResetEmail(String recipientEmail, String resetToken) {
        Session session = Session.getInstance(getMailProperties(), new jakarta.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(ADMIN_EMAIL, ADMIN_PASSWORD);
            }
        });

        try {
            MimeMessage msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(ADMIN_EMAIL));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            msg.setSubject("Yêu cầu Đặt lại Mật khẩu Nội Thất THTShop", "UTF-8");

            // Địa chỉ trang đặt lại mật khẩu (CẦN THAY THẾ 'localhost:8080' BẰNG DOMAIN THỰC TẾ)
            String resetLink = "http://localhost:8080/NoiThatShop/datlaimatkhau?token=" + resetToken;
            
            String content = "Chào bạn,\n\n"
                    + "Chúng tôi nhận được yêu cầu đặt lại mật khẩu cho tài khoản của bạn. Vui lòng nhấp vào liên kết dưới đây:\n\n"
                    + resetLink + "\n\n"
                    + "Liên kết này sẽ hết hạn sau 60 phút.\n"
                    + "Nếu bạn không thực hiện yêu cầu này, vui lòng bỏ qua email này.\n\n"
                    + "Trân trọng,\n"
                    + "Đội ngũ hỗ trợ THTShop.";

            msg.setText(content, "UTF-8");
            msg.setHeader("Content-Type", "text/plain; charset=UTF-8");

            Transport.send(msg);
            System.out.println("Email khôi phục đã được gửi thành công đến: " + recipientEmail);
            return true;

        } catch (MessagingException e) {
            System.err.println("Lỗi gửi email đến " + recipientEmail + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
