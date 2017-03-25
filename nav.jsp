<%@page contentType="text/html" pageEncoding="UTF-8"%>


<div class="ui top fixed menu">

	<div class="item">

		<img src="//semantic-ui.com/images/logo.png">

	</div>

	<a class="item" href="<%=base_url%>"><i class="fire icon"></i> 最新商品</a>


	<%

		// 登入後使用者的名稱
		String name = (String)session.getAttribute("name");

		// 登入狀態就顯示以下功能
	    if (name != null) {
	    	out.print(
				"<a class=\"item\" href=\"" + base_url + "arsenal.jsp\"><i class=\"block layout icon\"></i>" + session.getAttribute("name") + "的軍火庫</a>" +
				"<a class=\"item\" href=\"" + base_url + "logout.jsp\">登出</a>"
			);
	    }
	    else{
			out.print("<a class=\"item\" href=\"" + base_url + "login.jsp\">登入</a>" + "<a class=\"item\" href=\"" + base_url + "register.jsp\">註冊</a>");
		}
	%>

	<a class="item" href="<%=base_url%>group.jsp"><i class="user icon"></i> 組員介紹</a>

	<div class="item">
		<div class="ui icon input">
		<input type="text" placeholder="找什麼咧..." id="keywords">
			<i class="circular search link icon" id="search"></i>
		</div>
	</div>

</div>

<script>
	// ajax 搜尋
	$("#search").click(function(){

        $.ajax({
            url: '<%=base_url%>ajax/search.jsp',
            type: "POST",
            dataType:'html',
            data: {keywords :　$("#keywords").val()},
            success: function(data){

                $("#search-block").html(data);

            },
        });

	});

	$("#keywords").keypress(function(e){
		code = (e.keyCode ? e.keyCode : e.which);
		if (code == 13) {
			$.ajax({
	            url: '<%=base_url%>ajax/search.jsp',
	            type: "POST",
	            dataType:'html',
	            data: {keywords :　$("#keywords").val()},
	            success: function(data){

	                $("#search-block").html(data);

	            },
	        });
		}
	});
</script>
