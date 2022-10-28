<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>DB 사용하기 - PreparedStatement (update)</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<%@ include file="dbconn.jsp"%>

<%
  request.setCharacterEncoding("UTF-8");

  String userId = request.getParameter("userId");
  String userPw = request.getParameter("userPw");
  String userNm = request.getParameter("userName");

  PreparedStatement pstmt = null;
  ResultSet rs = null;

  try {
//    PreparedStatement를 사용하여 sql 쿼리문이 변경됨
    String sql = "SELECT id, passwd FROM member ";
//    id만 가져옴
    sql += "WHERE id = ? ";

//    PreparedStatement 객체 생성 시 사용할 SQL문을 적용(먼저 적용 -> 나중에 값 바꾸는 형태)
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, userId);
    rs = pstmt.executeQuery();

    if (rs.next()) { // 데이터가 있는지 없는지 확인(입력한 id가 DB에 있는지)
      String rid = rs.getString("id");
      String rpw = rs.getString("passwd");

      if  (userId.equals(rid) && userPw.equals(rpw)) {
        sql = "UPDATE member SET name = ? ";
        sql += "WHERE id = ? ";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userNm);
        pstmt.setString(2, userId);
        pstmt.executeUpdate();

        out.println("member 테이블의 정보를 수정하였습니다.");
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
    out.println("SQLException = " + e.getMessage());
  }
  finally {
    if (rs != null) {
      rs.close();
    }
    if (pstmt != null) {
      pstmt.close();
    }
    if (conn != null) {
      conn.close();
    }
  }
%>
</body>
</html>
