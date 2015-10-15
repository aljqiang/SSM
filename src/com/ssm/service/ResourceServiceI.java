package com.ssm.service;

import com.ssm.model.sys.Tuser;

/**
 * User: Larry
 * Date: 2015-09-23
 * Time: 9:31
 * Version: 1.0
 */

public interface ResourceServiceI {

    /** 获取用户菜单*/
    String getMenus(Tuser user);
}
