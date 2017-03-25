<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>編輯商品</title>
	<link rel="stylesheet" href="../assets/semantic.min.css" />
	<link rel="stylesheet" href="../assets/style.css" />
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="../assets/semantic.min.js"></script>
</head>
<body>

	<%
		// 判斷是否登入
		if ((session.getAttribute("admin_username") == null) || (session.getAttribute("admin_username") == ""))
			response.sendRedirect("/end/admin/login.jsp");
	%>

<%@ include file="nav.jsp" %>

<div class="ui grid">


	<div class="three wide column"></div>

    <%
        // 商品代號
        String id = request.getParameter("id");

        ResultSet profile_rs = con.createStatement().executeQuery("SELECT * FROM commodity AS c, type AS t, subtype AS s WHERE c.id = '" + id + "' AND c.type = t.id AND c.subtype = s.id");
        profile_rs.next();
        String title = profile_rs.getString("c.name");

    %>

	<%-- 商品資料 --%>
	<div class="fifteen wide column centered" id="index-banner">

        <div class="ui grid">
            <div class="four wide column">
                <div class="ui card">
                    <div class="image">
                        <img src="<%=profile_rs.getString("c.pic")%>">
                    </div>
                    <div class="content">
                        <a class="header center aligned"><%=profile_rs.getString("c.name")%></a>
                    </div>
                </div>
            </div>
            <div class="twelve wide column" id="view-content">
                <button type="button" class="ui button blue" id="edit">編輯</button>
                <button type="button" class="ui button red" id="delete">刪除</button>
                <table class="ui very basic table">
                    <tbody>
                        <tr>
                            <td class="three wide table-th">簡介</td>
                            <td><%=profile_rs.getString("c.meta")%></td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">父類別</td>
                            <td><%=profile_rs.getString("t.name")%></td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">子類別</td>
                            <td><%=profile_rs.getString("s.name")%></td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">內容</td>
                            <td><%=profile_rs.getString("c.content")%></td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">機型</td>
                            <td><%=profile_rs.getString("c.model")%></td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">吋</td>
                            <td><%=profile_rs.getString("c.inch")%></td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">長度</td>
                            <td><%=profile_rs.getString("c.length")%></td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">重量</td>
                            <td><%=profile_rs.getString("c.weight")%></td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">材質</td>
                            <td><%=profile_rs.getString("c.material")%></td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">初速</td>
                            <td><%=profile_rs.getString("c.speed")%></td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">裝彈數</td>
                            <td><%=profile_rs.getString("c.clip")%></td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">價格</td>
                            <td><%=profile_rs.getString("c.price")%></td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">圖片</td>
                            <td><%=profile_rs.getString("c.pic")%></td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">庫存</td>
                            <td><%=profile_rs.getString("c.stock")%></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="twelve wide column" id="edit-content">
                <%-- 編輯用 --%>
                <table class="ui very basic table">
                    <tbody>
                        <tr>
                            <td class="three wide table-th">商品名</td>
                            <td>
                                <div class="ui input">
                                    <input type="text" id="name" value="<%=profile_rs.getString("c.name")%>">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">簡介</td>
                            <td>
                                <div class="ui input">
                                    <input type="text" id="meta" value="<%=profile_rs.getString("c.meta")%>">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">父類別</td>
                            <td>
                                <div class="ui input">
                                    <input type="text" id="type" value="<%=profile_rs.getString("t.name")%>">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">子類別</td>
                            <td>
                                <div class="ui input">
                                    <input type="text" id="subtype" value="<%=profile_rs.getString("s.name")%>">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">內容</td>
                            <td>
                                <div class="ui form">
                                    <div class="field">
                                        <textarea id="content" rows="8" cols="40"><%=profile_rs.getString("c.content")%></textarea>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">機型</td>
                            <td>
                                <div class="ui input">
                                    <input type="text" id="model" value="<%=profile_rs.getString("c.model")%>">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">吋</td>
                            <td>
                                <div class="ui input">
                                    <input type="text" id="inch" value="<%=profile_rs.getString("c.inch")%>">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">長度</td>
                            <td>
                                <div class="ui input">
                                    <input type="text" id="length" value="<%=profile_rs.getString("c.length")%>">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">重量</td>
                            <td>
                                <div class="ui input">
                                    <input type="text" id="weight" value="<%=profile_rs.getString("c.weight")%>">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">材質</td>
                            <td>
                                <div class="ui input">
                                    <input type="text" id="material" value="<%=profile_rs.getString("c.material")%>">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">初速</td>
                            <td>
                                <div class="ui input">
                                    <input type="text" id="speed" value="<%=profile_rs.getString("c.speed")%>">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">裝彈數</td>
                            <td>
                                <div class="ui input">
                                    <input type="text" id="clip" value="<%=profile_rs.getString("c.clip")%>">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">價格</td>
                            <td>
                                <div class="ui input">
                                    <input type="text" id="price" value="<%=profile_rs.getString("c.price")%>">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">圖片</td>
                            <td>
                                <div class="ui input">
                                    <input type="text" id="pic" value="<%=profile_rs.getString("c.pic")%>">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="three wide table-th">庫存</td>
                            <td>
                                <div class="ui input">
                                    <input type="text" id="stock" value="<%=profile_rs.getString("c.stock")%>">
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <button type="button" class="ui button black" id="check-edit">確定修改</button>
                <button type="button" class="ui button grey" id="cancel">取消</button>
            </div>

        </div>

	</div>

