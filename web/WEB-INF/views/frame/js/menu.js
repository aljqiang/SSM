var expandFirstSubmenu = true;
var p_menuData;
$(document).ready(function(){
	log.debug("menu loading...");
	var _top_urlParam = getUrlParam(top.location);
	var ygbh = _top_urlParam.ygbh;
	
	ajaxJson({
		funcId:['12400101'],
		data:[{cdbh:'-1',sfbkzs:'2',ygbh:ygbh}],
		func:makeMenu
	})
	log.debug("menu loaded...");
});
function makeMenu(resultObj){
	var data = resultObj['12400101'];
	p_menuData = data;
	var firstLvl = [],obj={};
	for(var i=0;i<data.length;i++){
		if(data[i].tyxbs=='1'){
			if(data[i].cdjb.length == '2')
				firstLvl[firstLvl.length] = data[i];
			else{
				var topJB = data[i].cdjb.substring(0,2);
				obj[topJB] = obj[topJB]?obj[topJB]:[];
				obj[topJB][obj[topJB].length] = data[i];
			}
		}
		else if(data[i].tyxbs=='2'){
			top.g_permission[data[i].cdbh] = data[i].cdmc;//权限菜单
		}
	}
	
	var myMenu = new Menu();
	myMenu.init('menu', firstLvl,obj);
	top.hideLoading('菜单');
	myMenu.draw();
	_menu_setMenuHeight();
	if(expandFirstSubmenu)
		$('div[forlevel="1"]:first').show();
}
function _getMenuPermission(id){
	for(var i=0;i<p_menuData.length;i++){
		if(p_menuData[i].cdbh == id)return true;
	}
	return false;
}
function Menu(){
	this.data = null;
	this.fData = null;
	this.id = null;
	this.init = function(id ,fData,subData){
		this.data = subData;
		this.id = id;
		this.fData = fData;
	};
	this.draw = function(){
		var firstLevel = this.fData;
		for (var i = 0; i < firstLevel.length; i++){
			var icon = (firstLevel[i].cdtb == '')? g_iconPath + '01.gif':g_iconPath + firstLevel[i].cdtb;
			var li = $('<li _loaded="false" id="menu' + firstLevel[i].cdbh+'" class="menuItem"><div class="menuIcon"><img src="'
					+ icon + '"/></div><span>' + firstLevel[i].cdmc+'</span></li>');
			li.hover(function(){$(this).addClass('menuItemHover');}, function(){$(this).removeClass('menuItemHover');})
				.click(function(a,b){
						return function(){
							if($(this).attr('_loaded') && $(this).attr('_loaded') == 'false'){
								window.setTimeout(function(){
									b.drawSub(a.cdjb.toString(),a.cdbh);
									_menu_setMenuHeight();
									if ($('#subMenu' + a.cdbh).css('display') != 'block'){
										$('div[forlevel="1"]').hide();
										$('#subMenu' + a.cdbh).show();
										if (a.cdlj != '')
											top.pageTab.loadPage(a.cdlj, a.cdmc);
									} else
										$('div[forlevel="1"]').hide();
								},1);
								$(this).attr('_loaded','true')
							}
							else{
								if ($('#subMenu' + a.cdbh).css('display') != 'block'){
									$('div[forlevel="1"]').hide();
									$('#subMenu' + a.cdbh).show();
									if (a.cdlj != '')
										top.pageTab.loadPage(a.cdlj, a.cdmc);
								} else
									$('div[forlevel="1"]').hide();
								}
						}
					}(firstLevel[i],this));
			$('#' + this.id).append(li).append('<div id="subMenu' + firstLevel[i].cdbh + '" forlevel="'
						+ firstLevel[i].cdjb.length / 2 + '" class="subMenu"><div>');

			if(expandFirstSubmenu && i==0)
				this.drawSub(firstLevel[i].cdjb.toString(),firstLevel[i].cdbh);
		}
	};

	this.drawSub = function(level, id){
		var menuSubTree = new Tree();
		menuSubTree.setParam({
			id:'subMenu'+id,
			treeData:this.data[level],
			itemId:'cdbh',
			lvlField:'cdjb',
			lvlDesc:'cdmc',
			lvlType:2,
			clickFunc:function(o){
				return function(id,mc){
					var data = o.dataAry[id];
					if(data.cdlj)
						top.pageTab.loadPage(data.cdlj,mc);
				}
			}(menuSubTree),
			contextFunc:_showShortCutPop
		});
		menuSubTree.draw();
	}
}
function _showShortCutPop(obj,data){
	if(!data.cdlj)return;
	if($('.shortcutPop').size()>0)
		$('.shortcutPop').remove();
	var openDiv = $('<li class="open">打开</li>')
	var popDiv = $('<li class="shortcut">设为快捷方式</li>');
	var ul = $('<ul class="shortcutPop"></ul>');
	var popTimer;
	ul.append(openDiv).append(popDiv);
	var pos =obj.offset();
	ul.css('left',pos.left+30).css('top',pos.top+8)
		.children('li').hover(function(){$(this).addClass('hover')},function(){$(this).removeClass('hover')});
	ul.bind('mouseout',{div:ul},function(evt){popTimer = setTimeout(function(){evt.data.div.remove()},400)})
		.find('li').bind('mouseover',function(){clearTimeout(popTimer)});
	
	popDiv.bind('click',{div:ul,id:data.cdbh,menuTitle:data.cdmc,page:data.cdlj},_addShortcut);
	openDiv.bind('click',{div:ul,menuId:data.cdbh,menuTitle:data.cdmc,page:data.cdlj},function(evt){top.pageTab.loadPage(evt.data.page,evt.data.menuTitle);evt.data.div.remove();});
		
	$('body').append(ul);
	return false;
}
function _addShortcut(ev){
	ev.data.div.remove();
	
	var ifrms = top.document.getElementsByTagName('iframe');
	for(var i=0;i<ifrms.length;i++){
		if(ifrms[i].getAttribute('tabId') && ifrms[i].getAttribute('tabId') == 'iframeTab0')
			ifrms[i].contentWindow.addNewSC(ev.data);
	}
}
function _menu_generateTree(id){
	$('#subMenuUL' + id).treeview({
		collapsed : true,
		unique : false
	});
}
function _menu_setMenuHeight(){
	$('div[id*="subMenu"]').height($(window).height() - ($('li.menuItem').height()+3)* $('li.menuItem').size());
}
function _menu_showLoading(a){
	var obj = $('#menu'+a.menuId+' span');
	obj.html(a.menuTitle+' <span class="menuHint">(请稍候...)</span>');
}
function _menu_hideLoading(a){
	var obj = $('#menu'+a.menuId+' span');
	obj.text(a.menuTitle);
}