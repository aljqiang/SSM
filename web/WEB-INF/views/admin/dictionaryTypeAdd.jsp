<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">
	

	$(function() {
		

		$('#pid').combotree({
			url : '${ctx}/dictionarytype/tree',
			parentField : 'pid',
			lines : true,
			required:true,
			panelHeight : 'auto'
		});
		$('#dictionaryTypeAddForm').form({
			url : '${ctx}/dictionarytype/add',
			onSubmit : function() {
				progressLoad();
				var isValid = $(this).form('validate');
				if (!isValid) {
					progressClose();
				}
				return isValid;
			},
			success : function(result) {
				progressClose();
				result = $.parseJSON(result);
				if (result.success) {
					parent.$.modalDialog.openner_tree.tree('reload');//
					parent.$.modalDialog.handler.dialog('close');
				}else{
					parent.$.messager.alert('提示', result.msg, 'warning');
				}
			}
		});
		
	});
</script>
<div style="padding: 3px;">
	<form id="dictionaryTypeAddForm" method="post">
		<table class="grid">
			<tr>
				<td>编码</td>
				<td><input name="code" type="text" placeholder="请输入字典编码" class="easyui-validatebox" data-options="required:true" style="width: 140px; height: 29px;" ></td>
				<td>名称</td>
				<td><input name="name" type="text" placeholder="请输入字典名称" class="easyui-validatebox" data-options="required:true" style="width: 140px; height: 29px;" ></td>
			</tr>
			<tr>
				<td>所属类别</td>
				<td><select id="pid" name="pid" style="width: 140px; height: 29px;" ></select></td>
				<td>排序</td>
				<td><input name="seq" value="0"  class="easyui-numberspinner" style="width: 140px; height: 29px;" required="required" data-options="editable:false"></td>
			</tr>
			<tr>
				<td>说明</td>
				<td><input name="description" type="text" placeholder="请输入字典说明" class="easyui-validatebox" data-options="required:true" style="width: 140px; height: 29px;" ></td>
			</tr>
		</table>
	</form>
</div>