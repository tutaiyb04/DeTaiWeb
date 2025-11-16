<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lỗi Hệ Thống</title>
</head>
<body>
    <div style="max-width: 600px; margin: 50px auto; text-align: center;">
        <h1 style="color: red;">ĐÃ XẢY RA LỖI TRONG QUÁ TRÌNH XỬ LÝ!</h1>
        <p>Mã lỗi tham chiếu: 
        <%
            // Lấy thông báo lỗi từ URL parameter 'msg'
            String errorMsg = request.getParameter("msg"); 
            if ("SystemError".equals(errorMsg)) {
        %>
                Lỗi hệ thống không xác định. Vui lòng kiểm tra log máy chủ.
        <%  } else if ("DbError".equals(errorMsg)) { %>
                Lỗi cơ sở dữ liệu khi tạo đơn hàng.
        <%  } else if ("emptycart".equals(errorMsg)) { %>
                Giỏ hàng của bạn trống.
        <%  } else { %>
                Lỗi không xác định.
        <%  } %>
        </p>
        <div style="margin-top: 20px;">
            <a href="index.jsp">Quay về Trang chủ</a>
        </div>
    </div>
</body>
</html>