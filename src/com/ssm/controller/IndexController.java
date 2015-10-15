package com.ssm.controller;

import com.ssm.controller.base.BaseController;
import com.ssm.framework.constant.GlobalConstant;
import com.ssm.model.sys.Tuser;
import com.ssm.pageModel.base.Json;
import com.ssm.pageModel.base.SessionInfo;
import com.ssm.service.ResourceServiceI;
import com.ssm.service.UserServiceI;
import com.ssm.utils.MD5Util;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class IndexController extends BaseController {

    private static Logger log= Logger.getLogger(IndexController.class);

    @Autowired
    private UserServiceI userService;

    @Autowired
    private ResourceServiceI resourceService;

    @RequestMapping("/index")
    public String index(HttpServletRequest request) {
        SessionInfo sessionInfo = (SessionInfo) request.getSession().getAttribute(GlobalConstant.SESSION_INFO);
        if ((sessionInfo != null) && (sessionInfo.getId() != null)) {
            return "/index";
        }

        return "/login";
    }

    @ResponseBody
    @RequestMapping(value = "/login", produces = "text/html;charset=UTF-8")
    public Json login(Tuser user, HttpSession session) {
        Json j = new Json();

        Map<String,Object> params=new HashMap<String, Object>();
        params.put("loginname",user.getLoginname());
        params.put("password",MD5Util.md5(user.getPassword()));

        Tuser sysuser = userService.login(params);
        if (sysuser != null) {
            j.setSuccess(true);
            j.setMsg("登陆成功!");

            SessionInfo sessionInfo = new SessionInfo();
            sessionInfo.setId(sysuser.getId());
            sessionInfo.setLoginname(sysuser.getLoginname());
            sessionInfo.setName(sysuser.getName());
            // user.setIp(IpUtil.getIpAddr(getRequest()));
            sessionInfo.setDep(sysuser.getOrganizationName());
            sessionInfo.setZym(sysuser.getZym());
            sessionInfo.setMenus(resourceService.getMenus(user));
            if (sysuser.getUrl() == null) {
                sessionInfo.setPhoto("/style/images/index/noPic.gif");
            } else {
                sessionInfo.setPhoto(sysuser.getUrl().replace("\\", "/"));
            }
            sessionInfo.setResourceList(userService.resourceList(sysuser.getId()));
            sessionInfo.setResourceAllList(userService.resourceAllList());
            session.setAttribute(GlobalConstant.SESSION_INFO, sessionInfo);
        } else {
            j.setMsg("用户名或密码错误!");
        }
        return j;
    }

    @ResponseBody
    @RequestMapping("/logout")
    public Json logout(HttpSession session) {
        Json j = new Json();
        if (session != null) {
            session.invalidate();
        }
        j.setSuccess(true);
        j.setMsg("注销成功!");
        return j;
    }

    @RequestMapping("/headPage")
    public String indexHead(HttpServletRequest request) {
        return "/head1";
    }

    @RequestMapping("/destopPage")
    public String addPage(HttpServletRequest request) {
        return "/destop";
    }

    @RequestMapping("/destopInfoPage")
    public String addInfoPage(HttpServletRequest request) {
        return "/destopInfo";
    }

    @RequestMapping("/destopPageZym")
    public String addPageZym(HttpServletRequest request) {
        return "/destopZym";
    }

}
