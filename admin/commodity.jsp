<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>商品管理</title>
	<link rel="stylesheet" href="../assets/semantic.min.css" />
	<link rel="stylesheet" href="../assets/style.css" />
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="../assets/semantic.min.js"></script>
</head>
<body>

<%
    if ((session.getAttribute("admin_username") == null) || (session.getAttribute("admin_username") == ""))
    	response.sendRedirect("login.jsp");
%>

<%@ include file="nav.jsp" %>

<div class="ui grid">

	<div class="three wide column">
		<%@ include file="menu.jsp" %>
	</div>

	<%-- 新品推薦 --%>
	<div class="twelve wide column" id="index-banner">

		<div class="ui center aligned blue segment">
			<h1>商品管理</h1>
		</div>

		<div class="ui segment basic right aligned">
			<button type="button" class="ui button green" id="add-commodity">新增商品</button>
		</div>

		<div class="ui stackable four column grid">

		<%
			// 叫出所有商品
			ResultSet item_rs = con.createStatement().executeQuery("SELECT id, pic, meta, name FROM commodity ORDER BY id DESC");

			while (item_rs.next()) {
		%>
				<div class="column">
					<div class="ui card centered fluid">
						<a class="image" href="<%=base_url%>commodity/item.jsp?id=<%=item_rs.getString("id")%>" target="_blank">
							<img src="<%=item_rs.getString("pic")%>">
						</a>
						<div class="content">
							<a class="header" href="<%=base_url%>commodity/item.jsp?id=<%=item_rs.getString("id")%>" target="_blank"><%=item_rs.getString("name")%></a>
							<div class="meta center aligned" style="margin-top:20px;">
								<a href="<%=base_url_admin%>commodity_edit.jsp?id=<%=item_rs.getString("id")%>"><button type="button" class="ui button green basic">編輯</button></a>
							</div>
						</div>
					</div>
				</div>
		<%
			}
		%>

		</div>

	</div>

</div>

<%-- full model --%>
<div class="ui fullscreen modal transition visible active" id="add-commodity-modal">
	<i class="close icon"></i>
	<div class="header">
		新增商品
	</div>
	<div class="content">
		<div class="ui grid">
			<div class="five wide column"></div>
			<div class="six wide column">
				<div class="ui form">
					<div class="field">
						<label>商品名稱</label>
						<input type="text" id="name">
					</div>
					<div class="field">
						<label>簡介</label>
						<input type="text" id="meta">
					</div>
					<div class="field">
						<label>父類別</label>
							<select class="ui dropdown" id="type">
								<option value="">選擇類別</option>
								<option value="1">武器</option>
								<option value="2">裝備</option>
							</select>
					</div>
					<div class="field">
						<label>子類別</label>
							<select class="ui dropdown" id="subtype">
								<option value="">選擇類別</option>
								<option value="1">手槍</option>
								<option value="2">步槍</option>
								<option value="3">散彈槍</option>
								<option value="4">狙擊槍</option>
								<option value="5">頭盔</option>
								<option value="6">戰術背心</option>
								<option value="7">戰靴</option>
							</select>
					</div>
					<div class="field">
						<label>內容</label>
						<textarea id="content" rows="8" cols="40"></textarea>
					</div>
					<div class="field">
						<label>機型</label>
						<input type="text" id="model">
					</div>
					<div class="field">
						<label>吋</label>
						<input type="text" id="inch">
					</div>
					<div class="field">
						<label>長度</label>
						<input type="text" id="length">
					</div>
					<div class="field">
						<label>重量</label>
						<input type="text" id="weight">
					</div>
					<div class="field">
						<label>材質</label>
						<input type="text" id="material">
					</div>
					<div class="field">
						<label>初速</label>
						<input type="text" id="speed">
					</div>
					<div class="field">
						<label>裝彈數</label>
						<input type="text" id="clip">
					</div>
					<div class="field">
						<label>價格</label>
						<input type="text" id="price">
					</div>
					<div class="field">
						<label>圖片</label>
						<input type="text" id="pic">
					</div>
					<div class="field">
						<label>庫存</label>
						<input type="text" id="stock">
					</div>
				</div>
			</div>
			<div class="five wide column"></div>
		</div>
		<div class="actions">
			<div class="ui green button" id="check-add">確定新增</div>
		</div>
	</div>
</div>


<script>
	$("#add-commodity-modal").modal('hide');

	// 開啟新增商品 modal
	$("#add-commodity").click(function(){
		$("#add-commodity-modal").modal('show');
	});

	$("#check-add").click(function(){

		$.ajax({
            url: '<%=base_url_admin%>ajax/commodity_add.jsp',
            type: "POST",
            data: {
                name     : $("#name").val(),
                meta     : $("#meta").val(),
                type     : $("#type").val(),
                subtype  : $("#subtype").val(),
                content  : $("#content").val(),
                model    : $("#model").val(),
                inch     : $("#inch").val(),
                length   : $("#length").val(),
                weight   : $("#weight").val(),
                material : $("#material").val(),
                speed    : $("#speed").val(),
                clip     : $("#clip").val(),
                price    : $("#price").val(),
                pic      : $("#pic").val(),
                stock    : $("#stock").val(),
            },

            success: function(response){

                window.location.reload();

            }
        });

	});
</script>

</body>
</html>
