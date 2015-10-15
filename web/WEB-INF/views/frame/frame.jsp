<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" class="framePage">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title></title>
	<%@ include file="/KJAF/include.jsp"%>
	<script src="<%=path%>/page/frame/js/frameTab.js" type="text/javascript"></script>
	<script src="<%=path%>/page/frame/js/frame.js" type="text/javascript"></script>
</head>
<body class="framePage">
	<iframe id="topFrame" frameborder="0" framespacing="0" scrolling="no"></iframe>	<!--top-->
	<iframe id="menuFrame" frameborder="0" framespacing="0" scrolling="no"></iframe>	<!--menu-->
	<iframe id="mainFrame" frameborder="0" framespacing="0"></iframe>	<!--main-->
	<iframe id="printFrame" src="print.htm" style="display:;width:0px;height:0px;"></iframe> <!--print-->
</body>
</html>
