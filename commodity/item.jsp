<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>辰辰購物網</title>
	<link rel="stylesheet" href="<%=base_url%>assets/semantic.min.css" />
	<link rel="stylesheet" href="<%=base_url%>assets/style.css" />
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="<%=base_url%>assets/semantic.min.js"></script>
</head>
<body>

<%@ include file="../nav.jsp" %>

<div class="ui grid">

	<div class="three wide column">

		<%@ include file="../menu.jsp" %>

		<%
			// 商品代號
			String commodity_id = request.getParameter("id");

			// 列出商品中文
			ResultSet type_rs 	= con.createStatement().executeQuery("SELECT name FROM commodity WHERE id = '" + commodity_id + "'");

			// 取得商品名稱
			type_rs.next();
			String type_name 	= type_rs.getString("name");
		%>

	</div>

	<%-- 商品名稱 --%>
	<div class="twelve wide column" id="index-banner">
		<div class="ui messag item_title">
			<div class="header">
				<h2><%=type_name%></h2>
			</div>
		</div>

		<div class="ui stackable four column grid">

		<%
			// 列出商品資訊
			ResultSet commodity_rs 	= con.createStatement().executeQuery("SELECT * FROM commodity WHERE id = '" + commodity_id + "'");
			String content 	= "";
			String price 	= "";
			int stock = 0;

			// 抓出該編號之商品
			while (commodity_rs.next()) {

				content += commodity_rs.getString("content");
				price   = commodity_rs.getString("price");
				stock   += Integer.parseInt(commodity_rs.getString("stock"));
			%>

				<div class="seven wide column">
					<div class="column">
						<div class="ui card centered fluid">
							<a class="image">
								<div class="ui blue ribbon label">
									<i class="dollar icon"></i> <%=commodity_rs.getString("price")%>
								</div>
								<img src="<%=commodity_rs.getString("pic")%>">
							</a>
						</div>
					</div>
				</div>

				<div class="nine wide column">

					<table class="ui very basic table">
						<tbody>
							<tr>
								<td class="three wide table-th">機型</td>
								<td><%=commodity_rs.getString("model")%></td>
							</tr>
							<tr>
								<td class="table-th">吋</td>
								<td><%=commodity_rs.getString("inch")%></td>
							</tr>
							<tr>
								<td class="table-th">長度</td>
								<td><%=commodity_rs.getString("length")%> mm</td>
							</tr>
							<tr>
								<td class="table-th">重量</td>
								<td><%=commodity_rs.getString("weight")%> g</td>
							</tr>
							<tr>
								<td class="table-th">材質</td>
								<td><%=commodity_rs.getString("material")%></td>
							</tr>
							<tr>
								<td class="table-th">初速</td>
								<td><%=commodity_rs.getString("speed")%> s</td>
							</tr>
							<tr>
								<td class="table-th">裝彈數</td>
								<td><%=commodity_rs.getString("clip")%> 顆</td>
							</tr>
							<tr>
								<td class="table-th">庫存</td>
								<td><%=commodity_rs.getString("stock")%> 件</td>
							</tr>
							<tr>
								<%
									if (stock > 0) {
								%>
										<td class="table-th">購買</td>
										<td>
											<div class="ui right labeled input">
												<input type="number" value="1" placeholder="欲購數量" id="buy-counts">
												<div class="ui basic label">
													件
												</div>
											</div>
										</td>
								<%
									}
								%>
							</tr>
						</tbody>
					</table>

					<%-- 加入軍火庫(購物車) --%>
					<div class="ui segment basic">
						<%
							if (session.getAttribute("name") != null) {

								// 列出商品資訊
								ResultSet arsenal_rs 	= con.createStatement().executeQuery("SELECT id FROM arsenal WHERE username = '" + session.getAttribute("username") + "' AND paid = '0' AND bought = '0' AND item = '" + commodity_id + "'");

								arsenal_rs.last();
								int arsenal_counts 		= arsenal_rs.getRow();

								if (arsenal_counts == 0) {

									if (stock > 0) {

										out.print("<button class=\"fluid ui brown button\" id=\"add-to-arsenal\"><i class=\"add to cart icon\"></i> 加入軍火庫</button>");

									}
									else{

										out.print("<button class=\"fluid ui grey disabled button\"><i class=\"add to cart icon\"></i> 缺貨中</button>");

									}

								}
								else{
									out.print("<button class=\"fluid ui teal button\" id=\"add-to-arsenal\"><i class=\"add to cart icon\"></i> 取消加入軍火庫</button>");
								}

							}
							else{

								out.print("<button class=\"fluid ui brown button\" id=\"notlogin-add-to-arsenal\"><i class=\"add to cart icon\"></i> 加入軍火庫</button>");

							}
						%>

					</div>
				</div>
			<%
			}
		%>
		</div>

		<%-- 附加說明 --%>
		<div class="ui info message">
			<i class="close icon"></i>
			<div class="header">
				附加說明
			</div>

			<%=content.replaceAll("\n","<br>")%>

		</div>

		<hr class="hr-padding">

		<%
		    if (session.getAttribute("username") != null) {
		%>
				<button class="ui icon button" id="reply">
					<i class="comment icon"></i> 評論
				</button>

				<div class="ui form" id="reply_form">
					<div class="field">
						<label>說些什麼...</label>
						<textarea id="reply_content" rows="2"></textarea>
						<div class="ui small  icon  buttons fluid">
							<button class="ui button green basic" id="reply_submit">送出</button>
							<button class="ui button basic grey" id="cancel">取消</button>
						</div>
					</div>
				</div>
		<%
			}
			else{
		%>
				<button class="ui icon button" id="notlogin_reply">
					<i class="comment icon"></i> 評論
				</button>
		<%
			}
		%>

		<%-- 評論 --%>
		<div class="sixteen wide column" id="reply_container">

			<%
				// 商品留言
				int j 				= 1;
				int reply_counts 	= 0; // 宣告筆數
				ResultSet reply_rs 	= con.createStatement().executeQuery("SELECT username, content, date FROM reply WHERE item = '" + commodity_id + "' ORDER BY id ASC");

				// 移動到最後一筆
				reply_rs.last();

				// 留言總筆數
				reply_counts += reply_rs.getRow();

				// 回到第一筆，因為剛剛被我last了
				reply_rs.beforeFirst();

				if (reply_counts == 0) {
				%>
					<div class="ui success message" id="first-reply-message">
						<i class="close icon"></i>
						<div class="header">
							快搶頭鄉吧！
						</div>
					</div>
				<%
				}
				else{

					while (reply_rs.next()) {
				%>
						<div class="ui secondary segment">
							<p>
								<a class="ui blue basic label">
									<%=j%># - <%=reply_rs.getString("username")%>
								</a>
								<a class="ui grey basic label">
									<%=reply_rs.getString("date")%>
								</a>
								<p>
									<%=reply_rs.getString("content").replaceAll("\n","<br>")%>
								</p>
							</p>
						</div>
				<%
						j++;
					}

				}

			%>

		</div>

	</div>

