package com.fshop.dao;

import java.sql.*;
import com.fshop.model.NguoiDung;
import java.util.Calendar;

public class NguoiDungDAO {
    private final Connection conn;

    public NguoiDungDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean dangKy(NguoiDung user) {
        String sql = "INSERT INTO nguoi_dung (ten_dang_nhap, ho_ten, email, so_dien_thoai, dia_chi, mat_khau) VALUES (?,?,?,?,?,?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user.getTenDangNhap());
            ps.setString(2, user.getHoTen());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getSoDienThoai());
            ps.setString(5, user.getDiaChi());
            ps.setString(6, user.getMatKhau());
            int i = ps.executeUpdate();
            return i == 1;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public NguoiDung dangNhap(String tenDangNhap, String matKhau) {
        NguoiDung user = null;
        String sql = "SELECT * FROM nguoi_dung WHERE ten_dang_nhap=? AND mat_khau=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, tenDangNhap);
            ps.setString(2, matKhau);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new NguoiDung();
                user.setId(rs.getInt("id"));
                user.setTenDangNhap(rs.getString("ten_dang_nhap"));
                user.setHoTen(rs.getString("ho_ten"));
                user.setEmail(rs.getString("email"));
                // 🚀 THÊM CÁC THÔNG TIN THIẾU
                user.setSoDienThoai(rs.getString("so_dien_thoai")); 
                user.setDiaChi(rs.getString("dia_chi"));           
            }
        } catch (SQLException e) {
            // ...
        }
        return user;
    }
    
    /**
     * Phương thức mới: Tìm kiếm người dùng bằng email HOẶC tên đăng nhập.
     * @param input Email hoặc tên đăng nhập.
     * @return Email của người dùng nếu tìm thấy, ngược lại là null.
     */
    public String timEmailHoacTenDangNhap(String input) {
        String emailTimThay = null;
        String sql = "SELECT email FROM nguoi_dung WHERE email = ? OR ten_dang_nhap = ?";
        
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, input);
            ps.setString(2, input);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    emailTimThay = rs.getString("email");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Lỗi truy vấn tìm kiếm tài khoản: " + e.getMessage());
        }
        return emailTimThay;
    }
    
     /**
     * Phương thức mới: Lưu reset token và thời gian hết hạn vào DB.
     * Yêu cầu bảng nguoi_dung phải có cột 'reset_token' và 'token_expiry'.
     * @param input Email hoặc tên đăng nhập.
     * @param resetToken Mã token duy nhất.
     * @return true nếu cập nhật thành công, false nếu thất bại.
     */
    public boolean luuResetToken(String input, String resetToken) {
        // Token hết hạn sau 60 phút
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.MINUTE, 60); 
        Timestamp expiryTime = new Timestamp(calendar.getTimeInMillis());

        String sql = "UPDATE nguoi_dung SET reset_token = ?, token_expiry = ? WHERE email = ? OR ten_dang_nhap = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, resetToken);
            ps.setTimestamp(2, expiryTime);
            ps.setString(3, input);
            ps.setString(4, input);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Lỗi khi lưu Reset Token vào DB: " + e.getMessage());
            return false;
        }
    }
    
    /**
    * Kiểm tra xem token có hợp lệ (tồn tại và chưa hết hạn) hay không.
    * @param token Mã token cần kiểm tra
    * @return true nếu token hợp lệ, ngược lại là false.
    */
    public boolean kiemTraTokenHopLe(String token) {
        String sql = "SELECT COUNT(*) FROM nguoi_dung WHERE reset_token = ? AND token_expiry > NOW()";
        
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, token);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // Nếu đếm được 1 (rs.getInt(1) == 1), token hợp lệ
                    return rs.getInt(1) == 1;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
    * Cập nhật mật khẩu mới và xóa token khôi phục khỏi DB.
    * @param token Mã token để xác định người dùng
    * @param matKhauMoi Mật khẩu mới của người dùng (chưa được mã hóa/hashed)
    * @return true nếu cập nhật thành công, ngược lại là false.
    */
    public boolean datLaiMatKhau(String token, String matKhauMoi) {
        // Lưu ý: Trong thực tế, bạn cần HASH (mã hóa) matKhauMoi trước khi lưu!
        String sql = "UPDATE nguoi_dung SET mat_khau = ?, reset_token = NULL, token_expiry = NULL WHERE reset_token = ?";
        
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, matKhauMoi); // *Nên mã hóa mật khẩu này*
            ps.setString(2, token);
            
            // executeUpdate() trả về số hàng bị ảnh hưởng. Nếu là 1, cập nhật thành công.
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}