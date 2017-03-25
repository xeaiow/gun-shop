<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>編輯會員</title>
	<link rel="stylesheet" href="../assets/semantic.min.css" />
	<link rel="stylesheet" href="../assets/style.css" />
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="../assets/semantic.min.js"></script>
</head>
<body>

	<%
		// 判斷是否登入
		if ((session.getAttribute("admin_username") == null) || (session.getAttribute("admin_username") == ""))
			response.sendRedirect("/end/admin/login.jsp");
	%>

<%@ include file="nav.jsp" %>

<div class="ui grid">


	<div class="three wide column"></div>

    <%
        // 商品代號
        String user_id = request.getParameter("id");

        ResultSet profile_rs = con.createStatement().executeQuery("SELECT * FROM member AS m, area AS a WHERE m.id = '" + user_id + "' AND m.area = a.id");
        profile_rs.next();

        // 性別
        String gender = "";
        gender = (Integer.parseInt(profile_rs.getString("gender")) == 1) ? "男" : "女";
        String username = profile_rs.getString("m.username");
    %>

	<%-- 會員資料 --%>
	<div class="fifteen wide column centered" id="index-banner">

		<div class="ui center aligned orange segment" style="margin-top:-40px;">
			<h1><%=profile_rs.getString("name")%>的資料</h1>
		</div>

        <div class="ui grid">
            <div class="four wide column">
                <div class="ui card">
                    <div class="image">
                        <img src="//semantic-ui.com/images/avatar/large/daniel.jpg">
                    </div>
                    <div class="content">
                        <a class="header center aligned"><%=profile_rs.getString("name")%></a>
                    </div>
                </div>
            </div>
            <div class="twelve wide column">
                <table class="ui very basic table">
                    <tbody>
                        <tr>
                            <td class="three wide table-th">帳號</td>
                            <td><%=profile_rs.getString("m.username")%></td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">性別</td>
                            <td><%=gender%></td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">生日</td>
                            <td><%=profile_rs.getString("m.birth")%></td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">電子信箱</td>
                            <td><%=profile_rs.getString("m.email")%></td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">電話</td>
                            <td><%=profile_rs.getString("m.tel")%></td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">地址</td>
                            <td><%=profile_rs.getString("a.name")%><%=profile_rs.getString("m.address")%></td>
                        </tr>
                    </tbody>
                </table>
            </div>

        </div>

        <div class="twelve wide column" style="margin-top:20px;">
            <div class="ui segment">
                <h1 class="ui header centered">訂購紀錄</h1>

                        <%
                            // 取得使用者的購物紀錄
                            ResultSet orders_rs = con.createStatement().executeQuery("SELECT * FROM arsenal AS a, commodity AS c WHERE username = '" + username + "' AND a.item = c.id");
							int orders_counts  = 0;
							while (orders_rs.next()) {
								orders_counts ++;
							}
							orders_rs.beforeFirst();

							if (orders_counts == 0) {
							%>
								<div class="ui negative message">
									<i class="close icon"></i>
									<div class="header">
										還沒有購物紀錄
									</div>
								</div>
							<%
							}
							else{
							%>
								<table class="ui celled table">
									<thead>
										<tr>
											<th class="one wide table-th center aligned">＃</th>
											<th>項目</th>
											<th>購買日</th>
										</tr>
									</thead>
									<tbody>
							<%

								while (orders_rs.next()) {

	                        %>
	                                <tr>
	                                    <td class="center aligned"><%=orders_rs.getString("a.id")%></td>
	                                    <td><%=orders_rs.getString("c.name")%></td>
	                                    <td><%=orders_rs.getString("a.date")%></td>
	                                </tr>
	                        <%
	                            }


							}
%>

                    </tbody>
                </table>
            </div>

            <%-- 使用者的軍火庫 --%>
            <div class="ui segment">
                <h1 class="ui header centered">軍火庫</h1>
                        <%
                            // 取得使用者的購物紀錄
                            ResultSet arsenal_rs = con.createStatement().executeQuery("SELECT * FROM arsenal AS a, commodity AS c WHERE a.username = '" + username + "' AND a.bought = '0' AND a.paid = '0' AND a.item = c.id");
							int arsenal_counts = 0;
							while (arsenal_rs.next()) {
								arsenal_counts ++;
							}
							arsenal_rs.beforeFirst();

							if (arsenal_counts == 0) {

							%>
								<div class="ui negative message">
									<i class="close icon"></i>
									<div class="header">
										還沒有軍火庫紀錄
									</div>
								</div>
							<%

							}
							else{
							%>
								<table class="ui celled table">
									<thead>
										<tr>
											<th class="one wide table-th center aligned">＃</th>
											<th>項目</th>
											<th>數量</th>
											<th>日期</th>
										</tr>
									</thead>
									<tbody>
							<%
								while (arsenal_rs.next()) {
	                        %>
	                                <tr>
	                                    <td class="center aligned"><%=arsenal_rs.getString("a.id")%></td>
	                                    <td><%=arsenal_rs.getString("c.name")%></td>
										<td><%=arsenal_rs.getString("a.counts")%></td>
	                                    <td><%=arsenal_rs.getString("a.date")%></td>
	                                </tr>
	                        <%
	                            }

							}
                        %>
                    </tbody>
                </table>
            </div>

        </div>

	</div>

</div>

</body>
</html>
