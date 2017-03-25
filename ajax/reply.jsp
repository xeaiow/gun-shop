<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");                                  // 宣告UTF-8，才能存中文
    String username             =   request.getParameter("username");       // 會員帳號
    String item                 =   request.getParameter("item");           // 商品
    String reply_content        =   request.getParameter("reply_content");  // 評論內容
    String date                 =   request.getParameter("date");           // 評論日期

    con.createStatement().execute("INSERT INTO reply (username, item, content, date) VALUES ('" + username + "', '" + item + "', '" + reply_content + "', '" + date + "')");
%>
