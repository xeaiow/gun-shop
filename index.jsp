<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@ include file="config.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>辰辰購物網</title>
	<link rel="stylesheet" href="assets/semantic.min.css" />
	<link rel="stylesheet" href="assets/style.css" />
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="assets/semantic.min.js"></script>
</head>
<body>

<%@ include file="nav.jsp" %>

<div class="ui grid">

	<div class="three wide column">

		<%-- 分類選單 --%>
		<%@ include file="menu.jsp" %>

	</div>

	<%-- 新品推薦 --%>
	<div class="twelve wide column" id="index-banner">

		<div class="ui blue inverted segment center aligned">
            <h1>最新商品</h1>
        </div>

		<div class="ui stackable four column grid" id="search-block">

		<%
			// 給訪客一組10碼隨機數，防止相同訪客刷新頁面就+1
			if (session.getAttribute("visitor") == null) {
				int rnds = (int) (Math.random() * 1000000000); // 給予 10 碼 session
				session.setAttribute("visitor", rnds); // 存入 visitor
			}

			Statement commodity 	= con.createStatement(); // 秀出最新商品
			ResultSet commodity_rs 	= sql.executeQuery("SELECT id, price, pic, name, meta FROM commodity ORDER BY id DESC LIMIT 12"); // 最多列出三排3*4最新商品

			while (commodity_rs.next()) {
		%>
				<div class="column">
					<div class="ui card centered fluid" style="min-height:350px;">
						<a class="image" href="<%=base_url%>commodity/item.jsp?id=<%=commodity_rs.getString("id")%>">
							<div class="ui orange ribbon label">
								<i class="dollar icon"></i> <%=commodity_rs.getString("price")%>
							</div>
							<img src="<%=commodity_rs.getString("pic")%>">
						</a>
						<div class="content">
							<a class="header" href="<%=base_url%>commodity/item.jsp?id=<%=commodity_rs.getString("id")%>">
								<%=commodity_rs.getString("name")%>
							</a>
							<div class="meta">
								<a href="<%=base_url%>commodity/item.jsp?id=<%=commodity_rs.getString("id")%>">
									<%=commodity_rs.getString("meta")%>
								</a>
							</div>
						</div>
					</div>
				</div>
		<%
			}
		%>

		</div>

		<%
			// 隨機廣告(示範1~3筆廣告)
			Random rnd 			= 	new Random();	 	// 物件宣告，宣告一個 Random
			int rnds 			= 	rnd.nextInt(3)+1; 	// 產生1~3

			// 利用產生的數字對應廣告編號(參考 advertising 資料表)
			ResultSet ad_rs 	= 	sql.executeQuery("SELECT title, image, content FROM advertising WHERE id = '" + rnds + "'");

			while (ad_rs.next()) {
		%>
				<div class="ui piled segment">
					<h2 class="ui header center aligned"><%=ad_rs.getString("title")%></h2>
					<p>
						<img class="ui small rounded image middle aligned" src="<%=ad_rs.getString("image")%>">
						<span>
							<%=ad_rs.getString("content")%>
						</span>
					</p>
				</div>
		<%
			}
		%>

	</div>

</div>

</body>
</html>
