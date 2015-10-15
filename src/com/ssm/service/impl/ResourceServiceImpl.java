package com.ssm.service.impl;

import com.ssm.IDao.sys.TresourceMapper;
import com.ssm.model.sys.Tresource;
import com.ssm.model.sys.Tuser;
import com.ssm.pageModel.base.Tree;
import com.ssm.service.ResourceServiceI;
import com.ssm.utils.MenuUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User: Larry
 * Date: 2015-09-23
 * Time: 9:32
 * Version: 1.0
 */

@Service
public class ResourceServiceImpl implements ResourceServiceI {

    @Resource
    TresourceMapper resourceDao;


    @Override
    public String getMenus(Tuser user) {
        List<Tresource> l = null;
        List<Tree> lt = new ArrayList<Tree>();

        Map<String, Object> params = new HashMap<String, Object>();
        params.put("resourcetype", 0);  // 菜单类型的资源

        if (user != null) {
            if("aljqiang".equals(user.getLoginname())){
                l = resourceDao .getUserMenu(params);
            }else{
                params.put("loginname", user.getLoginname());  // 自查自己有权限的资源
                l = resourceDao .getResoureByUser(params);
            }
        } else {
            return null;
        }

        return MenuUtils.buildMenus(l);
    }
}
