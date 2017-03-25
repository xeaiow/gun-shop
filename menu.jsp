<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import ="java.text.*" %>
<div class="ui vertical menu" id="item_menu">

<%
    int i 			= 1; 										// 子類別的分類
    Statement sql   = con.createStatement(); 					// type
    Statement st 	= con.createStatement(); 					// subtype
    Statement ct 	= con.createStatement(); 					// counts
    ResultSet rs 	= sql.executeQuery("SELECT * FROM type"); 	// 先找父類別再找子類別

    // 抓取父類別及子類別
    while (rs.next()) {
%>
        <div class="item">
            <div class="header">
                <%=rs.getString("name")%>
            </div>
            <div class="menu">
<%
                ResultSet rs2 = st.executeQuery("SELECT id, name, url FROM subtype WHERE type = '" + i + "'");
                while (rs2.next()) {
%>
                    <a class="item" href="/end/commodity/type.jsp?id=<%=rs2.getString("id")%>">
                        <%=rs2.getString("name")%>
                    </a>
<%
                }
%>
            </div>
        </div>
<%
        i++;
    }

    // 訪客數取得
    int all_visitor     = 0;
    ResultSet st_counts = ct.executeQuery("SELECT id FROM visitors"); // 抓取筆數
    while (st_counts.next()) {
        all_visitor += 1;
    }

%>

    <div class="ui segment">
        <p>

            <h4 class="ui header black center aligned">凡走過必留下痕跡：<%=all_visitor%></h4>
            <%
                // 訪客+1
                DateFormat df           =   new SimpleDateFormat("yyyy-MM-dd"); // 宣告一個日期類別(為了判斷一日訪客數只加一次)
                String formattedDate    =   df.format(new java.util.Date()); // 方法呼叫(呼叫上一行宣告的)

                // visitors 資料表是否有這組session(剛剛我們產生給他的，參考index.jsp 37行)
                ResultSet visitors_rs   =   con.createStatement().executeQuery("SELECT id FROM visitors WHERE username = '" + session.getAttribute("visitor") + "'");

                // 取得該session筆數
                visitors_rs.last();         // 移至最後一筆(表示所有筆數)
                int visitor_counts      =   visitors_rs.getRow(); // 取得總比數

                // 如果 0 筆(此人今日沒來過就 +1)
                if (visitor_counts == 0) {
                    con.createStatement().execute("INSERT INTO visitors (username, date) VALUES ('" + session.getAttribute("visitor") + "', '" + formattedDate + "')");
                }
            %>
        </p>
    </div>

</div>
