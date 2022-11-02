<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%-- UI 없는 process 기능용 페이지이기 떄문에 불필요한 코드 다 삭제 --%>

<%@include file="dbconn.jsp"%>
<%
  int seq = Integer.parseInt(request.getParameter("seq"));

  String sql = "UPDATE board SET deleted_yn = 'Y' ";
  sql += "WHERE seq = ?";

  PreparedStatement pstmt = null;

  try {
    pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, seq);
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

//  다 끝나면 원래 페이지로 돌아가야함
  response.sendRedirect("boardList.jsp");
%>
