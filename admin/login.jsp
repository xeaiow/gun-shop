<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="setting.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>管理員系統登入 - 辰辰購物網</title>
	<link rel="stylesheet" href="<%=base_url%>assets/semantic.min.css" />
	<link rel="stylesheet" href="<%=base_url%>assets/admin-style.css" />
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="<%=base_url%>assets/semantic.min.js"></script>
	<style>
		body{
			background-image: url(../assets/img/bg3.png);
		}
	</style>
</head>
<body>

<%
	// 如果登入狀態就跳轉到儀表
	if (session.getAttribute("admin_username") != null)
		response.sendRedirect(base_url_admin);
%>

<div class="ui grid">
	<div class="six wide column" id="admin_login_form">
		<div class="ui segment basic center aligned">
			<img src="<%=base_url%>assets/img/banner.png" alt="" />
		</div>
		<form class="ui form" method="POST" action="login_handle.jsp" id="login">
			<div class="field">
				<label>帳號</label>
				<input type="text" name="username">
			</div>
			<div class="field">
				<label>金鑰</label>
				<input type="password" name="password">
			</div>
			<button class="fluid ui button black">進入</button>
		</form>
	</div>
</div>

</body>
</html>
