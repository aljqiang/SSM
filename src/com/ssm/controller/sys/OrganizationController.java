package com.ssm.controller.sys;

import com.ssm.controller.base.BaseController;
import com.ssm.pageModel.base.Tree;
import com.ssm.service.OrganizationServiceI;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * User: Larry
 * Date: 2015-10-22
 * Time: 14:27
 * Version: 1.0
 */

@Controller
@RequestMapping("/organization")
public class OrganizationController extends BaseController {

    @Autowired
    private OrganizationServiceI organizationServiceI;

    @RequestMapping("/tree")
    @ResponseBody
    public List<Tree> tree(HttpSession session){
        return organizationServiceI.orgTree();
    }
}
