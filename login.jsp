<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="config.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>辰辰購物網</title>
	<link rel="stylesheet" href="assets/semantic.min.css" />
	<link rel="stylesheet" href="assets/style.css" />
	<link href="assets/messenger.css" rel="stylesheet" media="screen">
	<link href="assets/messenger-theme-future.css" rel="stylesheet" media="screen">
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="assets/semantic.min.js"></script>
	<script src="assets/messenger.min.js"></script>
	<script src="assets/messenger-theme-flat.js"></script>
</head>
<body>

<%@ include file="nav.jsp" %>

<div class="ui grid" id="container">
	<div class="six wide column" id="login_container">
		<div class="ui segment basic center aligned">
			<img src="assets/img/banner.png" alt="" />
		</div>
		<div class="ui form" id="login_form">
			<div class="field">
				<label>帳號</label>
				<input type="text" id="username">
			</div>
			<div class="field">
				<label>密碼</label>
				<input type="password" id="password">
			</div>
			<div class="ui two bottom attached buttons">
				<div class="ui button black" id="login">立刻登入</div>
				<div class="ui button blue" id="register" data-content="立即索取折價券乙份" data-variation="wide">馬上加入</div>
			</div>
		</div>
	</div>
</div>

<script>
	$("#register").click(function(){location.href = '<%=base_url%>register.jsp'});
	$('.blue').popup();
	$("#login").click(function(){
		if ($("#username").val() && $("#password").val()) {

			$.ajax({
				url: '<%=base_url%>ajax/login_handle.jsp',
				type: "POST",
				data: {username : $("#username").val(), password : $("#password").val()},
				success: function(response){
					if (response == 1) {
						Messenger().post({
							message: "登入成功！",
							hideAfter: 1,
							hideOnNavigate: true
						});
						$(function(){
							setTimeout(function(){
								location.href = '<%=base_url%>';
							},800)
						});
					}
					else if (response == 2){
						Messenger().post({
							message: "密碼錯誤！",
							type: 'error',
							hideAfter: 1,
							hideOnNavigate: true
						});
					}
					else if (response == 3){
						Messenger().post({
							message: "帳號只能輸入4-16字元的英文及數字！",
							type: 'error',
							hideAfter: 1,
							hideOnNavigate: true
						});
					}
					else if (response == 4){
						Messenger().post({
							message: "密碼只能輸入6-20字元的英文及數字！",
							type: 'error',
							hideAfter: 1,
							hideOnNavigate: true
						});
					}
				}
			});

		}
		else{

			Messenger().post({
				message: "請填寫帳號及密碼欄位！",
				type: 'error',
				hideAfter: 1,
				hideOnNavigate: true
			});

		}
	});
</script>

</body>
</html>
