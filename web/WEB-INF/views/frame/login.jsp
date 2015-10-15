<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title></title>
	<%@ include file="/KJAF/include.jsp"%>
	<script src="<%=path%>/page/frame/js/loginScript.js" type="text/javascript"></script>
	<!--script>if(top!=self) top.location.href=location.href;</script-->
</head>

<body>
<div class="login_logo"></div>

<div id="form1_container" class="login">
	<div class="pic_sys1"></div>
	<div id="form1" class="form"></div>
</div>
<!--div id="form2_container" class="login">
	<div class="pic_sys2"></div>
	<div id="form2" class="form"></div>
</div-->
<div class="warning loginBrowserWarning">
	<ul id="browserWarning"></ul>
</div>
</body>
</html>