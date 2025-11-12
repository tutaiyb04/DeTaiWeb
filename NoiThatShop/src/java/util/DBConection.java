package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConection {
    // SỬA: Thêm tham số serverTimezone=UTC để đồng bộ múi giờ với MySQL
    private static final String URL = "jdbc:mysql://localhost:3306/noithat_db";
    private static final String USER = "root";
    private static final String PASSWORD = ""; 
    
    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
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