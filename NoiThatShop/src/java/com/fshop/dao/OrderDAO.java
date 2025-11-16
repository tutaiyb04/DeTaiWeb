package com.fshop.dao;

import com.fshop.model.CartItem;
import com.fshop.model.Product; 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Map;
import util.DBConection; // Giả định lớp kết nối DB của bạn

public class OrderDAO {

    private static final String TABLE_ORDER = "don_hang"; 
    private static final String TABLE_ORDER_DETAIL = "chi_tiet_don_hang";
    
    /**
     * Thực hiện giao dịch lưu Đơn hàng (Order) và Chi tiết Đơn hàng (Order Details).
     */
    public int saveOrderTransaction(int userId, String fullName, String phone, String email, 
        String fullAddress, String notes, String paymentMethod,
        double tempTotal, double shippingFee, double discount, double grandTotal,
        Map<Integer, CartItem> cart) throws Exception 
    {
        
        Connection conn = null;
        int newOrderId = -1;
        // 🚀 SỬA: Dùng giá trị tiếng Việt để khớp với cột trang_thai trong DB
        String initialStatus = "Chờ xử lý"; 

        // 1. SQL cho bảng Don_Hang (Sử dụng tên cột DB chính xác và trật tự)
        // Order: id_nguoi_dung, customer_name, address, phone, email, tong_tien, shipping_fee, discount, grand_total, notes, trang_thai, payment_method
        // Order_date được lấy tự động bởi NOW() vì DB có DEFAULT value.
        String insertOrderSQL = "INSERT INTO " + TABLE_ORDER + 
                        " (id_nguoi_dung, customer_name, address, phone, email, tong_tien, shipping_fee, discount, grand_total, notes, trang_thai, payment_method, ngay_tao) " +
                        " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())"; 
                        // 12 tham số (?)

        // 2. SQL cho bảng Chi_Tiet_Don_Hang (Đã đúng: id_don_hang, id_san_pham, so_luong, don_gia)
        String insertDetailSQL = "INSERT INTO " + TABLE_ORDER_DETAIL + 
                                 " (id_don_hang, id_san_pham, so_luong, don_gia) " +
                                 " VALUES (?, ?, ?, ?)";

        try {
            conn = DBConection.getConnection();
            conn.setAutoCommit(false); // Bắt đầu Transaction

            // --- A. LƯU ĐƠN HÀNG CHÍNH ---
            // LƯU Ý: psOrder cần phải có 12 tham số, và phải khớp với trật tự cột ở trên
            try (PreparedStatement psOrder = conn.prepareStatement(insertOrderSQL, Statement.RETURN_GENERATED_KEYS)) {
                
                psOrder.setInt(1, userId);
                psOrder.setString(2, fullName);
                psOrder.setString(3, fullAddress);
                psOrder.setString(4, phone);
                psOrder.setString(5, email);
                
                // Tham số 6 bắt đầu với tong_tien
                psOrder.setDouble(6, tempTotal);     // tong_tien
                psOrder.setDouble(7, shippingFee);   // shipping_fee
                psOrder.setDouble(8, discount);      // discount
                psOrder.setDouble(9, grandTotal);    // grand_total
                psOrder.setString(10, notes);        // notes (Cột đã được sửa trong DB)
                psOrder.setString(11, initialStatus); // trang_thai
                psOrder.setString(12, paymentMethod); // payment_method
                // Index 13 (ngay_tao) dùng NOW()
                
                if (psOrder.executeUpdate() == 0) {
                    throw new SQLException("Lưu đơn hàng thất bại.");
                }

                // Lấy ID đơn hàng vừa tạo
                try (ResultSet rs = psOrder.getGeneratedKeys()) {
                    if (rs.next()) {
                        newOrderId = rs.getInt(1);
                    } else {
                        throw new SQLException("Lưu đơn hàng thất bại, không lấy được ID.");
                    }
                }
            }

            // --- B. LƯU CHI TIẾT ĐƠN HÀNG ---
            try (PreparedStatement psDetail = conn.prepareStatement(insertDetailSQL)) {
                for (CartItem item : cart.values()) {
                    Product product = item.getProduct();
                    
                    psDetail.setInt(1, newOrderId);      // id_don_hang
                    psDetail.setInt(2, product.getId()); // id_san_pham
                    psDetail.setInt(3, item.getQuantity()); // so_luong
                    psDetail.setDouble(4, product.getGia()); // don_gia
                    
                    psDetail.addBatch();
                }
                
                psDetail.executeBatch();
            }

            conn.commit(); 
            return newOrderId;

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback(); 
                } catch (SQLException excep) {
                    excep.printStackTrace();
                }
            }
            // In lỗi chi tiết ra log máy chủ
            e.printStackTrace(); 
            throw new Exception("Lỗi khi thực hiện giao dịch đơn hàng: " + e.getMessage(), e); 
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException excep) {
                    excep.printStackTrace();
                }
            }
        }
    }
}