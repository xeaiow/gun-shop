<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>辰辰購物網</title>
	<link rel="stylesheet" href="<%=base_url%>assets/semantic.min.css" />
	<link rel="stylesheet" href="<%=base_url%>assets/style.css" />
	<script src="<%=base_url%>assets/semantic.min.js"></script>
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</head>
<body>

<%@ include file="../nav.jsp" %>

<div class="ui grid">
	<div class="three wide column">
		<%@ include file="../menu.jsp" %>
		<%
			// 分類代號(get傳進的值)
			String type 		= request.getParameter("id");

			// 列出分類中文
			ResultSet type_rs 	= con.createStatement().executeQuery("SELECT name FROM subtype WHERE id = '" + type + "'");

			// 取得分類名稱
			type_rs.next();
			String type_name 	= type_rs.getString("name");
		%>

	</div>


	<div class="twelve wide column" id="index-banner">

		<%-- 分類名稱 --%>
		<div class="ui teal inverted segment center aligned">
            <h1><%=type_name%></h1>
        </div>

		<div class="ui stackable four column grid">

		<%
			// 該分類商品
			ResultSet commodity_rs 	= con.createStatement().executeQuery("SELECT id, name, pic, meta FROM commodity WHERE subtype = '" + type + "'");

			// 該分類商品總筆數
			commodity_rs.last();
			int item_count = commodity_rs.getRow();

			// 回到第一筆，因為剛剛被我last了
			commodity_rs.beforeFirst();

			// 如果沒有商品就顯示"沒有商品的訊息"，否則顯示該分類之商品
			if (item_count == 0) {
			%>
				<div class="sixteen wide column">
					<div class="column">
						<div class="ui positive message">
							<i class="close icon"></i>
							<div class="header">
								目前沒有商品唷！
							</div>
							<p>There are currently no product.</p>
						</div>
					</div>
				</div>
			<%
			}

			else{
				// 抓出該分類之商品
				while (commodity_rs.next()) {

				%>
					<div class="column">
						<div class="ui card centered fluid">
							<a class="image" href="item.jsp?id=<%=commodity_rs.getString("id")%>">
								<img src="<%=commodity_rs.getString("pic")%>">
							</a>
							<div class="content">
								<a class="header" href="item.jsp?id=<%=commodity_rs.getString("id")%>"><%=commodity_rs.getString("name")%></a>
								<div class="meta">
									<a href="item.jsp?id=<%=commodity_rs.getString("id")%>">
										<%=commodity_rs.getString("meta")%>
									</a>
								</div>
							</div>
						</div>
					</div>
				<%
				}
			}
		%>

		</div>

	</div>

</div>

</body>
</html>
