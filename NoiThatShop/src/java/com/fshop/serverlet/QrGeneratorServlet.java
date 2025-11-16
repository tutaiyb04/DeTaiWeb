package com.fshop.serverlet;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;

@WebServlet("/qr-generate")
public class QrGeneratorServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy mã OTP ngẫu nhiên từ tham số URL
        String otpCode = request.getParameter("code");
        
        if (otpCode == null || otpCode.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Tham số mã QR bị thiếu.");
            return;
        }

        try {
            // Thiết lập Header để trình duyệt biết đây là ảnh PNG
            response.setContentType("image/png");
            
            // 1. Khởi tạo bộ tạo QR (Zxing)
            QRCodeWriter qrCodeWriter = new QRCodeWriter();
            
            // 2. Mã hóa chuỗi OTP thành ma trận Bit
            // Kích thước 250x250 pixels
            BitMatrix bitMatrix = qrCodeWriter.encode(otpCode, BarcodeFormat.QR_CODE, 250, 250);

            // 3. Viết ma trận Bit ra OutputStream dưới dạng ảnh PNG
            OutputStream os = response.getOutputStream();
            MatrixToImageWriter.writeToStream(bitMatrix, "PNG", os);
            os.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi tạo QR code.");
        }
    }
}