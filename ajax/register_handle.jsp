<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<%@ page import = "java.sql.*" %>
<%@ page import ="java.text.*" %>
<%

    Statement sql   = con.createStatement();
    ResultSet rs;
    request.setCharacterEncoding("UTF-8");                      // 宣告UTF-8，才能存中文
    String username     =   request.getParameter("username");   // 帳號
    String psw          =   request.getParameter("psw");        // 密碼
    String ck_psw       =   request.getParameter("ck_psw");     // 確認密碼
    String name         =   request.getParameter("name");       // 姓名
    String area         =   request.getParameter("area");       // 行政區
    String address      =   request.getParameter("address");    // 地址
    String tel          =   request.getParameter("tel");        // 連絡電話
    String email        =   request.getParameter("email");      // 電子信箱
    String birth        =   request.getParameter("birth");      // 生日
    String gender       =   request.getParameter("gender");     // 性別

    // 註冊日期
    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
    String formattedDate = df.format(new java.util.Date());

    // 判斷帳號是否輸入4-16字元的英文及數字
    if (!username.matches("^[a-zA-Z0-9]{4,16}$")) {
        out.print("1"); // type : 1 帳號非數字及英文
        return;
    }

    // 判斷密碼是否輸入4-16字元的英文及數字
    if (!psw.matches("^[a-zA-Z0-9]{6,20}$")) {
        out.print("2"); // type : 2 密碼非數字及英文
        return;
    }

    if (!psw.equals(ck_psw)) {
        out.print("3"); // type : 3 密碼與確認密碼不相符
        return;
    }

    // 檢查重複帳號SQL
    rs = sql.executeQuery("SELECT username FROM member WHERE username = '" + username + "'");

    // 判斷重複帳號
    if (rs.next()) {
        out.print("4"); // type : 4 為帳號重複
        return;
    }

    // 確認無誤後，將使用者輸入的資料存入
    boolean query = con.createStatement().execute("INSERT INTO member (username, password, name, area, address, tel, email, birth, gender, regdate) " + " VALUES ('" + username + "', '" + psw + "', '" + name + "', '" + area + "', '" + address + "', '" + tel + "', '" + email + "', '" + birth + "', '" + gender + "', '" + formattedDate + "')");

    // 如果註冊成功就回傳 type : 5
    out.print("5");
%>
