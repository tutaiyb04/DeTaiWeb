<%
    session.invalidate(); // Xoá t?t c? thông tin session
    response.sendRedirect("dangnhap.jsp");
%>
