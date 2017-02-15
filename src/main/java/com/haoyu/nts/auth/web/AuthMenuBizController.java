package com.haoyu.nts.auth.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Maps;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.auth.entity.AuthMenu;
import com.haoyu.sip.auth.service.IAuthMenuService;
import com.haoyu.sip.auth.service.IAuthUserService;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("**/nts/auth_menus")
public class AuthMenuBizController extends AbstractBaseController {
	
	@Resource
	private IAuthMenuService authMenuService;
	@Resource
	private IAuthUserService authUserService;

	protected String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/auth/menu/");
	}
	
	@RequestMapping(value="tree",method = RequestMethod.GET)
	@ResponseBody
	public List<AuthMenu> allMenuTree(String userId){
		Map<String, Object> param = Maps.newHashMap();
		param.put("userId", userId);
		return authMenuService.findMenu(param, true);
	}
	
}
