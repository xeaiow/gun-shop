<%@ page import ="java.sql.*" %>
<%
	// 載入資料庫連線檔
    Class.forName("com.mysql.jdbc.Driver");

    // jsp_project 為資料庫名稱 root 為帳號 123456 為密碼
    Connection con          = DriverManager.getConnection("jdbc:mysql://localhost/jsp_project?useUnicode=yes&characterEncoding=UTF-8", "root", "123456");

    // 改自己路徑，end 為資料夾名稱
    String base_url         = "http://localhost:8080/end/";
    String base_url_admin   = "http://localhost:8080/end/admin/";
%>
