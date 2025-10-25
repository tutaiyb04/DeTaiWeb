package com.fshop.dao;

import com.fshop.model.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import util.DBConection;


public class ProductDAO {
    public List<Product> listAll() throws Exception {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM san_pham";

        try (Connection conn = DBConection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setIdDanhMuc(rs.getInt("id_danh_muc"));
                p.setMaSanPham(rs.getString("ma_san_pham"));
                p.setTenSanPham(rs.getString("ten_san_pham"));
                p.setMoTa(rs.getString("mo_ta"));
                p.setGia(rs.getDouble("gia"));
                p.setHinhAnh(rs.getString("hinh_anh"));
                p.setMoi(rs.getBoolean("moi"));
                p.setNoiBat(rs.getBoolean("noi_bat"));
                p.setGiamGia(rs.getBoolean("giam_gia"));
                list.add(p);
            }
        }
        return list;
    }
    
    // Lấy sản phẩm theo danh mục (id_danh_muc)
    public List<Product> getProductsByCategory(int categoryId) throws Exception {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM san_pham WHERE id_danh_muc = ?";
        
        try (Connection conn = DBConection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            
            ps.setInt(1, categoryId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product();
                    p.setId(rs.getInt("id"));
                    p.setIdDanhMuc(rs.getInt("id_danh_muc"));
                    p.setMaSanPham(rs.getString("ma_san_pham"));
                    p.setTenSanPham(rs.getString("ten_san_pham"));
                    p.setMoTa(rs.getString("mo_ta"));
                    p.setGia(rs.getDouble("gia"));
                    p.setHinhAnh(rs.getString("hinh_anh"));
                    p.setMoi(rs.getBoolean("moi"));
                    p.setNoiBat(rs.getBoolean("noi_bat"));
                    p.setGiamGia(rs.getBoolean("giam_gia"));
                    list.add(p);
                }
            }
        }
        return list;
    }
}
