<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <!-- Viewport metatags -->
    <meta name="HandheldFriendly" content="true"/>
    <meta name="MobileOptimized" content="320"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/error/css/dandelion.css" media="screen"/>
    <title>404错误页面</title>
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
                    error <span>404</span></div>

                <h1 class="da-error-heading"><%="由于权限不足，您无法访问该资源！"%>
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
