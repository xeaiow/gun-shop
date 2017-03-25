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
                    String username             =   request.getParameter("username");
                    String item                 =   request.getParameter("item");
                    String date                 =   request.getParameter("date");
                    String price                =   request.getParameter("price");
                    String counts               =   request.getParameter("counts");

                    Statement repty   = con.createStatement();
                    ResultSet repty_rs;

                    // 比對是否有這組帳密
                    rs = sql.executeQuery("SELECT id FROM arsenal WHERE username = '" + username + "' AND item = '" + item + "' AND paid = '0' AND bought = '0'");

                    // 如果找到該筆資料
                    if (!rs.next()) {

                        con.createStatement().execute("INSERT INTO arsenal (username, item, date, price, counts, paid, bought, card_type, card_number) VALUES ('" + username + "', '" + item + "', '" + date + "', '" + price + "', '" + counts + "', '0', '0', '0', '0')");

                    }
                    else{

                        con.createStatement().executeUpdate("DELETE FROM arsenal WHERE username = '" + username + "' AND item = '" + item + "' AND paid = '0' AND bought = '0'");

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
