package com.ssm.controller.sys;

import com.ssm.controller.base.BaseController;
import com.ssm.model.sys.Tuser;
import com.ssm.service.UserServiceI;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User: Larry
 * Date: 2015-09-22
 * Time: 10:46
 * Version: 1.0
 */

@Controller
@RequestMapping("/user")
public class UserController extends BaseController {

	private static Logger log =Logger.getLogger(UserController.class);

	@Autowired
	private UserServiceI userService;

	@RequestMapping("/manager")
	public String manager(HttpServletRequest request) {
//		request.setAttribute("usertypeJson", JSON.toJSONString(dictionaryService.combox("usertype")));
//		request.setAttribute("roletypeJson", JSON.toJSONString(dictionaryService.combox("roletype")));
		return "/admin/user";
	}
	
	@RequestMapping("/dataGrid")
	@ResponseBody
	public Map<String, Object> dataGrid(int page,int rows,Tuser user){
		Map<String,Object> params =new HashMap<String,Object>();
		int start = (page-1)*rows;

		params.put("tname","sys_user");
		params.put("start",start);
		params.put("rows",rows);
		params.put("organization_id",user.getOrganizationId());

		List<Tuser> users = userService.getUserInfoAll(params);
		int total = userService.getNumber(params);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", total);
		map.put("rows", users);

//		for(Tuser user :users){
//			log.info("==================测试Tdictionary返回值："+user.getTdictionary().getText());
//			log.info("==================测试Trole返回值："+user.getTrole().getUserrole());
//		}

		return map;
	}
}
