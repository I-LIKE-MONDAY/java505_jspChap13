<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="com.sun.tools.javac.jvm.Gen" %>
<%@ page import="com.bitc.jspchap13.Student" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

</head>
<body>
<%
  Gson gson = new Gson();
  Student stu = new Student(1001, "홍길동");

  String jsonStr = gson.toJson(stu);

  out.print(jsonStr);
%>
  <br><br><br>
<%
  JsonObject jobj = new JsonObject();
  jobj.addProperty("id", 1002);
  jobj.addProperty("name", "아이유");

  out.print(jobj);
%>
<br><hr><br>
<%
    jsonStr = "{\"id\": 1003, \"name\": \"유재석\"}";

    Student stu1 = gson.fromJson(jsonStr, Student.class);
    // out.print(stu1); // 결과: com.bitc.jspchap13.Student@368e3ee4

    out.print(stu1.getId());
    out.print(stu1.getName());


%>
</body>
</html>
