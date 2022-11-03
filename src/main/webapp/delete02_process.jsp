<%-- PreparedStatement 를 사용해준다는 차이점밖에 없음 --%>
<%-- conn객체를 이용해 만들어 줄때 (conn.createStatement()) 바로 sql문 넣어줌 -> [pstmt = conn.createStatement(sql]) --%>
<%-- rs = stmt.executeQuery(sql); <-- 코드가 필요가 없음 --%>

<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
            crossorigin="anonymous"></script>
</head>
<body>
<%@ include file="dbconn.jsp" %>

<%
    request.setCharacterEncoding("utf-8");

    String userId = request.getParameter("userId");
    String userPw = request.getParameter("userPw");

    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        String sql = "SELECT id, passwd FROM member ";
        sql += "WHERE id = ? ";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userId);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String rid = rs.getString("id");
            String rpw = rs.getString("passwd");

            if (userId.equals(rid) && userPw.equals(rpw)) {
                sql = "DELETE FROM member ";
                sql += "WHERE id = ? ";

                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, userId);
                pstmt.executeUpdate();
                out.println("member 테이블의 데이터를 삭제하였습니다.");
            }
            else {
                out.println("비밀번호가 틀렸습니다.");
            }
        }
        else {
            out.println("일치하는 사용자가 없습니다.");
        }
    }
    catch (SQLException e) {
        out.println("SQLException : " + e.getMessage());
    }
    finally {
        if (rs != null) { rs.close(); }
        if (pstmt != null) { pstmt.close(); }
        if (conn != null) { conn.close(); }
    }
%>
</body>
</html>





