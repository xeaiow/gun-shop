<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="config.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>加入辰辰購物網</title>
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

<div class="ui grid" id="register_container">
	<div class="seven wide column" id="register_container">
		<div class="ui form">
			<div class="sixteen field">
				<div class="field username">
					<label>帳號</label>
					<input type="text" id="username" placeholder="4-16 英文及數字">
				</div>
			</div>

			<div class="two fields">
				<div class="field psw">
					<label>密碼</label>
					<input type="password" id="psw" placeholder="6-20 英文及數字">
				</div>
				<div class="field psw">
					<label>確認密碼</label>
					<input type="password" id="ck_psw" placeholder="6-20 英文及數字">
				</div>
			</div>

			<div class="two fields">

				<div class="field">
					<label>姓名</label>
					<input type="text" id="name">
				</div>

				<div class="field">
					<label>縣市</label>
					<select class="ui dropdown" id="area">
						<option value="">縣市</option>
						<option value="1">臺北市</option>
						<option value="2">新北市</option>
						<option value="3">桃園市</option>
						<option value="4">臺中市</option>
						<option value="5">臺南市</option>
						<option value="6">高雄市</option>
						<option value="7">基隆市</option>
						<option value="8">新竹市</option>
						<option value="9">嘉義市</option>
						<option value="10">新竹縣</option>
						<option value="11">苗栗縣</option>
						<option value="12">彰化縣</option>
						<option value="13">南投縣</option>
						<option value="14">雲林縣</option>
						<option value="15">嘉義縣</option>
						<option value="16">屏東縣</option>
						<option value="17">宜蘭縣</option>
						<option value="18">花蓮縣</option>
						<option value="19">臺東縣</option>
						<option value="20">澎湖縣</option>
						<option value="21">海外</option>
					</select>
				</div>
			</div>

			<div class="one field">
				<div class="field">
					<label>地址</label>
					<input type="text" id="address">
				</div>
			</div>

			<div class="two fields">
				<div class="field">
					<label>聯絡電話</label>
					<input type="text" id="tel" />
				</div>
				<div class="field">
					<label>電子信箱</label>
					<input type="email" id="email" />
				</div>
			</div>

			<div class="two fields">
				<div class="field">
					<label>生日</label>
					<input type="date" id="birth" />
				</div>
				<div class="field">
					<label>性別</label>
					<div class="field">
						<select class="ui dropdown" id="gender">
							<option value="">性別</option>
							<option value="1">男</option>
							<option value="0">女</option>
						</select>
					</div>
				</div>
			</div>

			<div class="ui two bottom attached buttons">
				<div class="ui button black" id="register">立刻註冊</div>
				<div class="ui button blue" id="login">我已經有帳號</div>
			</div>
	</div>
</div>

<script>
	$('select.dropdown').dropdown();
	$('.ui.radio.checkbox').checkbox();
	$("#register").click(function(){

		// 存成變數(好辨識)
		var username = $("#username").val();
		var psw = $("psw").val();
		var ck_psw = $("ck_psw").val();
		var name = $("name").val();
		var area = $("area").val();
		var address = $("address").val();
		var tel = $("tel").val();
		var email = $("email").val();
		var birth = $("birth").val();
		var gender = $("gender").val();

		// 判斷是否每個欄位都有輸入值
		if (username != '' && psw != '' && ck_psw != '' && name != '' && area != '' && address != '' && tel != '' && email != '' && birth != '' && gender != '') {

			// ajax 可不需要form表單
			$.ajax({
				url: '<%=base_url%>ajax/register_handle.jsp',
				type: "POST",
				data: {username : $("#username").val(), psw : $("#psw").val(), ck_psw : $("#ck_psw").val(), name : $("#name").val(), area : $("#area").val(), address : $("#address").val(), tel : $("#tel").val(), email : $("#email").val(), birth : $("#birth").val(), gender : $("#gender").val()},
				success: function(response){

					switch (trim(response)) {
						case "1":
							Messenger().post({
								message: "帳號只能輸入4-16字元的英文及數字！",
								type: 'error',
								hideAfter: 1,
								hideOnNavigate: true
							});
							$("#username").val("");
							$(".username").addClass('error');
							break;
						case "2":
							Messenger().post({
								message: "密碼只能輸入6-20字元的英文及數字！",
								type: 'error',
								hideAfter: 1,
								hideOnNavigate: true
							});
							$(".psw").addClass('error');
							$("#psw").val("");
							$("#ck_psw").val("");
							break;
						case "3":
							Messenger().post({
								message: "密碼與確認密碼不相符！",
								type: 'error',
								hideAfter: 1,
								hideOnNavigate: true
							});
							$(".psw").addClass('error');
							$("#psw").val("");
							$("#ck_psw").val("");
							break;
						case "4":
							Messenger().post({
								message: "帳號已被註冊，請更換別的！",
								type: 'error',
								hideAfter: 1,
								hideOnNavigate: true
							});
							$("#username").val("");
							$(".username").addClass('error');
							break;
						case "5":
							Messenger().post({
								message: "註冊成功！趕快購買幾把武器防身吧！",
								hideAfter: 1,
								hideOnNavigate: true
							});
							$(function(){
								setTimeout(function(){
									location.href = '<%=base_url%>login.jsp';
								},800)
							});
							break;
					}
				}
			});
		}
		else{

			Messenger().post({
				message: "填寫所有欄位阿笨蛋！",
				type: 'error',
				hideAfter: 1,
				hideOnNavigate: true
			});

		}
	});

	function trim(str) {
		return str.replace(/(^\s+)|(\s+$)/g, "");
	}
</script>

</body>
</html>
