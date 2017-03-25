<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>管理員系統 - 辰辰購物網</title>
        <link rel="stylesheet" href="../assets/semantic.min.css" />
        <link rel="stylesheet" href="../assets/admin-style.css" />
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="../assets/semantic.min.js"></script>
    </head>
    <body>

        <%
            // 判斷是否登入，沒登入就踢出去
            if ((session.getAttribute("admin_username") == null) || (session.getAttribute("admin_username") == ""))
            	response.sendRedirect(base_url_admin + "login.jsp");

			// 會員數
			ResultSet admin_info_member      = con.createStatement().executeQuery("SELECT id FROM member");

            // 商品數
            ResultSet admin_info_commodity   = con.createStatement().executeQuery("SELECT id FROM commodity");

            // 總賣出
            ResultSet admin_info_sold        = con.createStatement().executeQuery("SELECT id FROM arsenal WHERE bought = '1' AND paid = '1'");

            // 未處理訂單
            ResultSet admin_info_notshipsold = con.createStatement().executeQuery("SELECT DISTINCT order_form FROM arsenal WHERE bought = '1' AND paid = '1' AND less = '0'");

            // 退貨紀錄(尚未開放)
            ResultSet admin_info_return = con.createStatement().executeQuery("SELECT id FROM arsenal WHERE returns = '1'");

            // 總收益
            ResultSet admin_info_total = con.createStatement().executeQuery("SELECT price, counts FROM arsenal WHERE bought = '1' AND paid = '1' AND less = '1'");


			// 計算各種類總數
            int member_counts = 0; // 會員數
            while (admin_info_member.next()) {
                member_counts++;
            }

            int commodity_counts = 0; // 商品數
            while (admin_info_commodity.next()) {
                commodity_counts++;
            }

            int sold_counts = 0; // 出售數
            while (admin_info_sold.next()) {
                sold_counts++;
            }

            int notship_counts = 0; // 尚未出貨數
            while (admin_info_notshipsold.next()) {
                notship_counts++;
            }

            int return_counts = 0; // 退貨數
            while (admin_info_return.next()) {
                return_counts++;
            }

            int total_counts = 0; // 總額
            while (admin_info_total.next()) {
                total_counts += (Integer.parseInt(admin_info_total.getString("price")) * Integer.parseInt(admin_info_total.getString("counts")));
            }

        %>

        <%@ include file="nav.jsp" %>

        <div class="ui grid">
        	<div class="five wide column statistics">
                <div class="ui inverted segment">
                    <div class="ui grid">
                        <div class="five wide column">
                            <div class="ui blue inverted statistic">
                                <div class="value">
                                    <%=member_counts%>
                                </div>
                                <div class="label">會員 </div>
                            </div>
                        </div>
                        <div class="six wide column">
                            <div class="ui green inverted statistic">
                                <div class="value">
                                    <%=commodity_counts%>
                                </div>
                                <div class="label">商品 </div>
                            </div>
                        </div>
                        <div class="five wide column">
                            <div class="ui inverted statistic">
                                <div class="value">
                                    <%=sold_counts%>
                                </div>
                                <div class="label">總賣出  </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="six wide column statistics">

                <div class="ui inverted segment">
                    <div class="ui grid">
                        <div class="four wide column"></div>
                        <div class="four wide column">
                            <div class="ui red inverted statistic">
                                <div class="value">
                                    <%=notship_counts%>
                                </div>
                                <div class="label">未處理訂單 </div>
                            </div></div>
                        <div class="four wide column">
                            <div class="ui grey inverted statistic">
                                <div class="value">
                                    <%=return_counts%>
                                </div>
                                <div class="label">退貨紀錄 </div>
                            </div>
                        </div>
                        <div class="four wide column"></div>
                    </div>
                </div>
            </div>

            <div class="five wide column statistics">
                <div class="ui inverted segment">

                    <div class="ui grid">
                        <div class="five wide column">
                        </div>
                        <div class="five wide column">
                            <div class="ui inverted statistic">
                                <div class="value">
                                    <%=total_counts%>
                                </div>
                                <div class="label">本月營收<i class="dollar icon"></i></div>
                            </div>
                        </div>
                        <div class="five wide column">
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <div class="ui grid">
            <div class="five wide column">
                <div class="ui segment">
                    <div class="ui large header center aligned">最近成交紀錄</div>
                    <table class="ui very basic table center aligned">
                        <tbody>
                            <%
                                ResultSet recent_transaction = con.createStatement().executeQuery("SELECT * FROM arsenal AS a, commodity AS c WHERE a.item = c.id AND a.bought = '1' AND a.paid = '1' AND a.less = '1' ORDER BY a.id DESC LIMIT 10");

                                while (recent_transaction.next()) {
                            %>
                                    <tr>
                                        <td><h5 class="ui header red"><%=recent_transaction.getString("a.username")%>&nbsp;於&nbsp;<%=recent_transaction.getString("a.date")%>&nbsp;購買</h5><%=recent_transaction.getString("c.name")%></td>
                                    </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="six wide column">
                <div class="ui segment">
                    <div class="ui large header center aligned">最近軍火庫紀錄</div>
                    <table class="ui very basic table center aligned">
                        <tbody>
                            <%
                                ResultSet recent_arsenal = con.createStatement().executeQuery("SELECT * FROM arsenal AS a, commodity AS c WHERE a.item = c.id AND a.bought = '0' AND a.paid = '0' ORDER BY a.id DESC LIMIT 10");

                                while (recent_arsenal.next()) {
                            %>
                                    <tr>
                                        <td><h5 class="ui header red"><%=recent_arsenal.getString("a.username")%>&nbsp;於&nbsp;<%=recent_arsenal.getString("a.date")%>&nbsp;加入</h5><%=recent_arsenal.getString("c.name")%></td>
                                    </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="five wide column">
                <div class="ui segment">
                    <div class="ui large header center aligned">最近註冊會員</div>
                    <table class="ui very basic table center aligned">
                        <tbody>
                            <%
                                ResultSet recent_member = con.createStatement().executeQuery("SELECT username, regdate FROM member ORDER BY id DESC LIMIT 10");

                                while (recent_member.next()) {
                            %>
                                    <tr>
                                        <td><h5 class="ui header red"><%=recent_member.getString("username")%>&nbsp;於&nbsp;<%=recent_member.getString("regdate")%>&nbsp;加入</h5></td>
                                    </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="ui grid">
            <div class="fifteen wide column statistics" style="margin:0 auto;">
                <div class="ui segment red">
                    <h1 class="ui header center aligned">所有訂單</h1>
                </div>
                <div class="ten wide column">
                    <table class="ui celled table">
                        <thead>
                            <tr class="center aligned">
                                <th class="one wide table-th center aligned">＃</th>
                                <th>訂購人</th>
                                <th>商品</th>
                                <th>價格</th>
                                <th>數量</th>
                                <th>總額</th>
                                <th>日期</th>
                                <th> 完成</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                ResultSet arsenal_rs = con.createStatement().executeQuery("SELECT *, count(DISTINCT a.order_form) FROM arsenal AS a, commodity AS c, member AS m WHERE a.bought = '1' AND a.paid = '1' AND less = '0' AND a.item = c.id AND a.username = m.username GROUP BY a.order_form");
                                while (arsenal_rs.next()) {
                            %>
                                    <tr class="center aligned" id="<%=arsenal_rs.getString("a.order_form")%>">
                                        <td><%=arsenal_rs.getString("a.order_form")%></td>
                                        <td><%=arsenal_rs.getString("m.name")%></td>
                                        <td><%=arsenal_rs.getString("c.name")%></td>
                                        <td><%=arsenal_rs.getString("a.price")%></td>
                                        <td><%=arsenal_rs.getString("a.counts")%></td>
                                        <td><%=Integer.parseInt(arsenal_rs.getString("a.counts"))*Integer.parseInt(arsenal_rs.getString("a.price"))%></td>
                                        <td><%=arsenal_rs.getString("a.date")%></td>
                                        <td><button type="button" id="complete" title="<%=arsenal_rs.getString("a.order_form")%>" class="ui button orange">寄送完成</button></td>
                                    </tr>
                            <%
                                }
                            %>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="ui grid" id="msg_success">
            <div class="six wide column statistics" style="margin:0 auto;">
                <div class="ui segment basic">
                    <div class="ui positive message">
                        <i class="close icon"></i>
                        <div class="header">
                        寄送完成
                        </div>
                        <p>Send completed</p>
                    </div>
                </div>
            </div>
        </div>

    <script>
        $("#msg_success").hide();
        $("#complete").click(function(){

            var of = "#" + $(this).attr('title');

            $.ajax({
				url: '<%=base_url_admin%>ajax/complete.jsp',
				type: "POST",
				data: {order_form : $(this).attr('title')},
				success: function(response){

                    $("#msg_success").show().delay(2000).hide(0);
                    $(of).remove();

				}
			});

        });
    </script>

    </body>
</html>
