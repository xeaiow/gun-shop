<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>管理員系統</title>
        <link rel="stylesheet" href="../assets/semantic.min.css" />
        <link rel="stylesheet" href="../assets/admin-style.css" />
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="../assets/semantic.min.js"></script>
    </head>
    <body>

        <%
            // 判斷是否登入
            if ((session.getAttribute("admin_username") == null) || (session.getAttribute("admin_username") == ""))
            	response.sendRedirect("/end/admin/login.jsp");

			//
			ResultSet admin_info_member = con.createStatement().executeQuery("SELECT username, name, id FROM member");
        %>

        <%@ include file="nav.jsp" %>

        <div class="ui grid">

            <div class="ten wide column statistics" style="margin:40px auto;">

                <div class="ui center aligned blue segment">
        			<h1>使用者管理</h1>
        		</div>

                <table class="ui very basic table center aligned">
                    <tbody>
                        <%
                            int i = 1;
                            while (admin_info_member.next()) {
                        %>
                            <tr>
                                <td>#<%=i%></td>
                                <td><%=admin_info_member.getString("username")%></td>
                                <td><%=admin_info_member.getString("name")%></td>
                                <td><a href="/end/admin/edit.jsp?id=<%=admin_info_member.getString("id")%>">編輯</a></td>
                            </tr>
                        <%
                                i++;
                            }
                        %>

                    </tbody>
                </table>

            </div>

        </div>

    </body>
</html>
