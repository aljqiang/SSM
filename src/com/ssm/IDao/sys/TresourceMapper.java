package com.ssm.IDao.sys;

import com.ssm.model.sys.Tresource;
import com.ssm.model.sys.Tuser;

import java.util.List;
import java.util.Map;

public interface TresourceMapper {
    /** 获取用户菜单资源*/
    List<Tresource> getUserMenu(Map params);

    /** 获取用户资源列表*/
    List<Tresource> getResoureByUser(Map params);

    /** 获取所有的资源列表*/
    List<Tresource> getResourceAll();
}