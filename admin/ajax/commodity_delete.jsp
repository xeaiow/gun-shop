<%@ page import ="java.sql.*" %>
<%
    try {

        Class.forName("com.mysql.jdbc.Driver");

        try {

            String url      =   "jdbc:mysql://localhost/jsp_project?useUnicode=true&characterEncoding=UTF-8"; // 編碼過的資料庫連線
            Connection con  =   DriverManager.getConnection(url,"root","123456"); // 改你自己的帳密
            Statement sql   =   con.createStatement();
            ResultSet rs;

                if(con.isClosed()) {

                    out.println("資料庫開啟失敗");

                }
                else {

                    request.setCharacterEncoding("UTF-8"); // 宣告UTF-8，才能存中文
                    String id = request.getParameter("id");

                    Statement repty   = con.createStatement();
                    ResultSet repty_rs;

                    con.createStatement().executeUpdate("DELETE FROM commodity WHERE id = '" + id + "'");

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
