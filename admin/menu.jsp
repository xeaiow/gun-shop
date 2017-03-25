<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import ="java.text.*" %>
<div class="ui vertical menu" id="item_menu">

<%
    int i 			= 1; 										// 子類別的分類
    Statement sql   = con.createStatement(); 					// type
    Statement st 	= con.createStatement(); 					// subtype
    Statement ct 	= con.createStatement(); 					// counts
    ResultSet rs 	= sql.executeQuery("SELECT * FROM type"); 	// 先找父類別再找子類別

    while (rs.next()) {
%>
        <div class="item">
            <div class="header">
                <%=rs.getString("name")%>
            </div>
            <div class="menu">
<%
                ResultSet rs2 = st.executeQuery("SELECT id, name, url FROM subtype WHERE type = '" + i + "'");
                while (rs2.next()) {
%>
                    <a class="item" href="<%=base_url_admin%>type.jsp?id=<%=rs2.getString("id")%>">
                        <%=rs2.getString("name")%>
                    </a>
<%
                }
%>
            </div>
        </div>
<%
        i++;
    }
%>
</div>
