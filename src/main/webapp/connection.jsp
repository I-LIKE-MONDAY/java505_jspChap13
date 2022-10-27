<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<%
  Connection conn = null;

  try {
//    접속할 주소, id, pw 설정
    String url = "jdbc:mysql://localhost:3306/javadb";
    String userId = "test1";
    String userPw = "java505";

//    드라이버 사용
    Class.forName("com.mysql.cj.jdbc.Driver");
//    DriverManager에 getConnection()을 통해 접속 -> 정상 : conn에 객체를 넘겨주고 실패 : 연결실패 출력 후 conn이 닫힘
    conn = DriverManager.getConnection(url, userId, userPw);
    out.println("데이터 베이스 연결이 성공하였습니다.");
  }
  catch (SQLException e) {
    out.println("데이터 베이스 연결이 실패했습니다.");
    out.println("SQLException : " + e.getMessage());
  }
  finally {
//    접속 해제 부분 : if 없이 그냥 conn.close(); 하면 안됨.
    if (conn != null) {
      conn.close();
    }
  }
%>
</body>
</html>
