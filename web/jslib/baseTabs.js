/**
 * 选项卡操作
 * User: Larry
 * Date: 2015-08-26
 * Time: 11:29
 * Version: 1.0
 */

var TabsOperate={
    /**
     * 版本号<br>
     * 尾数为奇数则为测试版,尾数为偶数则为稳定版
     */
    version: 0.1
}

/**
 tab关闭事件
 @param	tabId		tab组件Id
 @param	tabMenuId	tab组件右键菜单Id
 @param	type		tab组件右键菜单div中的name属性值
 */
TabsOperate.CloseTab =function (tabId,tabMenuId,type){
    //tab组件对象
    var tabs = $('#' + tabId);
    //tab组件右键菜单对象
    var tab_menu = $('#' + tabMenuId);

    //获取当前tab的标题
    var curTabTitle = tab_menu.data('tabTitle');

    //关闭当前tab
    if(type === 'tab_menu-tabclose'){
        //通过标题关闭tab
        tabs.tabs("close",curTabTitle);
    }

    //关闭全部tab
    else if(type === 'tab_menu-tabcloseall'){
        //获取所有关闭的tab对象
        var closeTabsTitle = TabsOperate.getAllTabObj(tabs);
        //循环删除要关闭的tab
        $.each(closeTabsTitle,function(){
            var title = this;
            tabs.tabs('close',title);
        });
    }

    //关闭其他tab
    else if(type === 'tab_menu-tabcloseother'){
        //获取所有关闭的tab对象
        var closeTabsTitle = TabsOperate.getAllTabObj(tabs);
        //循环删除要关闭的tab
        $.each(closeTabsTitle,function(){
            var title = this;
            if(title != curTabTitle){
                tabs.tabs('close',title);
            }
        });
    }

    //关闭当前左侧tab
    else if(type === 'tab_menu-tabcloseleft'){
        //获取所有关闭的tab对象
        var closeTabsTitle = TabsOperate.getLeftToCurrTabObj(tabs,curTabTitle);
        //循环删除要关闭的tab
        $.each(closeTabsTitle,function(){
            var title = this;
            tabs.tabs('close',title);
        });
    }

    //关闭当前右侧tab
    else if(type === 'tab_menu-tabcloseright'){
        //获取所有关闭的tab对象
        var closeTabsTitle = TabsOperate.getRightToCurrTabObj(tabs,curTabTitle);
        //循环删除要关闭的tab
        $.each(closeTabsTitle,function(){
            var title = this;
            tabs.tabs('close',title);
        });
    }
}

/**
 获取所有关闭的tab对象
 @param	tabs	tab组件
 */
TabsOperate.getAllTabObj=function (tabs){
    //存放所有tab标题
    var closeTabsTitle = [];
    //所有所有tab对象
    var allTabs = tabs.tabs('tabs');
    $.each(allTabs,function(){
        var tab = this;
        var opt = tab.panel('options');
        //获取标题
        var title = opt.title;
        //是否可关闭 ture:会显示一个关闭按钮，点击该按钮将关闭选项卡
        var closable = opt.closable;
        if(closable){
            closeTabsTitle.push(title);
        }
    });
    return closeTabsTitle;
}

/**
 获取左侧第一个到当前的tab
 @param	tabs		tab组件
 @param	curTabTitle	到当前的tab
 */
TabsOperate.getLeftToCurrTabObj=function (tabs,curTabTitle){
    //存放所有tab标题
    var closeTabsTitle = [];
    //所有所有tab对象
    var allTabs = tabs.tabs('tabs');
    for(var i=0;i<allTabs.length;i++){
        var tab = allTabs[i];
        var opt = tab.panel('options');
        //获取标题
        var title = opt.title;
        //是否可关闭 ture:会显示一个关闭按钮，点击该按钮将关闭选项卡
        var closable = opt.closable;
        if(closable){
            //alert('title' + title + '  curTabTitle:' + curTabTitle);
            if(title == curTabTitle){
                return closeTabsTitle;
            }
            closeTabsTitle.push(title);
        }
    }
    return closeTabsTitle;
}

/**
 获取当前到右侧最后一个的tab
 @param	tabs		tab组件
 @param	curTabTitle	到当前的tab
 */
TabsOperate.getRightToCurrTabObj=function (tabs,curTabTitle){
    //存放所有tab标题
    var closeTabsTitle = [];
    //所有所有tab对象
    var allTabs = tabs.tabs('tabs');
    for(var i=(allTabs.length - 1);i >= 0;i--){
        var tab = allTabs[i];
        var opt = tab.panel('options');
        //获取标题
        var title = opt.title;
        //是否可关闭 ture:会显示一个关闭按钮，点击该按钮将关闭选项卡
        var closable = opt.closable;
        if(closable){
            //alert('title' + title + '  curTabTitle:' + curTabTitle);
            if(title == curTabTitle){
                return closeTabsTitle;
            }
            closeTabsTitle.push(title);
        }
    }
    return closeTabsTitle;
}