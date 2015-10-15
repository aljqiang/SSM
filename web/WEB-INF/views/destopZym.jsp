<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	$(function() {

		$('#editZymForm').form({
			url : '${pageContext.request.contextPath}/upload/edit',
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
					parent.$.messager.alert('成功', result.msg, 'info');
					parent.$.modalDialog.handler.dialog('close');
					var currTab = parent.index_tabs.tabs('getSelected');  
					var content = currTab.panel('options').content;
					parent.index_tabs.tabs('update',{  
						tab:currTab,  
						options:{  
							content: content
							}    
					});
				} else {
					parent.$.messager.alert('错误', result.msg, 'error');
				}
			}
		});
	});
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
	<div data-options="region:'center',border:false" style="overflow: hidden;padding: 3px;" >
		<form form id="editZymForm" method="post"  >
			<table class="grid">
		    <tr> 
           		<td align="center">座右铭：   
           			 <input id="zym" type="text" name="zym" value="${sessionInfo.zym}" />
           		</td>
           </tr>
			</table>
		</form>
	</div>
</div>
