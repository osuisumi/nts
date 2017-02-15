package com.haoyu.nts.auth.web;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Lists;
import com.haoyu.nts.auth.service.IAuthRoleBizService;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.auth.entity.AuthMenu;
import com.haoyu.sip.auth.entity.AuthPermission;
import com.haoyu.sip.auth.entity.AuthRole;
import com.haoyu.sip.auth.entity.AuthUser;
import com.haoyu.sip.auth.service.IAuthMenuService;
import com.haoyu.sip.auth.service.IAuthPermissionService;
import com.haoyu.sip.auth.service.IAuthRoleService;
import com.haoyu.sip.auth.service.IAuthUserService;
import com.haoyu.sip.core.mapper.JsonMapper;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.user.entity.Account;
import com.haoyu.sip.user.service.IAccountService;
import com.haoyu.sip.utils.Collections3;

@Controller
@RequestMapping("**/auth_roles")
public class AuthRoleBizController extends AbstractBaseController {
	
	@Resource
	private IAuthRoleService authRoleService;
	@Resource
	private IAuthUserService authUserService;	
	@Resource
	private IAuthMenuService authMenuService;	
	@Resource
	private IAuthPermissionService authPermissionService;	
	@Resource
	private IAccountService accountService;
	@Resource
	private IAuthRoleBizService authRoleBizService;
	
	protected String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/auth/role/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(AuthRole role,Model model){
		model.addAttribute("role",role);
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("pageBounds", getPageBounds(10, true));
		return getLogicalViewNamePrefix() + "list_role";
	}
	
	@RequestMapping(value="create",method=RequestMethod.GET)
	public String create(AuthRole role, Model model){
		model.addAttribute("role", role);
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "edit_role";
	}
	
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response save(AuthRole role){
		return this.authRoleService.createRole(role);
	}
	
	@RequestMapping(method=RequestMethod.PUT)
	@ResponseBody
	public Response update(AuthRole role){
		return this.authRoleService.updateRole(role);
	}
	
	@RequestMapping(value="/{roleId}/auth_users/{relationId}",method=RequestMethod.GET)
	@ResponseBody
	public List<AuthUser> getAuthUser(@PathVariable String roleId,@PathVariable String relationId){
		return authUserService.findAuthUserByRoleAndRelation(new AuthRole(roleId), relationId);
	}
	
	@RequestMapping(value="/{roleId}/auth_users/{relationId}",method={RequestMethod.PUT,RequestMethod.POST})
	@ResponseBody
	public Response updateAuthRoleUsers(@PathVariable String roleId,@PathVariable String relationId,HttpServletRequest request){
		String[] userIds = request.getParameterValues("userIds");
		return authRoleService.updateAuthRoleUsers(new AuthRole(roleId), Lists.newArrayList(userIds), relationId);
	}
	
	@RequestMapping(value="/{roleId}/auth_users/{relationId}",method=RequestMethod.DELETE)
	@ResponseBody
	public Response removeUsersFromRole(@PathVariable String roleId,@PathVariable String relationId,List<String> userIds){
		return authRoleService.removeUsersFromRole(new AuthRole(roleId), userIds, relationId);
	}
	
	@RequestMapping(value="batch/delete")
	@ResponseBody
	public Response batchDeleteById(@RequestParam("id")String ids){
		return this.authRoleService.batchDeleteByIds(ids);
	}
	@RequestMapping(value="{id}/edit")
	public String edit(AuthRole role,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("role",this.authRoleService.findRoleById(role.getId()));
		return getLogicalViewNamePrefix() + "edit_role";
	}
	
	@RequestMapping(value="list",method=RequestMethod.GET)
	public String list(AuthRole role,PageBounds pageBounds,Model model){
		model.addAttribute("roles",authRoleService.list(role, getPageBounds(10, true)));
		model.addAttribute("role",role);
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "list_role";
	}
	
