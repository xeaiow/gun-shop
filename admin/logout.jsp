<%
session.setAttribute("admin_username", null);

session.invalidate();
response.sendRedirect("login.jsp");
%>
