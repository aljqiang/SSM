<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>test</title>
<body>
<%--${sessionInfo.name}--%>
<%--${sessionInfo.loginname}--%>
${FileDir}
<a href='/downloadFile.down?filename=UPLOAD/test1.pdf&realname=test1.pdf'>下载</a>
<a href='/fileOperServlet.down?filename=UPLOAD/test1.pdf&realname=test1.pdf'>查看</a>
</body>
</html>