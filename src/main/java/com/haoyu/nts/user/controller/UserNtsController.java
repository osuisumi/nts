package com.haoyu.nts.user.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.nts.user.entity.User;
import com.haoyu.nts.user.service.IUserBizService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;

@Controller
@RequestMapping("**/user")
public class UserNtsController extends AbstractBaseController{
	
	@Resource
	private IUserBizService userBizService;
	
	@RequestMapping("listUserByRealName")
	@ResponseBody
	public Response listUserByRealName(SearchParam searchParam){
	    List<User> userList= userBizService.listUser(searchParam, getPageBounds(10, true));
		Response response = Response.successInstance();
		response.setResponseData(userList);
		return response;
	}
	
	@RequestMapping("entities")
	@ResponseBody
	public List<User> entities(SearchParam searchParam){
		return userBizService.listUser(searchParam, getPageBounds(10, true));
	}
	
	
	@RequestMapping("count")
	@ResponseBody
	public int count(SearchParam searchParam){
		return userBizService.count(searchParam);
	}
	
}
