<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<%
    request.setCharacterEncoding("UTF-8"); // 宣告UTF-8，才能存中文
    Statement repty         = con.createStatement();
    String keywords         = request.getParameter("keywords"); // 關鍵字

    // 用LIKE模糊搜尋
    ResultSet commodity_rs 	= sql.executeQuery("SELECT * FROM commodity WHERE name LIKE '%" + keywords + "%' OR meta LIKE '%" + keywords + "%' ORDER BY id DESC");

    // 把抓到的商品跑迴圈用 ajax 秀出來
    while (commodity_rs.next()) {
%>
		<div class="column">
			<div class="ui card centered fluid">
				<a class="image" href="commodity/item.jsp?id=<%=commodity_rs.getString("id")%>">
					<div class="ui orange ribbon label">
						<i class="dollar icon"></i> <%=commodity_rs.getString("price")%>
					</div>
					<img src="<%=commodity_rs.getString("pic")%>">
				</a>
				<div class="content">
					<a class="header" href="commodity/item.jsp?id=<%=commodity_rs.getString("id")%>"><%=commodity_rs.getString("name")%></a>
					<div class="meta">
						<a href="commodity/item.jsp?id=<%=commodity_rs.getString("id")%>">
							<%=commodity_rs.getString("meta")%>
						</a>
					</div>
				</div>
			</div>
		</div>
<%
	}
%>
