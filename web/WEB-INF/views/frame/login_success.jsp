<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>登录成功跳转页面</title>
<%@ include file="/KJAF/include.jsp"%>
<script>
function openFrame(){
	var rsltObj = _request_result[0];
	var url = g_contextPath+'/page/frame/frame.jsp?ygbh='+rsltObj.ygbh
		+'&telNumber='+rsltObj.telNumber
		+'&agentType='+rsltObj.agentType;
	var winParms = 'height='+(window.screen.availHeight - 38)+','; 
	winParms+= 'width='+(window.screen.availWidth - 11)+','; 
	winParms+='left=0,top=0,status=no,toolbar=no,menubar=no,location=no,resizable=yes,scrollbars=yes,'; 
  
  
	window.opener = null;
	var oModal =window.open(url,'_blank', winParms); 
	if (oModal!=undefined){
		if($.browser.msie && $.browser.version < 7.0)
			window.close();
		else {
			window.opener = null;
			window.open('','_self','');
			window.close();
		}
	}
	else alert('您的浏览器阻止了弹出窗口。为了能够正常使用系统，请允许本站点的弹出窗口！谢谢！'); 
}
openFrame();
</script>
</head>
<body>
<div class="abnormal">
	<div class="title">本页面为系统登录过程中的自动处理页面，正常情况下您不应该看到本页</div>
	<div class="desc">
	某些特殊情况会导致本窗口无法自动关闭，如使用了非 Microsoft Internet Explorer 的浏览器或安装了
	<br/>
	某些特定的第三方插件。
	<br/><br/>
	通常情况下这不会对系统正常运行造成影响，您可以随时关闭本窗口。
	</div>
</div>
</body>
</html>
