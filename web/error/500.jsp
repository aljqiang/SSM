<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%
    String msg;
    if (exception != null) {
        //exception.printStackTrace();
        //System.out.println("-------------------------");
        java.io.StringWriter sw = new java.io.StringWriter();
        //exception.printStackTrace(out);
//	exception.printStackTrace(new java.io.PrintWriter(sw));
        msg = exception.getMessage();
//		out.println(exception.getMessage());
    } else {
        msg = "请与系统管理员联系！";
//		out.println("请与系统管理员联系！");
    }
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

    <!-- Viewport metatags -->
    <meta name="HandheldFriendly" content="true"/>
    <meta name="MobileOptimized" content="320"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>

    <link rel="stylesheet" type="text/css" href="${ctx}/error/css/dandelion.css" media="screen"/>

    <title>500错误页面</title>

</head>

<body>

<!-- Main Wrapper. Set this to 'fixed' for fixed layout and 'fluid' for fluid layout' -->
<div id="da-wrapper" class="fluid">

    <!-- Content -->
    <div id="da-content">

        <!-- Container -->
        <div class="da-container clearfix">

            <div id="da-error-wrapper">

                <div id="da-error-pin"></div>
                <div id="da-error-code">
                    error <span>500</span></div>

                <h1 class="da-error-heading"><%=msg%>
                </h1>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <%--<div id="da-footer">--%>
    <%--<div class="da-container clearfix">--%>
    <%--<p> Copyright ©2015-2015 Larry Lai, All Rights Reserved</div>--%>
    <%--</div>--%>
</div>

</body>
</html>
