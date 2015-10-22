package com.ssm.service.impl;

import com.ssm.IDao.sys.TorganizationMapper;
import com.ssm.model.sys.Torganization;
import com.ssm.pageModel.base.Tree;
import com.ssm.service.OrganizationServiceI;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User: Larry
 * Date: 2015-10-22
 * Time: 14:32
 * Version: 1.0
 */

@Service
public class OrganizationServiceImpl implements OrganizationServiceI {

    private static Logger log = Logger.getLogger(OrganizationServiceImpl.class);

    @Resource
    TorganizationMapper OrganizationDao;

    @Override
    public List<Tree> orgTree() {
        List<Torganization> orgList = null;
        List<Tree> tList = new ArrayList<Tree>();

        Map<String, Object> params = new HashMap<String, Object>();

        orgList = OrganizationDao.getOrgTree(params);

        if (orgList != null && orgList.size() > 0) {
            for (Torganization r : orgList) {
                Tree tree = new Tree();
                tree.setId(r.getId().toString());
                if(r.getPid() != null){
                    tree.setPid(r.getPid().toString());
                }

//                log.info("id=" + tree.getId() + ",pid=" + tree.getPid());

                tree.setText(r.getName());
                tree.setIconCls(r.getIcon());

                tList.add(tree);
            }
        }

        return tList;
    }
}
