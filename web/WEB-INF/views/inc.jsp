<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="edge" />
<link rel="shortcut icon" href="${ctx}/style/images/index/favicon.png" />
<!-- 引入my97日期时间控件 -->
<script type="text/javascript" src="${ctx}/jslib/My97DatePicker/WdatePicker.js" charset="utf-8"></script>

<!-- 引入jQuery -->
<script src="${ctx}/jslib/jquery-1.8.3.js" type="text/javascript" charset="utf-8"></script>

<!-- 引入EasyUI -->
<%--<link id="easyuiTheme" rel="stylesheet" href="${ctx}/jslib/easyui1.4/themes/<c:out value="${cookie.easyuiThemeName.value}" default="default"/>/easyui.css" type="text/css">--%>
<link id="easyuiTheme" rel="stylesheet" href="${ctx}/jslib/easyui1.4/themes/bootstrap/easyui.css" type="text/css">
<link id="easyuiTheme" rel="stylesheet" href="${ctx}/jslib/easyui1.4/themes/bootstrap/accordion.css" type="text/css">
<link id="orange" rel="stylesheet" href="${ctx}/jslib/easyui1.4/themes/orange/css/searchtable.css" type="text/css">
<link id="orange" rel="stylesheet" href="${ctx}/jslib/easyui1.4/themes/orange/css/index.css" type="text/css">
<script type="text/javascript" src="${ctx}/jslib/easyui1.4/jquery.easyui.min.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/jslib/easyui1.4/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>

<!-- 扩展EasyUI -->
<script type="text/javascript" src="${ctx}/jslib/extEasyUI.js" charset="utf-8"></script>

<!-- 扩展Jquery -->
<script type="text/javascript" src="${ctx}/jslib/extJquery.js" charset="utf-8"></script>

<!-- 自定义工具类 -->
<script type="text/javascript" src="${ctx}/jslib/common.js" charset="utf-8"></script>

<!-- 扩展EasyUI图标 -->
<link rel="stylesheet" href="${ctx}/style/common.css" type="text/css">
<link rel="stylesheet" href="${ctx}/style/callManage.css" type="text/css">

<!-- 引入选项卡操作方法 -->
<script type="text/javascript" src="${ctx}/jslib/baseTabs.js" charset="utf-8"></script>

<!-- 引入文字滚动 -->
<script type="text/javascript" src="${ctx}/jslib/scroll.js" charset="utf-8"></script>
<link rel="stylesheet" href="${ctx}/style/scroll.css" type="text/css">


<script type="text/javascript">
$(window).load(function(){
	$("#loading").fadeOut();

    var tabsId = 'index_tabs';//tabs页签Id
    var tab_rightmenuId = 'tab_rightmenu';//tabs右键菜单Id

    // 绑定tabs的右键菜单
    $("#"+tabsId).tabs({
        onContextMenu:function(e,title){//这时去掉 tabsId所在的div的这个属性：class="easyui-tabs"，否则会加载2次
            e.preventDefault();
            $('#'+tab_rightmenuId).menu('show',{
                left: e.pageX,
                top: e.pageY
            }).data("tabTitle",title);
        }
    });

    // 实例化menu的onClick事件
    $("#"+tab_rightmenuId).menu({
        onClick:function(item){
            TabsOperate.CloseTab(tabsId,tab_rightmenuId,item.name);
        }
    });
});

//公共方法
var pubMethod = {
    bind: function (control,code) {
        if (control == ''|| code == '')
        {
            return;
        }

        $('#'+ control).combobox({
            url: '${ctx}/dictionary/combox?code=' + code,
            method: 'get',
            valueField: 'code',
            textField: 'text',
            editable: false,
            panelHeight: 'auto',
            required:true
        });
    }
}
</script>
