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
    
    // Lấy sản phẩm theo danh mục (id_danh_muc) VÀ không giảm giá (giam_gia = 0)
    public List<Product> getProductsByCategoryNonDiscounted(int categoryId) throws Exception {
        List<Product> list = new ArrayList<>();
        // CHỈ LẤY SẢN PHẨM KHÔNG GIẢM GIÁ TRONG DANH MỤC CỤ THỂ
        String sql = "SELECT * FROM san_pham WHERE id_danh_muc = ? AND giam_gia = 0";
        
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
    
    // Lấy tất cả sản phẩm không được giảm giá (giam_gia = 0)
    public List<Product> listAllNonDiscounted() throws Exception
    {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM san_pham WHERE giam_gia = 0";
        
        try (Connection conn = DBConection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery())
        {
            while (rs.next())
            {
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
    
    /**
     * Lấy tất cả sản phẩm đang được giảm giá (giam_gia = 1).
     * @return List<Product> danh sách sản phẩm giảm giá.
     */
    public List<Product> listAllDiscounted() throws Exception {
        List<Product> list = new ArrayList<>();
        // Truy vấn CHỈ LẤY SẢN PHẨM CÓ giam_gia = 1
        String sql = "SELECT * FROM san_pham WHERE giam_gia = 1"; 

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
    
    /**
     * Lấy chi tiết một sản phẩm dựa trên ID.
     * @param productId ID của sản phẩm cần tìm.
     * @return Đối tượng Product hoặc null nếu không tìm thấy.
     */
    public Product getProductById(int productId) throws Exception {
        Product product = null;
        String sql = "SELECT * FROM san_pham WHERE id = ?";

        try (Connection conn = DBConection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) { // Chỉ cần if vì ID là duy nhất
                    product = new Product();
                    product.setId(rs.getInt("id"));
                    product.setIdDanhMuc(rs.getInt("id_danh_muc"));
                    product.setMaSanPham(rs.getString("ma_san_pham"));
                    product.setTenSanPham(rs.getString("ten_san_pham"));
                    product.setMoTa(rs.getString("mo_ta"));
                    product.setGia(rs.getDouble("gia"));
                    product.setHinhAnh(rs.getString("hinh_anh"));
                    product.setMoi(rs.getBoolean("moi"));
                    product.setNoiBat(rs.getBoolean("noi_bat"));
                    product.setGiamGia(rs.getBoolean("giam_gia"));
                }
            }
        }
        return product;
    }
}
