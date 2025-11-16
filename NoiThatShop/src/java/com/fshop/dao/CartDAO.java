package com.fshop.dao;

import com.fshop.model.CartItem;
import com.fshop.model.Product; 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import util.DBConection;

public class CartDAO { 

    // Tên bảng Giỏ hàng Vĩnh viễn của bạn
    private static final String TABLE_GIO_HANG = "gio_hang";
    private static final String TABLE_SAN_PHAM = "san_pham";
    
    // 1. Tải Giỏ hàng Vĩnh viễn (Sử dụng trong DangNhapServlet)
    /**
     * Tải giỏ hàng từ DB cho người dùng đã đăng nhập.
     * @param userId ID của người dùng.
     * @return Map<ProductId, CartItem>
     */
    public Map<Integer, CartItem> getCartByUserId(int userId) throws Exception {
        Map<Integer, CartItem> cart = new HashMap<>();
        
        String sql = "SELECT gh.product_id, gh.quantity, sp.* " +
                     "FROM " + TABLE_GIO_HANG + " gh " +
                     "JOIN " + TABLE_SAN_PHAM + " sp ON gh.product_id = sp.id " +
                     "WHERE gh.user_id = ?";

        try (Connection conn = DBConection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Tạo đối tượng Product từ ResultSet (Dùng phương thức hỗ trợ)
                    Product p = createProductFromResultSet(rs); 
                    int quantity = rs.getInt("quantity");
                    
                    // Tạo CartItem và thêm vào Map
                    CartItem item = new CartItem(p, quantity);
                    cart.put(p.getId(), item);
                }
            }
        } catch (SQLException e) {
            // Rất quan trọng: Ghi log lỗi SQL để biết lỗi ở đâu
            e.printStackTrace(); 
            throw new Exception("Lỗi khi tải giỏ hàng từ DB.", e);
        }
        return cart;
    }
    
    // 2. Thêm hoặc Cập nhật số lượng sản phẩm trong DB
    
    /**
     * Chèn mới hoặc cập nhật số lượng (quantity) cho một mặt hàng.
     * @param userId ID người dùng.
     * @param productId ID sản phẩm.
     * @param quantity Số lượng mới.
     * @return true nếu thành công.
     */
    public boolean saveOrUpdateCartItem(int userId, int productId, int quantity) throws Exception {

        if (quantity <= 0) {
            return deleteCartItem(userId, productId); 
        }

        // SQL dùng ON DUPLICATE KEY UPDATE: Nếu (user_id, product_id) đã tồn tại, nó cập nhật quantity
        String sql = "INSERT INTO " + TABLE_GIO_HANG + " (user_id, product_id, quantity) " +
                     "VALUES (?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE quantity = ?";
                     
        try (Connection conn = DBConection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ps.setInt(3, quantity);
            ps.setInt(4, quantity); // Tham số thứ 4 cho phần ON DUPLICATE KEY UPDATE

            return ps.executeUpdate() > 0;
        }
    }

    // 3. Xóa một mặt hàng khỏi DB

    /**
     * Xóa một mặt hàng khỏi giỏ hàng.
     * @param userId ID người dùng.
     * @param productId ID sản phẩm.
     * @return true nếu thành công.
     */
    public boolean deleteCartItem(int userId, int productId) throws Exception {
        // 🚀 ĐÃ SỬA: SỬ DỤNG BẢNG gio_hang
        String sql = "DELETE FROM " + TABLE_GIO_HANG + " WHERE user_id = ? AND product_id = ?";

        try (Connection conn = DBConection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            
            return ps.executeUpdate() > 0;
        }
    }
    
    // Phương thức hỗ trợ tạo Product (copy từ ProductDAO, đảm bảo đầy đủ)
    private Product createProductFromResultSet(ResultSet rs) throws SQLException {
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
        return p;
    }
    
    // Thêm vào CartDAO.java
    /**
    * Xóa TẤT CẢ mặt hàng khỏi giỏ hàng của người dùng sau khi đặt hàng thành công.
    * @param userId ID người dùng.
    * @return true nếu thành công.
    */
    public boolean deleteAllCartItems(int userId) throws Exception 
    {
        String sql = "DELETE FROM " + TABLE_GIO_HANG + " WHERE user_id = ?";

        try (Connection conn = DBConection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            
            return ps.executeUpdate() > 0;
        }
    }
}