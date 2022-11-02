<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>상세 글 읽기</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        window.addEventListener('DOMContentLoaded', function () {
            const btnList = document.querySelector("#btn-list");
            btnList.addEventListener('click', function () {
                history.back();
            })
        });
    </script>
</head>
<body>
<%--<h1>글읽기 페이지</h1>--%>
<%@include file="dbconn.jsp"%>

<header class="container mt-3">
    <div class="p-5 mb-4 bg-light rounded-3">
        <div class="container-fluid py-4">
            <h1 class="text-center">게시물 상세 글읽기 페이지</h1>
        </div>
    </div>
</header>

<%
// seq를 숫자로 받아줘야함 : 게시판 목록 페이지에서 넘겨받은 글 번호
    int seq = Integer.parseInt(request.getParameter("seq"));

    String title = "";
    String contents = "";
    String userId = "";
    String createDate = "";
    String updateDate = "";
    int cnt = 0;

//    DB 연결
    PreparedStatement pstmt = null;
    ResultSet rs = null;



    try {
        // 조회수 카운트 기능
        String sql = "UPDATE board SET cnt = cnt + 1 WHERE seq = ? ";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, seq);
        pstmt.executeUpdate(); // 현재 sql문데이터 한번 날려주고


        sql = "SELECT seq, title, contents, user_id, create_date, update_date, cnt FROM board ";
        sql += "WHERE seq = ?";
        pstmt = conn.prepareStatement(sql);
//        seq를 숫자로 넣어줘야하니까 setInt
        pstmt.setInt(1, seq);
//        select문 동작시키기 위해
        rs = pstmt.executeQuery();

        if (rs.next()) { // 데이터 들어있는지 확인
            title = rs.getString("title"); // 데이터가 있으면 해당 코드 실행
            contents = rs.getString("contents");
            userId = rs.getString("user_Id");
            createDate = rs.getString("create_date");
            updateDate = rs.getString("update_date");
            cnt = rs.getInt("cnt");

           // out.print(title + "<br>");
           // out.print(contents + "<br>");
           // out.print(userId + "<br>");
           // out.print(createDate + "<br>");
           // out.print(updateDate + "<br>");
           // out.print(cnt + "<br>");
        }
    }
    catch (SQLException e) {
        out.print(e.getMessage());
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
<main class="container mt-5">
    <div class="row">
        <form action="boardUpdate_process.jsp" method="post">
        <div class="col-sm-6 mx-auto">
                <div class="form-floating my-3">
<%--                    임의로 수정하면 안 되는 부분 : readonry 또는 disabled 추가해주면 됨 --%>
                    <input type="text" class="form-control" id="seq" name="seq" placeholder="글번호를 입력하세요" readonly value="<%=seq%>">
                    <label for="seq" class="form-label">Seq</label>
                </div>
                <div class="form-floating my-3">
                    <input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력하세요" value="<%=title%>">
                    <label for="title" class="form-label">Title</label>
                </div>
                <div class="form-floating my-3">
                    <input type="text" class="form-control" id="user-id" name="userId" placeholder="ID를 입력하세요" disabled value="<%=userId%>">
                    <label for="user-id" class="form-label">ID</label>
                </div>
                <div class="form-floating my-3">
                    <input type="text" class="form-control" id="create-date" name="createDate" placeholder="날짜를 입력하세요" readonly value="<%=createDate%>">
                    <label for="create-date" class="form-label">Date</label>
                </div>
                <div class="form-floating my-3">
                    <input type="text" class="form-control" id="board-cnt" name="boardCnt" placeholder="조회수를 입력하세요" readonly value="<%=cnt%>">
                    <label for="board-cnt" class="form-label">Count</label>
                </div>
                <div class="form-floating my-3">
                    <textarea class="form-control" id="contents" name="contents" placeholder="내용을 입력하세요"><%=contents%></textarea>
                    <label for="contents" class="form-label">Contents...</label>
                </div>
                <div class="my-3 row">
                    <div class="col-sm">
                        <button class="btn btn-secondary" type="button" id="btn-list">목록으로</button>
                    </div>
                    <%--                        me = margin end --%>
                    <div class="col-sm d-flex justify-content-end">
                            <button class="btn btn-warning me-2" type="submit">수정</button>
                        </form>
                        <form action="boardDelete_prosess.jsp" method="post">
                            <input type="hidden" name="seq" value="<%=seq%>">
                            <button class="btn btn-danger" type="submit">삭제</button>
                        </form>
                    </div>
                </div>
        </div>
    </div>
</main>

<footer class="container-fluid mt-5 p-5 border-top">
    <p class="lead text-muted text-center">made by bitc java505</p>
</footer>
</body>


</html>
