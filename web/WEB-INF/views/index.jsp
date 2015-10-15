<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="photo" value="${pageContext.request.contextPath}${sessionInfo.photo}"/>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="inc.jsp"></jsp:include>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>OA办公系统</title>
	<link id="easyuiTheme" rel="stylesheet" href="${ctx}/jslib/easyui1.4/themes/orange/css/common.css" type="text/css" />
	<link id="easyuiTheme" rel="stylesheet" href="${ctx}/jslib/easyui1.4/themes/orange/css/top.css" type="text/css" />
<script type="text/javascript">
	var index_layout;
	var index_tabs;
	var index_tabsMenu;
	var layout_west_tree;
	var layout_west_tree_url = '';
	var sessionInfo_userId = '${sessionInfo.id}';
	
	if (sessionInfo_userId) {//如果没有登录,直接跳转到登录页面
		layout_west_tree_url = '${ctx}/resource/tree';
	}else{
		window.location.href='${ctx}/admin/index';
	}
	$(function() {

		index_layout = $('#index_layout').layout({
			fit : true
		});
		
		index_tabs = $('#index_tabs').tabs({
			fit : true,
			border : false,
/*			tools : [{
				iconCls : 'icon_home',
				handler : function() {
					index_tabs.tabs('select', 0);
				}
			}, {
				iconCls : 'icon_refresh',
				handler : function() {
					var currTab = index_tabs.tabs('getSelected');
					var content = currTab.panel('options').content;
					index_tabs.tabs('update',{
						tab:currTab,
						options:{
							content: content
							}
					});
				}
			}, {
				iconCls : 'icon_del',
				handler : function() {
					var index = index_tabs.tabs('getTabIndex', index_tabs.tabs('getSelected'));
					var tab = index_tabs.tabs('getTab', index);
					if (tab.panel('options').closable) {
						index_tabs.tabs('close', index);
					}
				}
			} ]*/
		});

		// 加载用户菜单
		<%--$.ajax({--%>
			<%--url: "${ctx}/resource/menus",--%>
			<%--type: "post",--%>
			<%--dataType: "json",--%>
			<%--data: {},--%>
			<%--success: function (data) {--%>
				<%--alert(1);--%>
<%--//				$("#layout_west_tree").append(data[0].body);--%>
<%--//				$("#layout_west_tree").append('<div class="panel" style="width:193px;"><div title="系统管理" iconCls="icon-ok"  style="padding:10px;"><ul class="easyui-tree" data-options='+'data:[{"id":"4","text":"用户管理","attributes":{"url":"/user/manager"},"parentid":"1","children":null},{"id":"3","text":"角色管理","attributes":{"url":"/role/manager"},"parentid":"1","children":null},{"id":"20","text":"部门管理","attributes":{"url":"/organization/manager"},"parentid":"1","children":null},{"id":"2","text":"资源管理","attributes":{"url":"/resource/manager"},"parentid":"1","children":null},{"id":"69","text":"部门列表","attributes":{"url":"/dept/manager1"},"parentid":"1","children":null},{"id":"26","text":"数据字典","attributes":{"url":"/dictionary/manager"},"parentid":"1","children":null}]'+'></ul></div></div>');--%>
<%--//				alert(data[0].body);--%>
			<%--},--%>
			<%--error: function (data) {--%>
			<%--}--%>
		<%--});--%>


		$('.easyui-tree').tree({
			onClick:function(node){
				if (node.attributes && node.attributes.url) {
					var url = '${ctx}' + node.attributes.url;
//					alert(url);
					addTab({
						url : url,
						title : node.text,
						iconCls : node.iconCls
					});
				}
				$(this).tree(node.state === 'closed' ? 'expand' : 'collapse', node.target);
			}
		});
		
		var urlDestop='${ctx}/admin/destopInfoPage';
		var iframe = '<iframe src="' + urlDestop + '" frameborder="0" style="border:0;width:100%;height:98%;"></iframe>';
		var optss = {
			title : '主页',
			content : iframe,
			closable:false
		};
		index_tabs.tabs('add', optss);
	});
	
	function addTab(params) {
		var iframe = '<iframe src="' + params.url + '" frameborder="0" style="border:0;width:100%;height:98%;"></iframe>';
		var t = $('#index_tabs');
		var opts = {
			title : params.title,
			closable : true,
			iconCls : params.iconCls,
			content : iframe,
			border : false,
			fit : true
		};
		if (t.tabs('exists', opts.title)) {
			t.tabs('select', opts.title);
			var currTab = t.tabs('getSelected');  
			var content = currTab.panel('options').content;
			t.tabs('update',{  
				tab:currTab,  
				options:{  
					content: content
					}    
			});
		} else {
			t.tabs('add', opts);
		}
	}
	
	function logout(){
		$.messager.confirm('提示','确定要退出?',function(r){
			if (r){
				progressLoad();
				$.post( '${ctx}/admin/logout', function(result) {
					if(result.success){
						progressClose();
						window.location.href='${ctx}/admin/index';
					}
				}, 'json');
			}
		});
	}
	

	function editUserPwd() {
		parent.$.modalDialog({
			title : '修改密码',
			width : 300,
			height : 250,
			href : '${ctx}/user/editPwdPage',
			buttons : [ {
				text : '修改',
				handler : function() {
					var f = parent.$.modalDialog.handler.find('#editUserPwdForm');
					f.submit();
				}
			} ]
		});
	}
