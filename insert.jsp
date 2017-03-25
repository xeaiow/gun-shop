
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="config.jsp" %>
<%@page import="java.util.*" %>
<%

    request.setCharacterEncoding("UTF-8"); // 宣告UTF-8，才能存中文
    String username     =   request.getParameter("username");       // 購買/加入軍火庫的使用者
    String card_type    =   request.getParameter("card_type");      // 卡片類型
    String card_number  =   request.getParameter("card_number");    // 卡號(尚未開放)
    String recipient    =   request.getParameter("recipient");      // 包裹接收者
    String address      =   request.getParameter("address");        // 運送地址
    String remark       =   request.getParameter("remark");         // 備註

    Statement repty = con.createStatement();
    ResultSet repty_rs;

    con.createStatement().executeUpdate("UPDATE arsenal SET bought = '1', paid = '1', less = '0', card_type = '" + card_type + "', card_number = '" + card_number + "', recipient = '" + recipient + "', address = '" + address + "', remark = '" + remark + "' WHERE username = '" + username + "' AND paid = '0'");

    ResultSet arsenal_item_rs = con.createStatement().executeQuery("SELECT * FROM arsenal WHERE username = '" + username + "' AND bought = '1' AND paid = '1' AND less = '0'");

    // 產生訂單編號(防止數筆商品變成很多筆訂單)
    Random rand = new Random();
    int rnds = rand.nextInt(90000000) + 10000000;

    while (arsenal_item_rs.next()) {

        String item         =   arsenal_item_rs.getString("item");
        String id           =   arsenal_item_rs.getString("id");
        String order_form   =   arsenal_item_rs.getString("order_form");

        if (order_form == null) {
            con.createStatement().executeUpdate("UPDATE commodity SET stock = stock - 1 WHERE id = '" + item + "'");
            con.createStatement().executeUpdate("UPDATE arsenal SET order_form = '" + rnds + "' WHERE id = '" + id + "'");
        }
    }
%>
