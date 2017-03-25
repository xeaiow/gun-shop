<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="ui top fixed menu">

	<div class="item">

		<img src="//semantic-ui.com/images/logo.png">

	</div>

	<a class="item" href="<%=base_url_admin%>"><i class="tasks icon"></i> 控制台</a>
	<a class="item" href="<%=base_url_admin%>user.jsp"><i class="user icon"></i> 使用者管理</a>
	<a class="item" href="<%=base_url_admin%>commodity.jsp"><i class="block layout icon"></i> 商品管理</a>

	<%
		String name = (String)session.getAttribute("admin_username");

	    if (name != null) {

	    	out.print(
				"<a class=\"item\"><i class=\"university icon\"></i> " + session.getAttribute("admin_name") + "管理員" + "</a>" +
				"<a class=\"item\" href=\"" + base_url_admin + "logout.jsp\">登出</a>"
			);

	    }
	%>

</div>
