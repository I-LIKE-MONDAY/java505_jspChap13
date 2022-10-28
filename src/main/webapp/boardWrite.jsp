<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>게시판 글쓰기 페이지</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>

  <script>
<%--    자바스크립트  --%>
    window.addEventListener('DOMContentLoaded', function () {
      const btnBack = document.querySelector('#btn-back');
      btnBack.addEventListener('click', function () {
        //뒤로가기 기능
        history.back();
      })
    });
  </script>
</head>
<body>
<header class="container mt-3">
  <div class="p-5 mb-4 bg-light rounded-3">
    <div class="container-fluid py-4">
      <h1 class="text-center">게시물 글쓰기 페이지</h1>
    </div>
  </div>
</header>


<main class="container mt-5">
  <div class="row">
    <div class="col-sm-6 mx-auto">
      <form action="boardWrite_process.jsp" method="post" class="border rounded-3 p-4">
        <div class="form-floating my-3">
          <input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력하세요">
          <label for="title" class="form-label">Title</label>
        </div>
        <div class="form-floating my-3">
          <input type="text" class="form-control" id="user-id" name="userId" placeholder="ID를 입력하세요">
          <label for="user-id" class="form-lavel">ID</label>
        </div>
        <div class="form-floating my-3">
          <textarea class="form-control" id="contents" name="contents" placeholder="내용을 입력하세요" ></textarea>
          <label for="contents" class="form-label">Contents...</label>
        </div>
        <div class="d-grid gap-2">
          <button class="btn btn-primary" type="submit">글쓰기</button>
          <button class="btn btn-secondary" type="button" id="btn-back">돌아가기</button>
        </div>
      </form>
    </div>
  </div>
</main>


<footer class="container-fluid mt-5 p-5 border-top">
  <p class="lead text-muted text-center">made by bitc java505</p>
</footer>
</body>
</html>