	//返回授权页面,带上已有menu的id
	@RequestMapping(value="{id}/editRoleMenu")
	public String editRoleMenu(AuthRole role,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("authRole", role);
		List<AuthRole> roles = new ArrayList<AuthRole>();
		roles.add(role);
		List<AuthMenu> myMenus = this.authMenuService.findMenuByRoles(roles, false);
		List<AuthMenu> allMenus = this.authMenuService.findMenu(new AuthMenu(), true);
		List<AuthMenu> allLeafs = new ArrayList<AuthMenu>();
//		String menuIds = "";
		List<String> menuIds = new ArrayList<String>();
		//List<String> menuIds = new ArrayList<String>();
		if(allMenus!=null && allMenus.size()>0){
			for(AuthMenu m:allMenus){
				List<AuthMenu> result = new ArrayList<AuthMenu>();
				result = m.getLeaf(result);
				allLeafs.addAll(result);
			}
		}
		for(AuthMenu leaf:allLeafs){
			if(myMenus!=null && myMenus.size()>0){
				if(myMenus.contains(leaf)){
//					menuIds = menuIds + ","+leaf.getId();
					menuIds.add(leaf.getId());
				}
			}
		}
//		model.addAttribute("menuIds", menuIds);
		model.addAttribute("menuIds", new JsonMapper().toJson(menuIds));
		return getLogicalViewNamePrefix() + "edit_role_menu";
	}
	
	//返回permission授权页面，带上已有的permissionid
	@RequestMapping(value="{id}/editRolePermission")
	public String editRolePermission(AuthRole role,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("authRole", role);
		List<AuthRole> roles = new ArrayList<AuthRole>();
		roles.add(role);
		List<AuthPermission> permissions = this.authPermissionService.findPermissionByRoles(roles);
//		String permissionIds = "";
		List<String> permissionIds = new ArrayList<String>();
		if(permissions!=null && permissions.size()>0){
			for(AuthPermission p:permissions){
//				permissionIds = permissionIds + ","+p.getId();
				permissionIds.add(p.getId());
			}
		}
		model.addAttribute("permissionIds", new JsonMapper().toJson(permissionIds));
		return getLogicalViewNamePrefix() + "edit_role_permission";
	}
	
	@RequestMapping(value="grant/menu",method = RequestMethod.PUT)
	@ResponseBody
	public Response grantMenuToRole(AuthRole role){
		return authRoleService.grantMenuToRole(role);
	}
	
	@RequestMapping(value="grant/permission",method = RequestMethod.PUT)
	@ResponseBody
	public Response grantPermissionToRole(AuthRole role){
		return authRoleService.grantPermissionToRole(role);
	}
	
	@RequestMapping(value="authAccountRoleAuthorize",method=RequestMethod.POST)
	@ResponseBody
	public Response saveAuthAccountRoleAuthorize(AuthRole role,String userIds,String relationId){
		this.authRoleService.removeUsersFromRole(null, Arrays.asList(userIds.split(",")), relationId);
		if (StringUtils.isEmpty(role.getId())) {
			return Response.successInstance();
		}
		return this.authRoleService.addUsersToRole(role,Arrays.asList(userIds.split(",")), relationId);	
	}
	
	@RequestMapping(value="authAccountGroupRoleAuthorize",method=RequestMethod.POST)
	@ResponseBody
	public Response authAccountGroupRoleAuthorize(AuthRole role,Account account,String relationId){
		List<String> userIds = Collections3.extractToList(accountService.list(account, null), "user.id");
		List<String> roleIds = Collections3.extractToList(authRoleService.list(null, null), "id");
		roleIds.remove(role.getId());
		if(Collections3.isNotEmpty(userIds)){
			authRoleBizService.deleteUserRole(roleIds, userIds, relationId);
			return this.authRoleService.addUsersToRole(role,userIds, relationId);	
		}
		return Response.successInstance();
	}
	
}
