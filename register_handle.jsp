<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import ="java.text.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>購物車</title>
    <link rel="stylesheet" href="assets/semantic.min.css" />
    <link rel="stylesheet" href="assets/style.css" />
    <script src="assets/semantic.min.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
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

    try {

        Class.forName("com.mysql.jdbc.Driver");

        try {

            String url      =   "jdbc:mysql://localhost/?useUnicode=true&characterEncoding=UTF-8"; // 編碼過的資料庫連線
            Connection con  =   DriverManager.getConnection(url,"root","123456"); // 改你自己的帳密
            Statement sql   =   con.createStatement();
            ResultSet rs;

            // 使用的資料庫
            con.createStatement().execute("USE jsp_project");

                if(con.isClosed()) {

                    out.println("資料庫開啟失敗");

                }
                else {

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

                    // 今日
                    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                    String formattedDate = df.format(new java.util.Date());

                    // 判斷所有欄位是否填寫
                    if (username.equals("") || psw.equals("") || name.equals("") || area.equals("") || address.equals("") || tel.equals("") || email.equals("") || birth.equals("") || gender.equals("")) {
                        out.print(ShowMessage("請填寫所有欄位！"));
                        return;
                    }
                    else{

                        // 判斷帳號是否輸入4-16字元的英文及數字
                        if (!username.matches("^[a-zA-Z0-9]{4,16}$")) {

                            out.print(ShowMessage("帳號只能輸入4-16字元的英文及數字！"));
                            return;

                        }

                        // 判斷密碼是否輸入4-16字元的英文及數字
                        if (!psw.matches("^[a-zA-Z0-9]{6,20}$")) {

                            out.print(ShowMessage("密碼只能輸入6-20字元的英文及數字！"));
                            return;

                        }

                        if (!psw.equals(ck_psw)) {

                            out.print(ShowMessage("密碼與確認密碼不相符！"));
                            return;

                        }

                        // 檢查重複帳號SQL
                        rs = sql.executeQuery("SELECT username FROM member WHERE username = '" + username + "'");

                        // 判斷重複帳號
                        if (rs.next()) {

                            out.print(ShowMessage("帳號已被申請過，請換個試試！"));
                            con.close();

                        }
                        else{

                            boolean query = con.createStatement().execute("INSERT INTO member (username, password, name, area, address, tel, email, birth, gender, regdate) " + " VALUES ('" + username + "', '" + psw + "', '" + name + "', '" + area + "', '" + address + "', '" + tel + "', '" + email + "', '" + birth + "', '" + gender + "', '" + formattedDate + "')");

                            if (!query) {

                                out.print(
                                    "<div class=\"ui grid\">" +
                                        "<div class=\"five wide column\"></div>" +
                                        "<div class=\"six wide column\">" +
                                            "<div class=\"ui negative message\" id=\"username_repty\">" +
                                                "<div class=\"header\">註冊成功！ <a onclick=\"window.history.back();\">回去</a></div>" +
                                            "</div>" +
                                        "</div>" +
                                        "<div class=\"five wide column\"></div>" +
                                    "</div>"
                                );

                            }
                            else {

                                out.println("failed"); // 註冊失敗
                                con.close();

                            }
                        }
                    }
               }
          }

          catch (SQLException sExec) {

              out.println("SQL"+sExec.toString()); // SQL出錯

          }

    }

    catch (ClassNotFoundException err) {

          out.println("class"+err.toString()); // class 出錯

    }
%>

</body>
</html>
