<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../inc.jsp"></jsp:include>
<meta http-equiv="X-UA-Compatible" content="edge" />
<c:if test="${fn:contains(sessionInfo.resourceList, '/knowldege/edit')}">
	<script type="text/javascript">
		$.canEdit = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/knowldege/delete')}">
	<script type="text/javascript">
		$.canDelete = true;
	</script>
</c:if>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户管理</title>
	<script type="text/javascript">
	
	var dataGrid;
	var organizationTree;	
	$(function() {	
		organizationTree = $('#organizationTree').tree({
			url : '${ctx}/knowledge/tree',
			parentField : 'pid',
			lines : true,
			onClick : function(node) {
				dataGrid.datagrid('load', {
					
				    pid: node.id
				}
				);
			},
		 onContextMenu: function(e, node){  
             e.preventDefault();  
             $('#dictionarytypeTree').tree('select', node.target);  
             $('#mm').menu('show', {  
                 left: e.pageX,  
                 top: e.pageY  
             });  
         }  
		});
	
		dataGrid = $('#dataGrid').datagrid({
			url : '${ctx}/knowledge/dataGrid',
			striped :true,
			rownumbers : true,
			pagination : true,
			singleSelect : true,
			idField : 'id',
			sortName : 'createdatetime',
			sortOrder : 'asc',
			columns : [ [{
				width : '100',
				title : 'id',
				field : 'id',
				sortable : true
			},
			             {
				width : '100',
				title : '名称',
				field : 'name',
				sortable : true
			},
			{
				width : '100',
				title : '内容',
				field : 'message',
				sortable : true
			},
			{
				field : 'action',
				title : '操作',
				
				width : 100,
				formatter : function(value, row, index) {
					var str = '';

							str += $.formatString('<a href="javascript:void(0)" onclick="makerUpload(false);" >上传附件</a>', row.id);

					return str;
				}
			},
			{
				width : '200',
				title : '创建时间',
				field : 'createdatetime',
				sortable : true
			}
			
			] ],
			toolbar : '#toolbar',
			onDblClickRow:function(rowIndex,rowData){
				
				 
				 $('#dlg').dialog({
				
				 });
				 $('#name').text(rowData.name);
				 $('#message').text(rowData.message);
				}
		}
		
		);
		
		
	});
	function addFun() {
		parent.$.modalDialog({
			title : '添加',
			width : 500,
			height : 300,
			href : '${ctx}/knowledge/addPage',
			buttons : [ {
				text : '添加',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#knowledgeAddForm');
					f.submit();
				}
			} ]
		});
	}
	
	function deleteFun(id) {
		if (id == undefined) {//点击右键菜单才会触发这个
			var rows = dataGrid.datagrid('getSelections');
			id = rows[0].id;
		} else {//点击操作里面的删除图标会触发这个
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		parent.$.messager.confirm('询问', '您是否要删除当前用户？', function(b) {
			if (b) {
				var currentUserId = '${sessionInfo.id}';/*当前登录用户的ID*/
				if (currentUserId != id) {
					progressLoad();
					$.post('${ctx}/user/delete', {
						id : id
					}, function(result) {
						if (result.success) {
							parent.$.messager.alert('提示', result.msg, 'info');
							dataGrid.datagrid('reload');
						}
						progressClose();
					}, 'JSON');
				} else {
					parent.$.messager.show({
						title : '提示',
						msg : '不可以删除自己！'
					});
				}
			}
		});
	}
	
	function editFun(id) {
		if (id == undefined) {
			var rows = dataGrid.datagrid('getSelections');
			id = rows[0].id;
		} else {
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		parent.$.modalDialog({
			title : '编辑',
			width : 500,
			height : 300,
			href : '${ctx}/knowledgeEdit/editPage?id=' + id,
			buttons : [ {
				text : '编辑',
				handler : function() {

					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#userEditForm');
					f.submit();
				}
			} ]
		});
	}
	
	function searchFun() {
		dataGrid.datagrid('load', $.serializeObject($('#searchForm')));
	}
	function cleanFun() {
		$('#searchForm input').val('');
		dataGrid.datagrid('load', {});
	}
	
	function GetFrameWindow(frame){
		return frame && typeof(frame)=='object' && frame.tagName == 'IFRAME' && frame.contentWindow;
	}
	 
	function makerUpload(chunk){
	 Uploader(chunk,function(files){
		 if(files && files.length>0){
			 $("#res").text("成功上传："+files.join(","));
		 }
	 });
	}
	function Uploader(chunk,callBack){
		var addWin = $('<div style="overflow: hidden;"/>');
		var upladoer = $('<iframe/>');
		upladoer.attr({'src':'<%=basePath%>/uploader.jsp?chunk='+chunk,width:'100%',height:'100%',frameborder:'0',scrolling:'no'});
		addWin.window({
			title:"上传文件",
			height:350,
			width:550,
			minimizable:false,
			modal:true,
			collapsible:false,
			maximizable:false,
			resizable:false,
			content:upladoer,
			onClose:function(){
				var fw = GetFrameWindow(upladoer[0]);
				var files = fw.files;
				$(this).window('destroy');
				callBack.call(this,files);
			},
			onOpen:function(){
				var target = $(this);
				setTimeout(function(){
					var fw = GetFrameWindow(upladoer[0]);
					fw.target = target;
				},100);
			}
		});
	}
	</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">

	<div data-options="region:'center',border:false,title:'用户列表'" >
		<table id="dataGrid" data-options="fit:true,border:false"></table>
	</div>
	<div data-options="region:'west',border:false,split:true,title:'组织机构'"  style="width:200px;overflow: hidden; ">
		<ul id="organizationTree"  style="width:180px;margin: 10px 10px 10px 10px">
		</ul>
			  <div id="mm" class="easyui-menu" style="width: 120px;">
        <div onclick="append()" iconcls="icon-add">
          		  添加节点</div>
      	  <div onclick="deleteNode()" iconcls="icon-remove">
       	   		  删除节点</div>
        
      	  <div onclick="modifyNode()" iconcls="icon-edit">修改节点</div>
   		 </div>
	</div>
	<div id="toolbar" style="display: none;">
		<c:if test="${fn:contains(sessionInfo.resourceList, '/role/add')}">
			<a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon_add'">添加</a>
		</c:if>
	</div>

	<div id="dlg" title="Basic Dialog" data-options="iconCls:'icon-save'" style="width:400px;height:200px;padding:10px">
        <table>
				<tr>
					<th></th>	
					<th><a id="name"></a></th>
				
				</tr>
				<tr>		
					<th></th>
					<th><a id="message"></a></th>
				</tr>
			</table>
    </div>
	<div id ></div>
	<div id="res"></div>
</body>
</html>