var _frameTabScrollTimer;
function FrameTab(){
	this.id = 'tabs';
	this.cls = 'frameTabContainer';
	this.tabNum = 0;
	this.loadPage = function(page, title,forceReload){
		clearInterval(_frameTabScrollTimer);
		page = g_contextPath+page;
		var _frm = $('iframe[tab="' + title + '"]');
		if (_frm.size() > 0){
			var tabId = _frm.attr('tabId');
			this.clickTab(tabId);
			if(forceReload)
				_frm.attr('src',page);
		}
		else this.addTab(page, title);
	};
	this.addTab = function(page, title){
		var id = 'iframeTab' + this.tabNum;
		this.tabNum++;
		var t = new TabItem(page, title, id, this);
		t.draw();
		var wid = 0;
		$('li[id*="iframeTab"]').each(function(){wid += ($(this).width() + 3);});
		$('div#' + this.id + ' ul.tabList').width(wid);
		if (wid > $('#' + this.id).width()){
			if ($('#scrollLeft').size() == 0){
				$('#' + this.id).prepend('<div id="scrollLeft"></div>');
				$('#' + this.id).append('<div id="scrollRight"></div>');
				var tabDiv = document.getElementById(this.id);
				$('#scrollLeft').css('left', tabDiv.offsetLeft).hover(
					function(){
						$(this).addClass('hover');
						top.pageTab.scroll(false);
					},
					function(){
						$(this).removeClass('hover');
						clearInterval(_frameTabScrollTimer)
					});
					
				$('#scrollRight').css('left',tabDiv.offsetLeft + $('#' + this.id).width() - 10)
					.css('top', tabDiv.offsetTop).hover(
						function(){
							$(this).addClass('hover');
							top.pageTab.scroll(true);
						},
						function(){
							$(this).removeClass('hover');
							clearInterval(_frameTabScrollTimer);
						});
			}
			this.scroll(true, wid - $('#mainFrame').width());
		}
	}
	this.delTab = function(id){
		var w = $('#' + id).width() + 2;
		var w2 = $('div#' + this.id + ' ul.tabList').width();
		$('div#' + this.id + ' ul.tabList').width(w2 - w);
		if ($('div#' + this.id + ' ul.tabList').width() <= $('#' + this.id).width()){
			if ($('#scrollLeft').size() > 0){
				$('#scrollLeft').remove();
				$('#scrollRight').remove();
			}
		}

		$('#' + id).remove();
		$('iframe[tabId="' + id + '"]').attr('src','').remove();
		this.clickTab($('#mainFrame').attr('tabId'));
	};
	this.delTabByTitle = function(title){
		var targetFrame = $('iframe[tab="'+title+'"]');
		if(targetFrame.size()==0)return;
		var id = targetFrame.attr('tabId');
		var w = $('#' + id).width() + 2;
		var w2 = $('div#' + this.id + ' ul.tabList').width();
		$('div#' + this.id + ' ul.tabList').width(w2 - w);
		if ($('div#' + this.id + ' ul.tabList').width() <= $('#' + this.id).width()){
			if ($('#scrollLeft').size() > 0){
				$('div').remove('#scrollLeft');
				$('div').remove('#scrollRight');
			}
		}

		$('#' + id).remove();
		$('iframe[tabId="' + id + '"]').attr('src','').remove();
		this.clickTab($('#mainFrame').attr('tabId'));
	};
	this.delAllTab = function(id){
		var that = this;
		$('li[id*="iframeTab"]').not('#iframeTab0').not('#'+id).remove();
		$('iframe[tabId]').not('iframe[tabId="iframeTab0"]').not('iframe[tabId="'+id+'"]').attr('src','').remove();
		var wid = 0;
		$('li[id*="iframeTab"]').each(function(){wid += ($(this).width() + 3);});
		$('div#' + this.id + ' ul.tabList').width(wid);
		if (wid <= $('#' + this.id).width()){
			if ($('#scrollLeft').size() > 0){
				$('#scrollLeft').remove();
				$('#scrollRight').remove();
			}
		}
		this.clickTab($('#mainFrame').attr('tabId'));
	};
	this.getIframeWindow = function(titleStr){
		var targetFrame = $('iframe[tab="'+titleStr+'"]');
		if(targetFrame.size()>0)
			return targetFrame[0].contentWindow;
		else return null;
	};
	this.isOpened = function(titleStr){
		var obj = this.getIframeWindow(titleStr);
		return obj?true:false;
	}
	this.scroll = function(toRight,amt){
		var container = document.getElementById(this.id);
		if(amt){
			_frameTabScrollTimer = setInterval(function(){
				if(container.scrollLeft < amt){
					container.scrollLeft+=20;
					if(container.scrollLeft>=amt)
						clearInterval(_frameTabScrollTimer)
				}
				else if(container.scrollLeft > amt){
					container.scrollLeft-=20;
					if(container.scrollLeft<=amt)
						clearInterval(_frameTabScrollTimer)
				}
			},1)
			return;
		}
		if(toRight)
			_frameTabScrollTimer = setInterval(function(){container.scrollLeft+=10;},1)
		else
			_frameTabScrollTimer = setInterval(function(){container.scrollLeft-=10;},1)
	}
	this.init = function(){
		$('#mainFrame').before('<div id="' + this.id + '" class="' + this.cls + '"><ul class="tabList"></ul></div>');
		$('#' + this.id).width($('#mainFrame').width());
	}
	this.clickTab = function(tabId){
		$('li[id*="iframeTab"]').attr('class','normal').unbind().not($('#'+tabId))
			.hover(function(){$(this).attr('class','hover')},function(){$(this).attr('class','normal')})
			.click(function(){top.pageTab.clickTab($(this).attr('id'))});
		$('#'+tabId).attr('class','select');
		$('iframe[tabId]').css('display', 'none').filter('iframe[tabId="' + tabId + '"]').css('display', '');
	},
	this.maximize = function(id){
		var that =this;
		var restoreDiv = $('<div id="fullScreen" class="fullScreenToolbar"></div>');
		var restoreBtn = $('<div id="restoreMax" title="退出全屏"><img src="'+g_contextPath+'/KJAF/img/maximize_restore.gif"/>退出全屏</div>');
		restoreDiv.append(restoreBtn);
		restoreBtn.bind('click',function(){that.restore(id)});
		var ifrms = $('iframe[tabId="'+id+'"]');
		this.clickTab(id);
		ifrms.css({position:'absolute',left:0,top:21}).width($(window).width()).height($(window).height()-21);
		$("body").append(restoreDiv);
	},
	this.restore = function(id){
		$('#fullScreen').remove();
		var ifrms = $('iframe[tabId]');
		var pos = $('iframe[tabId="iframeTab0"]').offset();
		var a = ( $.browser.msie && $.browser.version == '6.0') ? 4 : 0;
		var aHeight = showAnnouncements?$('#announcements').height():0;
	  ifrms.width($(window).width() - $('#menuFrame').width() - a).height($('#menuFrame').height()-30+aHeight)
	  	.css({position:'static',left:pos.left,top:pos.top});
	}
}
function TabItem(page, title, id, obj){
	this.title = title;
	this.href = page;
	this.id = id;
	this.obj = obj;
}
TabItem.prototype.draw = function(){
	var closeIcon = '';
	if (this.id == 'iframeTab0')
		$('#mainFrame').attr('tab', this.title).attr('tabId', this.id).attr('src', this.href);
	else{
		$('iframe[tabId]').css('display', 'none');
		
		/*
		$('<iframe id="mainFrame" frameborder="0" framespacing="0"></iframe>').attr('src','blank.htm?forward='+this.href)
		.css({float:'left'}).attr('tab', this.title).width($('#mainFrame').width()).height($('#mainFrame').height())
		.attr('tabId', this.id).insertAfter($('#tabs'));
		*/
		var newFrm = $('#mainFrame').clone().attr('src','blank.htm?forward='+this.href);
		newFrm.css('display', '').attr('tab', this.title)
			.attr('tabId', this.id)//.attr('src', this.href)
			.insertAfter($('#tabs'));
		closeIcon = '<div class="tab_closeIcon" closeTab="' + this.id + '"></div>';
	}
	var spanT2Width = this.title.length * 12 + 30;
	$('.tabList').append('<li id="' + this.id + '" style="width:' + (spanT2Width + 16) + 'px"><span class="t1"></span><span class="t2" style="width:' + spanT2Width + 'px"><div>' + this.title + '</div>' + closeIcon + '</span><span class="t3"></span></li>');
	$('#' + this.id).attr('class', 'select');
	if (this.id != 'iframeTab0'){
		$('#'+this.id).bind('dblclick',{obj:this.obj,id:this.id},function(ev){ev.data.obj.delTab(ev.data.id)})
	}
	$('li[id*="iframeTab"]').not($('#' + this.id)).attr('class', 'normal')
			.hover(function(){$(this).attr('class', 'hover');}, function(){$(this).attr('class', 'normal');})
			.click(function(){top.pageTab.clickTab($(this).attr('id'));})
	$('#'+this.id).find('div[closeTab]').click(function(){top.pageTab.delTab($(this).attr('closeTab'));})
		.hover(function(){$(this).addClass('hover')},function(){$(this).removeClass('hover')})
	var timer;
	document.getElementById(this.id).oncontextmenu = function(ev){
		if ($('#contextMenu').size() > 0){
			closeContextMenu();
			clearTimeout(timer);
		}
		$('#tabs').append('<ul id="contextMenu"><li id="closeThis">关闭此标签</li><li id="closeAll">关闭其他标签</li><li id="maximize">全屏</li></ul>');

		var xCord, yCord;
		xCord = (ev) ? ev.clientX : event.clientX;
		yCord = (ev) ? ev.clientY : event.clientY;
		timer = setTimeout('closeContextMenu()', 1000)
		$('#contextMenu').css('left', xCord).css('top', yCord).hover(function(){clearTimeout(timer);}, function(){timer = setTimeout('closeContextMenu()', 1000);});
		$('#contextMenu li').hover(function(){$(this).addClass('hover')}, function(){$(this).removeClass('hover');})
			.filter('#closeThis').click((function(a){return function(){top.pageTab.delTab(a);closeContextMenu();}})(this.id)).end()
			.filter('#closeAll').click((function(a){return function(){top.pageTab.delAllTab(a);closeContextMenu();}})(this.id)).end()
			.filter('#maximize').click((function(a){return function(){top.pageTab.maximize(a);closeContextMenu();}})(this.id));
		if (this.id == 'iframeTab0'){
			$('li#closeThis').unbind().css('color', '#ccc');
			if ($('li[id*=iframeTab]').size() < 2)
				$('li#closeAll').unbind().css('color', '#ccc');
		}
		else if ($('li[id*=iframeTab]').size() == 2)
			$('li#closeAll').unbind().css('color', '#ccc');
		return false;
	}
}
function closeContextMenu(){$('ul').remove('#contextMenu');}