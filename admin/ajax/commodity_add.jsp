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
                    String name                 =   request.getParameter("name");
                    String meta                 =   request.getParameter("meta");
                    String type                 =   request.getParameter("type");
                    String subtype              =   request.getParameter("subtype");
                    String content              =   request.getParameter("content");
                    String model                =   request.getParameter("model");
                    String inch                 =   request.getParameter("inch");
                    String length               =   request.getParameter("length");
                    String weight               =   request.getParameter("weight");
                    String material             =   request.getParameter("material");
                    String speed                =   request.getParameter("speed");
                    String clip                 =   request.getParameter("clip");
                    String price                =   request.getParameter("price");
                    String pic                  =   request.getParameter("pic");
                    String stock                =   request.getParameter("stock");

                    Statement repty   = con.createStatement();
                    ResultSet repty_rs;

                    con.createStatement().executeUpdate("INSERT INTO commodity (name, meta, type, subtype, content, model, inch, length, weight, material, speed, clip, price, pic, stock) VALUES ('" + name + "', '" + meta + "', '" + type + "', '" + subtype + "', '" + content + "', '" + model + "', '" + inch + "', '" + length + "', '" + weight + "', '" + material + "', '" + speed + "', '" + clip + "', '" + price + "', '" + pic + "', '" + stock + "')");


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