</div>

<%-- 提示註冊/登入 modal --%>
<div class="ui basic modal" id="register-modal">
	<i class="close icon"></i>
	<div class="header">
		立即註冊即可留言及使用軍火庫系統！
	</div>
	<div class="image content">
		<div class="image">
			<i class="archive icon"></i>
		</div>
		<div class="description">
			<p>
				覺得商品很吸引你想給個評價或留言嗎？趕快註冊就能發言囉！
			</p>
			<p>
				軍火庫系統能讓您收藏槍枝。
			</p>
		</div>
	</div>
	<div class="actions">
		<div class="three fluid ui inverted buttons">
			<div class="ui red basic inverted button" id="close">
				<i class="remove icon"></i>
				不要阿
			</div>
			<div class="ui orange inverted basic button" onclick="window.location.href='../login.jsp'">
				<i class="user icon"></i>
				登入
			</div>
			<div class="ui green basic button" onclick="window.location.href='../register.jsp'">
				<i class="add icon"></i>
				立即註冊
			</div>
		</div>
	</div>
</div>


<script>

	var d = new Date();

	// 解決不滿yyyy-mm-dd問題
	var month = d.getMonth()+1;
	if (month < 10)
		month = "0" + month;

	// Get today yyyy-mm-dd
	var strDate = d.getFullYear() + "-" + month + "-" + d.getDate();

	// reply counts
	var i = <%=j%>;

	// auto hide reply form
	$("#reply_form").hide('fast');

	// show reply window
	$("#reply").click(function(){
		$("#reply_form").show('fast');
		$("#reply").hide('fast');
	});

	// cancel reply window
	$("#cancel").click(function(){
		$("#reply_form").hide('fast');
		$("#reply").show('fast');
	});

	// reply function
	$("#reply_submit").click(function() {

		$.ajax({
			url: '<%=base_url%>ajax/reply.jsp',
			type: "POST",
			data: {username : "<%=session.getAttribute("username")%>", item : <%=commodity_id%>, reply_content : $("#reply_content").val(), date : strDate},

			success: function(response){

				$("#reply_container").append(

					'<div class="ui secondary segment">' +
						'<p>' +
							'<a class="ui blue basic label">' +
							 	i + '# - ' + "<%=session.getAttribute("username")%>" +
							'</a> ' +
							'<a class="ui grey basic label">' +
							 	strDate +
							'</a>' +
							'<p>' +
								$("#reply_content").val().replace(/\n/g, "<br />") +
							'</p>' +
						'</p>' +
					'</div>'

				);

				$("#reply_content").val("");
				$("#reply_form").hide('fast');
				$("#first-reply-message").hide('fast');
				$("#reply").show('fast');
				i++;
			}
		});
	});

	$("#notlogin_reply, #notlogin-add-to-arsenal").click(function(){
		$('.ui.modal').modal('show');
	});

	$("#close").click(function(){
		$('.ui.modal').modal('hide');
	});

	// 加入購物車
	$("#add-to-arsenal").click(function(){

		var currently = $("#add-to-arsenal").attr('class');

		if (currently == "fluid ui brown button" || currently == "fluid ui button brown") {

			$.ajax({
				url: '<%=base_url%>ajax/add_to_arsenal.jsp',
				type: "POST",
				data: {username : "<%=session.getAttribute("username")%>", item : <%=commodity_id%>, date : strDate, price : "<%=price%>", counts : $("#buy-counts").val()},

				success: function(response){

					$("#add-to-arsenal").removeClass("brown");
					$("#add-to-arsenal").addClass("teal");
					$("#add-to-arsenal").text("取消加入軍火庫");

				}
			});

		}
		else{

			$.ajax({
				url: '<%=base_url%>ajax/add_to_arsenal.jsp',
				type: "POST",
				data: {username : "<%=session.getAttribute("username")%>", item : <%=commodity_id%>, date : strDate},

				success: function(response){

					$("#add-to-arsenal").removeClass("teal");
					$("#add-to-arsenal").addClass("brown");
					$("#add-to-arsenal").html('<i class="add to cart icon"></i> 加入軍火庫');

				}
			});

		}
	});

	$(document).attr("title", "<%=type_name%>");
</script>

</body>
</html>
