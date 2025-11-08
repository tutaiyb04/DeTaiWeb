package com.fshop.dao;

import java.sql.*;
import com.fshop.model.NguoiDung;

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
            }
        } catch (SQLException e) {
        }
        return user;
    }
}