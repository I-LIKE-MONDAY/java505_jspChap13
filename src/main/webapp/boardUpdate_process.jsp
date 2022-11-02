<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%@include file="dbconn.jsp"%>
<%-- 폼만을 이용하는 방식 --%>
<%
  request.setCharacterEncoding("UTF-8");

  int seq = Integer.parseInt(request.getParameter("seq"));
  String title = request.getParameter("title");
  String contents = request.getParameter("contents");

  String sql = "UPDATE board SET title = ?, contents = ?";
  sql += "WHERE seq = ? ";

  PreparedStatement pstmt = null;


  try {
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, title);
    pstmt.setString(2, contents);
    pstmt.setInt(3, seq);
    pstmt.executeUpdate(); // 데이터 보내기
  }
  catch (SQLException e) {
    out.println(e.getMessage());
  }
  finally {
    if (pstmt != null) {
      pstmt.close();
    }
    if (conn != null) {
      conn.close();
    }
  }

  response.sendRedirect("boardList.jsp");
%>