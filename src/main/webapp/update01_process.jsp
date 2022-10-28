<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>DB 사용하기 - Statement (update)</title>

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


  Statement stmt = null;
  ResultSet rs = null;

  try {
    String sql = "SELECT id, passwd FROM member ";
    sql += "WHERE id = '" + userId + "' ";

//  Statement 객체 생성
    stmt = conn.createStatement();
//  Statement로 DB에 쿼리를 전송, 결과값을 ResultSet으로 받아옴
    rs = stmt.executeQuery(sql);

    if (rs.next()) {
      String rid = rs.getString("id");
      String rpw = rs.getString("passwd");

//      새로 추가된 코드
//      사용자가 입력한 비밀번호와 DB에 저장된 비밀번호가 같은지 확인
      if (userId.equals(rid) && userPw.equals(rpw)) {
        sql = "UPDATE member SET name = '" + userNm + "' ";
        sql += "WHERE id = '" + userId + "' ";

//        Statement 객체를 새로 생성
        stmt = conn.createStatement();
//        DB서버로 쿼리 전송
        stmt.executeUpdate(sql);
        out.println("member 테이블의 데이터를 수정하였습니다.");
      }
      else {
//        id는 맞는데 비밀번호는 틀릴떄
        out.println("비밀번호가 틀렸습니다.");
      }
    }
    else {
//      쿼리문에 where문을 id로 검색했기 때문
      out.println("일치하는 사용자가 없습니다.");
    }
  }
  catch (SQLException e) {
    out.println("SQLException : " + e.getMessage());
  }
  finally {
    if (rs != null) {
      rs.close();
    }
    if (stmt != null) {
      stmt.close();
    }
    if (conn != null) {
      conn.close();
    }
  }
%>
</body>
</html>
