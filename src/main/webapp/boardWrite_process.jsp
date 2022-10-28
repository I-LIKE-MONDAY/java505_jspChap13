<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp"%>

<%
    request.setCharacterEncoding("UTF-8");

    String title = request.getParameter("title");
    String userId = request.getParameter("userId");
    String contents = request.getParameter("contents");

    PreparedStatement pstmt = null;
//    INSERT 해줄거라서 rs 필요없음

    try {
        String sql = "INSERT INTO board (title, contents, user_id, create_date) ";
        sql += "VALUES (?, ?, ?, now()) ";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, title);
        pstmt.setString(2, contents);
        pstmt.setString(3, userId);
        pstmt.executeUpdate();

    }
    catch (SQLException e) {
        out.println("SQLException : " + e.getMessage());
    }
    finally {
        if (pstmt != null) {
            pstmt.close();
        }
        if (conn != null) {
            conn.close();
        }
    }
//  실행 다 되고나면 첫 페이지로 돌아가게 만들기
    response.sendRedirect("boardList.jsp");

%>