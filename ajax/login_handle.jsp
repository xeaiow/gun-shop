<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<%@ page import ="java.util.regex.*" %>
<%
    // 使用者資料
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    Statement sql   = con.createStatement();
    ResultSet rs;

    // protection SQL Injection username and password
    if (!username.matches("^[a-zA-Z0-9]{4,16}$")) {
        out.print("3");
        return;
    }
    else if (!password.matches("^[a-zA-Z0-9]{6,20}$")) {
        out.print("4");
        return;
    }

    // 比對是否有這組帳密
    rs = sql.executeQuery("SELECT username, name FROM member WHERE username = '" + username + "' AND password ='" + password + "'");

    // 如果找到該筆資料
    if (rs.next()) {
        // 給予session
        session.setAttribute("username", username);
        session.setAttribute("name", rs.getString("name"));
        out.print("1");
    }
    else {
        out.print("2");
    }
%>