</script>

<body>
	<!-- 选项卡 -->
	<div id="tab_rightmenu" class="easyui-menu" style="width:150px;">
		<div name="tab_menu-tabclose">关闭</div>
		<div name="tab_menu-tabcloseall">关闭全部标签</div>
		<div name="tab_menu-tabcloseother">关闭其他标签</div>
		<div class="menu-sep"></div>
		<div name="tab_menu-tabcloseright">关闭右侧标签</div>
		<div name="tab_menu-tabcloseleft">关闭左侧标签</div>
	</div>

	<div id="loading" style="position: fixed;top: -50%;left: -50%;width: 200%;height: 200%;background: #fff;z-index: 100;overflow: hidden;">
	<img src="${ctx}/style/images/index/ajax-loader.gif" style="position: absolute;top: 0;left: 0;right: 0;bottom: 0;margin: auto;"/>
	</div>
	<div id="index_layout">
			<!--headerBox-----Begin-->
			<div data-options="region:'north'" class="SR_headerBox">
				<div class="SR_headerLeft">
					<div class="SR_logo"></div>
				</div>
				<div class="SR_headerRight">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td><a class="topLink1" href="#">${sessionInfo.name}</a></td>
							<td><a class="topLink2" href="javascript:void(0)">加入收藏</a></td>
							<td><a class="topLink3" href="javascript:void(0)" onClick="editUserPwd()">修改密码</a></td>
							<td><a class="topLink4" href="javascript:void(0)" onClick="logout()">安全退出</a></td>
						</tr>
					</table>
				</div>
			</div>
			<div class="clear"></div>
			<!--headerBox-----End-->

		<!--layout_west_tree---Begin-->
		<div data-options="region:'west',title:'导航菜单',split:true" style="width:200px;">
			<div class="easyui-accordion"  border="false" id='layout_west_tree'>${sessionInfo.menus}</div>
		</div>
		<!--layout_west_tree---End-->

		<!--index---Begin-->
		<div data-options="region:'center'" style="overflow: hidden;">
			<div id="index_tabs" style="overflow: hidden;">
			  
			</div>
		</div>
		<!--index---End-->

		<div data-options="region:'east',split:true" title="公告栏" style="width: 200px; overflow: hidden;overflow-y:auto;">
			<%--<iframe id="callBar" src="${ctx}/admin/headPage" frameborder="no" border="0" width="400px" height="800px" scrolling="no" allowtransparency="yes"></iframe>--%>
				<div class="bcon">
					<!-- 代码开始 -->
					<div class="list_lh">
						<ul>
							<li>
								<p><a href="#" target="_blank">公告1</a><a href="#" target="_blank" class="btn_lh">查看</a></p>
								<p><a href="#" target="_blank" class="a_blue">OA办公系统开发时间</a></p>
							</li>
							<li>
								<p><a href="#" target="_blank">公告2</a><a href="#" target="_blank" class="btn_lh">查看</a></p>
								<p><a href="#" target="_blank" class="a_blue">系统基础框架搭建完成</a></p>
							</li>
						</ul>
					</div>
					<!-- 代码结束 -->
				</div>
		</div>

		<div data-options="region:'south',border:false" style="height: 16px; overflow: hidden;text-align: center;background-color: #f5fcfe" >
			<span>Copyright ©2015-2015 Larry Lai, All Rights Reserved</span>
		</div>
	</div>
	
	<!--[if lte IE 7]>
	<div id="ie6-warning"><p>您正在使用 低版本浏览器，在本页面可能会导致部分功能无法使用。建议您升级到 <a href="http://www.microsoft.com/china/windows/internet-explorer/" target="_blank">Internet Explorer 8</a> 或以下浏览器：
	<a href="http://www.mozillaonline.com/" target="_blank">Firefox</a> / <a href="http://www.google.com/chrome/?hl=zh-CN" target="_blank">Chrome</a> / <a href="http://www.apple.com.cn/safari/" target="_blank">Safari</a> / <a href="http://www.operachina.com/" target="_blank">Opera</a></p></div>
	<![endif]-->

	<style>
		/*ie6提示*/
		#ie6-warning {
			width: 100%;
			position: absolute;
			top: 0;
			left: 0;
			background: #fae692;
			padding: 5px 0;
			font-size: 12px
		}

		#ie6-warning p {
			width: 960px;
			margin: 0 auto;
		}
	</style>
	<script>
		jQuery(function ($) {
			if (jQuery.browser.msie && ( jQuery.browser.version == "6.0" ) && ( jQuery.browser.version == "7.0" ) && !jQuery.support.style) {
				jQuery('#ie6-warning').css({'top': jQuery(this).scrollTop() + 'px'});
			}
		});

	</script>
</body>
</html>