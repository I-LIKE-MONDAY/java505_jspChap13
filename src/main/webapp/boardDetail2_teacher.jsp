<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상세 글 읽기</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
            crossorigin="anonymous"></script>

    <script>
        window.addEventListener('DOMContentLoaded', function () {
            const btnList = document.querySelector('#btn-list');
            const btnUpdate = document.querySelector('#btn-update');
            const btnDelete = document.querySelector('#btn-delete');
            const frm = document.querySelector('#frm');

            btnList.addEventListener('click', function () {
                history.back();
            });

            btnUpdate.addEventListener('click', function () {
                frm.action = "boardUpdate_process.jsp";
                frm.submit();
            });

            btnDelete.addEventListener('click', function () {
                frm.action = "boardDelete_process.jsp";
                frm.submit();
            });
        });
    </script>
</head>
<body>

<%@ include file="dbconn.jsp" %>
<%
    // 게시판 목록 페이지에서 넘겨받은 글 번호
    int seq = Integer.parseInt(request.getParameter("seq"));

    String title = "";
    String contents = "";
    String userId = "";
    String createDate = "";
    String updateDate = "";
    int boardCnt = 0;

    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
//        조회수 count up
        String sql = "UPDATE board SET cnt = cnt + 1 WHERE seq = ? ";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, seq);
        pstmt.executeUpdate();

//        값 가져오기
        sql = "SELECT seq, title, contents, user_id, create_date, update_date, cnt FROM board ";
        sql += "WHERE seq = ? ";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, seq);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            title = rs.getString("title");
            contents = rs.getString("contents");
            userId = rs.getString("user_id");
            createDate = rs.getString("create_date");
            updateDate = rs.getString("update_date");
            boardCnt = rs.getInt("cnt");
        }
    }
    catch (SQLException e) {
        out.print(e.getMessage());
    }
    finally {
        if (rs != null) { rs.close(); }
        if (pstmt != null) { pstmt.close(); }
        if (conn != null) { conn.close(); }
    }

%>

<header class="container mt-3">
    <div class="p-5 mb-4 bg-light rounded-3">
        <div class="container-fluid py-4">
            <h1 class="text-center">상세 글 읽기 페이지</h1>
        </div>
    </div>
</header>

<main class="container mt-5">
    <div class="row">
        <form action="#" method="post" id="frm">
            <div class="col-sm-6 mx-auto">
                <div class="form-floating my-3">
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
                    <input type="text" class="form-control" id="board-cnt" name="boardCnt" placeholder="조회수를 입력하세요" readonly value="<%=boardCnt%>">
                    <label for="board-cnt" class="form-label">Count</label>
                </div>
                <div class="form-floating my-3">
                    <textarea class="form-control" id="contents" name="contents" rows="10" placeholder="내용을 입력하세요"><%=contents%></textarea>
                    <label for="contents" class="form-label">Contents</label>
                </div>
                <div class="my-3 row">
                    <div class="col-sm">
                        <button class="btn btn-secondary" type="button" id="btn-list">목록으로</button>
                    </div>
                    <div class="col-sm d-flex justify-content-end">
                        <button class="btn btn-warning me-2" type="button" id="btn-update">수정</button>
                        <button class="btn btn-danger" type="button" id="btn-delete">삭제</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</main>



</body>
</html>





