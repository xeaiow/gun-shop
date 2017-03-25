<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="config.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>我的軍火庫</title>
	<link rel="stylesheet" href="assets/semantic.min.css" />
	<link rel="stylesheet" href="assets/style.css" />
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="assets/semantic.min.js"></script>
</head>
<body>

<%
    if ((session.getAttribute("username") == null) || (session.getAttribute("username") == ""))
    	response.sendRedirect("login.jsp");
%>

<%@ include file="nav.jsp" %>

<div class="ui grid">

	<div class="three wide column">

		<%@ include file="menu.jsp" %>

	</div>

    <%
		String username = String.valueOf(session.getAttribute("username"));
        ResultSet profile_rs 	= con.createStatement().executeQuery("SELECT * FROM member AS m, area AS a WHERE m.username = '" + session.getAttribute("username") + "' AND m.area = a.id");
        profile_rs.next();
		String gender  = "";
    %>

	<%-- 個人資料 --%>
	<div class="twelve wide column" id="index-banner">

        <div class="ui grid">
			<%-- 我的軍火庫 --%>
			<div class="sixteen wide column">
				<div class="ui segment">
					<h1 class="ui header red center aligned">我的軍火庫</h1>
				</div>
			</div>
            <div class="four wide column">
                <div class="ui card">
                    <div class="image">
                        <img src="//semantic-ui.com/images/avatar2/large/elyse.png">
                    </div>
                    <div class="content">
                        <a class="header center aligned"><%=profile_rs.getString("m.name")%></a>
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
                            <td><%=gender = (Integer.parseInt(profile_rs.getString("m.gender")) == 1) ? "男":"女"%></td>
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

			<div class="sixteen wide column">
				<div class="ui segment">
					<h1 class="ui header grey center aligned" id="notcheckout">待結帳商品</h1>
				</div>
			</div>

			<div class="twelve wide column" id="item_column">
				<div class="ui stackable four column grid">

				<%
					Statement arsenal_item 		= con.createStatement(); // 軍火庫商品
					ResultSet arsenal_item_rs 	= sql.executeQuery("SELECT * FROM arsenal AS a, commodity AS c WHERE a.username = '" + session.getAttribute("username") + "' AND a.paid = '0' AND a.bought = '0' AND a.item = c.id"); 	// 列出我的軍火庫商品
					int total 	= 0;
					int k 		= 0;

					while (arsenal_item_rs.next()) {
				%>
						<div class="column">
							<div class="ui card centered fluid">
								<a class="image" href="commodity/item.jsp?id=<%=arsenal_item_rs.getString("c.id")%>">
									<div class="ui orange ribbon label">
										x <%=arsenal_item_rs.getString("a.counts")%>
									</div>
									<img src="<%=arsenal_item_rs.getString("c.pic")%>">
								</a>
								<div class="content">
									<a class="header" href="commodity/item.jsp?id=<%=arsenal_item_rs.getString("c.id")%>"><%=arsenal_item_rs.getString("c.name")%></a>
									<div class="meta">
										<a href="commodity/item.jsp?id=<%=arsenal_item_rs.getString("c.id")%>">
											<%=arsenal_item_rs.getString("c.price")%> .NT
										</a>
									</div>
								</div>
							</div>
						</div>
				<%
						// 購物總價
						total += Integer.parseInt(arsenal_item_rs.getString("c.price"))*Integer.parseInt(arsenal_item_rs.getString("a.counts"));
						k++;
					}

				%>

				</div>
			</div>

			<%-- 總價 --%>
			<div class="sixteen wide column">


				<div class="ui form segment" id="total-checkout">

					<div class="ui right labeled left icon input">
						<i class="tags icon"></i>
						<input type="text" placeholder="code" id="code">
						<a class="ui tag black label">
							使用優惠券
						</a>
					</div>

					<div class="one fields" style="margin-top:20px;">
						<div class="field">
						    <label>Card Type</label>
							<div class="ui selection dropdown" id="card-select">
								<input type="hidden" id="cardtype">
									<div class="default text">選擇付款方式</div>
									<i class="dropdown icon"></i>
									<div class="menu">
										<div class="item" data-value="1">
											<i class="visa icon"></i>
											Visa
										</div>
										<div class="item" data-value="2">
											<i class="amex icon"></i>
											American Express
										</div>
										<div class="item" data-value="3">
											<i class="discover icon"></i>
											Discover
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="field">
							<label>Card Number</label>
							<input type="text" maxlength="50" placeholder="卡號" id="card_number">
						</div>

						<div class="field">
							<label>收件人</label>
							<input type="text" id="recipient">
						</div>

						<div class="field">
							<label>地址</label>
							<input type="text" id="address">
						</div>
						<div class="field">
							<label>備註</label>
							<textarea rows="8" cols="40" id="remark"></textarea>
						</div>

						<div class="ui segment">
							<p>
								．未取件記錄達 2 次以上(含2次)，未來將終結服務<br />
								．加入會員，才可自行查詢訂單紀錄，出貨進度<br />
								．請輸入正確中文姓名<br />
							</p>
						</div>

						<div class="field">
							<div class="ui segment basic">
								<h2 class="ui header blue right aligned">合計：<%=total%> 元</h2>
							</div>
						</div>
					</div>

					<div class="ui segment basic right aligned" id="checkout-check">
						<div class="field">
							<button class="ui button green" type="button" id="checkout">前往結帳</button>
						</div>
					</div>
				</div>
			</div>

			<div class="sixteen wide column" id="order-hi">
				<div class="ui segment">
					<h1 class="ui header black center aligned">購物紀錄</h1>
				</div>
				<table class="ui very basic table center aligned">
					<tbody>
						<tr>
							<th>#</th>
							<th>商品</th>
							<th>數量</th>
							<th>價格</th>
							<th>付款方式</th>
							<th>購買日</th>
							<th>出貨</th>
						</tr>
						<%
							int ohi = 1;
							String less = "";
							ResultSet order_his_rs 	= con.createStatement().executeQuery("SELECT * FROM arsenal AS a, commodity AS c, member AS m WHERE a.username = '" + session.getAttribute("username") + "' AND a.item = c.id AND bought = '1' AND paid = '1' ORDER BY a.id DESC");
							while (order_his_rs.next()) {
						%>
								<tr>
									<td><%=ohi%></td>
									<td><a href="/end/commodity/item.jsp?id=<%=order_his_rs.getString("c.id")%>"><%=order_his_rs.getString("c.name")%></a></td>
									<td><%=order_his_rs.getString("a.counts")%></td>
									<td><%=Integer.parseInt(order_his_rs.getString("a.price"))*Integer.parseInt(order_his_rs.getString("a.counts"))%>元</td>
									<td>
										<%
										switch (Integer.parseInt(order_his_rs.getString("a.card_type"))) {
											case 1:
												out.print("<i class=\"visa icon\"></i>Visa");
												break;
											case 2:
												out.print("<i class=\"amex icon\"></i>American Express");
												break;
											case 3:
												out.print("<i class=\"discover icon\"></i>Discover");
												break;
										}

										%>
									</td>
									<td><%=order_his_rs.getString("a.date")%></td>
									<td><%=less = (Integer.parseInt(order_his_rs.getString("a.less")) == 1) ? "<h3 class=\"ui header green\">出貨完成</h3>" : "<h3 class=\"ui header red\">尚未出貨</h3>"%></td>
								</tr>
						<%
								ohi++;
							}
						%>

					</tbody>
				</table>
			</div>

        </div>

	</div>