</div>

<%-- 確認model --%>
<div class="ui basic modal" id="checkdelete-modal">
	<i class="close icon"></i>
	<div class="header">
		確定刪除該項商品？
	</div>
	<div class="image content">
		<div class="image">
			<i class="archive icon"></i>
		</div>
		<div class="description">
			<p>
				刪除後商品資訊將永久消失。
			</p>
		</div>
	</div>
	<div class="actions">
		<div class="three fluid ui inverted buttons">
			<div class="ui red basic inverted button" id="close">
				<i class="remove icon"></i>
				否，再考慮
			</div>
			<div class="ui green basic button" id="sure-delete">
				<i class="checkmark icon"></i>
				是，我確定
			</div>
		</div>
	</div>
</div>

<script>
    $("#edit-content").hide();
    $(document).attr("title", "編輯 <%=title%>");

    $("#edit").click(function(){
        $("#view-content").fadeOut();
        $("#edit-content").fadeIn();
    });

    $("#cancel").click(function(){
        $("#edit-content").fadeOut();
        $("#view-content").fadeIn();
    });

    $("#delete").click(function(){
        $("#checkdelete-modal").modal('show');
    });

    // 確認刪除
    $("#sure-delete").click(function(){

        $.ajax({
            url: '<%=base_url_admin%>ajax/commodity_delete.jsp',
            type: "POST",
            data: {
                id : "<%=id%>"
            },

            success: function(response){

                window.location.href = '<%=base_url_admin%>commodity.jsp';

            }
        });

    });

    // 編輯送出
    $("#check-edit").click(function(){

        $.ajax({
            url: '<%=base_url_admin%>ajax/commodity_edit.jsp',
            type: "POST",
            data: {
                name     : $("#name").val(),
                meta     : $("#meta").val(),
                type     : $("#type").val(),
                subtype  : $("#subtype").val(),
                content  : $("#content").val(),
                model    : $("#model").val(),
                inch     : $("#inch").val(),
                length   : $("#length").val(),
                weight   : $("#weight").val(),
                material : $("#material").val(),
                speed    : $("#speed").val(),
                clip     : $("#clip").val(),
                price    : $("#price").val(),
                pic      : $("#pic").val(),
                stock    : $("#stock").val(),
                id       : "<%=id%>"

            },

            success: function(response){

                window.location.reload();

            }
        });

    });
</script>

</body>
</html>
