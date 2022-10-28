<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sound.midi.MidiFileFormat" %>
<!DOCTYPE html>
<html>
<head>
    <title>DB 사용하기 - Statement(select)</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<%@ include file="dbconn.jsp"%>

<div class="container mt-4">
  <div class="row">
    <div class="col-sm-6 mx-auto">
      <table class="table table-hover table-striped">
        <thead>
          <tr>
            <th>아이디</th>
            <th>비밀번호</th>
            <th>이름</th>
          </tr>
        </thead>
        <tbody>
        <%
          ResultSet rs = null;
          Statement stmt = null;
          try {
            String sql = "SELECT * FROM member ";
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
//              dbconn 의 변수와 동일한 변수를 쓰면 안됨 (passwd 사용x)
              String userId = rs.getString("id"); //varChar
              String userPw = rs.getString("passwd"); //varChar
              String userNm = rs.getString("name"); //varChar
              %>
                <tr>
                  <td><%=userId%></td>
                  <td><%=userPw%></td>
                  <td><%=userNm%></td>
                </tr>
              <%
            }
          }
          catch (SQLException e) {
            out.println("member 테이블의 데이터 조회가 실패했습니다.");
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
        </tbody>
      </table>
    </div>
  </div>
</div>
</body>
</html>
