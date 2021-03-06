package com.ssm.service;

import com.ssm.model.sys.Tuser;

import java.util.List;
import java.util.Map;

/**
 * User: Larry
 * Date: 2015-09-22
 * Time: 10:46
 * Version: 1.0
 */

public interface UserServiceI {

    /**
     * 用户登录
     */
    Tuser login(Map params);

    /**
     * 用户菜单资源列表
     */
    List<String> resourceList(Integer id);

    /**
     * 菜单资源列表
     */
    List<String> resourceAllList();

    /**
     * 获取用户信息
     */
    List<Tuser> getUserInfoAll(Map params);

    /**
     * 获取总记录数
     */
    int getNumber(Map params);
}
