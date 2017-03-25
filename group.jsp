<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="config.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>辰辰購物網</title>
	<link rel="stylesheet" href="assets/semantic.min.css" />
	<link rel="stylesheet" href="assets/style.css" />
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="assets/semantic.min.js"></script>
</head>
<body>

<%@ include file="nav.jsp" %>

<div class="ui grid">

	<%-- 組員介紹 container --%>
	<div class="twelve wide column" id="group-container">

		<div class="ui brown inverted segment center aligned">
            <h1>優秀組員介紹</h1>
        </div>

        <div class="ui stackable four column grid" id="search-block">
            <div class="column">
                <div class="ui card centered fluid">
                    <a class="image" href="#">
                        <img src="//semantic-ui.com/images/avatar2/large/elyse.png">
                    </a>
                    <div class="content">
                        <a class="header center aligned" href="#">資管三乙 - 吳冠興</a>
                        <div class="meta center aligned">
                            <a>10244256</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="column">
                <div class="ui card centered fluid">
                    <a class="image" href="#">
                        <img src="//semantic-ui.com/images/avatar/large/steve.jpg">
                    </a>
                    <div class="content">
                        <a class="header center aligned" href="#">資管二甲 - 吳禹辰</a>
                        <div class="meta center aligned">
                            <a>10344128</a>
                        </div>
                    </div>
                </div>
            </div>

        </div>
	</div>
</div>

</body>
</html>
