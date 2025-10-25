/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConection {
    private static final String URL = "jdbc:mysql://localhost:3306/noithat_db";
    private static final String USER = "root";
    private static final String PASSWORD = ""; // nếu bạn không đặt mật khẩu
    
     public static Connection getConnection() {
        Connection conn = null;
        try {
            // Nạp driver MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Kết nối
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✅ Kết nối MySQL thành công!");
        } catch (ClassNotFoundException e) {
            System.out.println("❌ Không tìm thấy driver MySQL: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("❌ Lỗi khi kết nối CSDL: " + e.getMessage());
        }
        return conn;
    }

    public static void main(String[] args) {
        getConnection();
    }
}
