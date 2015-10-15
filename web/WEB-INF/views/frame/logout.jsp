<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>系统注销临时窗口</title>
<%
if(session != null){
	session.invalidate();
}
%>
<script>window.close();</script>
</head>
<body>
</body>
</html>
