<%-- dbconn--%>

<%@ page import="java.sql.*" %>
<%
    Connection conn = null;

    String url = "jdbc:mysql://localhost:3306/javadb";
    String user = "test1";
    String passwd = "java505";

    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(url, user, passwd);
%>