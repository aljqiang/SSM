<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>系统超时跳转页面</title>
<%@ include file="/KJAF/include.jsp"%>
<script>
	top._unloadText = '系统超时，请重新登录!';
	top._unloadFlag = false;
	top.location.href=g_contextPath+'/page/frame/login.jsp?code='+_request_code+'&msg='+_request_msg;
	//top.location.href=g_contextPath+"/index.jsp";
</script>
</head>
<body>
</body>
</html>
