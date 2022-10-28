<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>문제1. Statement를 사용하여 DELETE 를 실행하는 프로그램 작성</title>

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

    Statement stmt = null;
    ResultSet rs = null;

    try {
//        sql문 지정
//        id 검색
        String sql = "SELECT id, passwd FROM member ";
        sql += "WHERE id = '" + userId + "' ";

//        conn 객체 사용하여 Statement 객체 생성해줌 => dbconn에 연결
        stmt = conn.createStatement();
        rs = stmt.executeQuery(sql);

//        if문으로 확인한 이유 : id(pk키)로 검색했을때는 결과가 단 2개. 있거나 없거나. 있으면 true, 없으면 false
        if (rs.next()) {
            String rid = rs.getString("id");
            String rpw = rs.getString("passwd");

            if (userId.equals(rid) && userPw.equals(rpw)) {
//                DELETE 구문 생성
                sql = "DELETE FROM member ";
                sql += "WHERE id = '" + userId + "' ";
//                기존 객체 버리고 새 객체 생성
                stmt = conn.createStatement();
//                executeUpdate()를 이용해서 DELETE문 실행
                stmt.executeUpdate(sql);

                out.println("member 테이블의 데이터를 삭제했습니다.");
            }
            else {
                out.println("비밀번호가 틀렸습니다.");
            }
        }
        else {
            out.println("지정한 사용자가 없습니다..");
        }
    }
    catch (SQLException e) {
        out.println("member테이블의 데이터를 삭제하지 못했습니다.");
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