</div>

<%-- 確認購買Modal --%>
<div class="ui basic modal" id="checkout-modal">
	<i class="close icon"></i>
	<div class="header">
		確認購買嗎？
	</div>
	<div class="image content">
	<div class="image">
		<i class="archive icon"></i>
	</div>
	<div class="description">
		<p>
			售後服務為7日內可全額退款。
		</p>
	</div>
	</div>
	<div class="actions">
		<div class="two fluid ui inverted buttons">
			<div class="ui red basic inverted button">
				<i class="remove icon"></i>
				等等
			</div>
			<div class="ui green basic inverted button" id="checkout-ok">
				<i class="checkmark icon"></i>
				確定結帳
			</div>
		</div>
	</div>
</div>

<script>

	var card_type = "";
	var k = "<%=k%>";
	if (k == "0") {
		$("#notcheckout").text("沒有待結帳商品，快去尋寶吧！");
		$("#checkout-check").remove();
		$("#total-checkout").remove();
	}

	// 點擊結帳跳出確認視窗
	$("#checkout").click(function(){
		$("#checkout-modal").modal('show');
	});

	// 確認購買
	$("#checkout-ok").click(function(){

		if ($("#card_number").val() && card_type) {

			$.ajax({
				url: '<%=base_url%>insert.jsp',
				type: "POST",
				data: {username : "<%=username%>", card_type : card_type, card_number : $("#card_number").val(), recipient : $("#recipient").val(), address : $("#address").val(), remark : $("#remark").val()},
				success: function(response){

					$("#notcheckout").text("沒有待結帳商品，快去尋寶吧！");
					$("#checkout-check").remove();
					$("#total-checkout").remove();
					$("#item_column").remove();
					$("#checkout-modal").modal('hide');
					location.reload();
				}
			});
		}
	});

	// 付款方式選單值
	$("#card-select").change(function(){
		card_type = $("#cardtype").attr('value');
	});

	$('#card-select').dropdown();

</script>

</body>
</html>
