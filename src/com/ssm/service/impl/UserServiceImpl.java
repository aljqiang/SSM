package com.ssm.service.impl;

import com.ssm.IDao.sys.TresourceMapper;
import com.ssm.IDao.sys.TuserMapper;
import com.ssm.model.sys.Tresource;
import com.ssm.model.sys.Tuser;
import com.ssm.service.UserServiceI;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

/**
 * User: Larry
 * Date: 2015-09-22
 * Time: 10:54
 * Version: 1.0
 */

@Service
public class UserServiceImpl implements UserServiceI {

    private static Logger log=Logger.getLogger(UserServiceImpl.class);

    @Resource
    TuserMapper userDao;

    @Resource
    TresourceMapper resourceDao;

    @Override
    public Tuser login(Map params) {
        return userDao.LoginQuery(params);
    }

    @Override
    public List<String> resourceList(Integer id) {
        List<String> resourceList = new ArrayList<String>();
        Map<String, Object> params = new HashMap<String, Object>();

        params.put("id", id);
        List<Tresource> t = resourceDao.getResoureByUser(params);

        for (int i = 0; i < t.size(); i++) {
//            log.info("测试"+i+"："+t.get(i).getName());
            resourceList.add(t.get(i).getUrl());
        }
        return resourceList;
    }

    @Override
    public List<String> resourceAllList() {
        List<String> resourceList = new ArrayList<String>();

        List<Tresource> l = resourceDao.getResourceAll();
        for (int i = 0; i < l.size(); i++) {
            resourceList.add(l.get(i).getUrl());
        }
        return resourceList;
    }

    @Override
    public List<Tuser> getUserInfoAll(int start,int rows){
        return userDao.getUserInfoAll(start, rows);
    }

    @Override
    public int getNumber() {
        return userDao.selectCount();
    }
}
