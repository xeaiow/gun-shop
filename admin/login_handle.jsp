<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<%@ page import ="java.util.regex.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>管理系統</title>
    <link rel="stylesheet" href="../assets/semantic.min.css" />
    <link rel="stylesheet" href="../assets/style.css" />
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="../assets/semantic.min.js"></script>
</head>
<body>
<%-- Msg function --%>
<%!
    public String ShowMessage(String msgtext) {
        return
            "<div class=\"ui grid\">" +
                "<div class=\"five wide column\"></div>" +
                "<div class=\"six wide column\">" +
                    "<div class=\"ui negative message\" id=\"username_repty\">" +
                        "<div class=\"header\">" + msgtext + "<a onclick=\"window.history.back();\">回去</a></div>" +
                    "</div>" +
                "</div>" +
                "<div class=\"five wide column\"></div>" +
            "</div>";
    }
%>
<%
    // 管理員資料
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    Statement sql   = con.createStatement();
    ResultSet rs;

    // SQL injection username
    if (!username.matches("^[a-zA-Z0-9]{4,16}$")) {

        out.print(ShowMessage("帳號只能輸入4-16字元的英文及數字！"));
        return;

    }

    // SQL injection password
    if (!password.matches("^[a-zA-Z0-9]{6,20}$")) {

        out.print(ShowMessage("密碼只能輸入6-20字元的英文及數字！"));
        return;

    }

    // 比對是否有這組帳密
    rs = sql.executeQuery("SELECT fullname FROM manager WHERE username = '" + username + "' AND password ='" + password + "'");

    // 如果找到該筆資料
    if (rs.next()) {

        // 給予session
        session.setAttribute("admin_username", username);
        session.setAttribute("admin_name", rs.getString("fullname"));
        response.sendRedirect("/end/admin/index.jsp");

    }
    else {

        response.sendRedirect("/end/admin/login.jsp");

    }
%>
</body>
</html>
