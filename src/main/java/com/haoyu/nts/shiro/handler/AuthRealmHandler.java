package com.haoyu.nts.shiro.handler;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.subject.PrincipalCollection;

import com.google.common.collect.Maps;
import com.haoyu.ncts.course.entity.CourseAuthorize;
import com.haoyu.ncts.course.entity.CourseRegister;
import com.haoyu.ncts.course.service.ICourseAuthorizeService;
import com.haoyu.ncts.course.service.ICourseRegisterService;
import com.haoyu.ncts.course.utils.CourseAuthorizeRole;
import com.haoyu.ncts.course.utils.CourseRegisterState;
import com.haoyu.nts.index.dao.INtsIndexDao;
import com.haoyu.nts.index.entity.UserBizAuthorize;
import com.haoyu.nts.utils.RoleCodeConstant;
import com.haoyu.sip.auth.realm.IAuthRealmHandler;
import com.haoyu.wsts.workshop.entity.WorkshopUser;
import com.haoyu.wsts.workshop.service.IWorkshopUserService;
import com.haoyu.wsts.workshop.utils.WorkshopType;
import com.haoyu.wsts.workshop.utils.WorkshopUserRole;
import com.haoyu.wsts.workshop.utils.WorkshopUserState;

public class AuthRealmHandler implements IAuthRealmHandler{
	
	@Resource
	private ICourseRegisterService courseRegisterService;
	@Resource
	private ICourseAuthorizeService courseAuthorizeService;
	@Resource
	private IWorkshopUserService workshopUserService;
	
	@Resource
	private INtsIndexDao ntsIndexDao;
	
	@Override
	public void addAuthorize(SimpleAuthorizationInfo info, PrincipalCollection principals) {
		List<Object> listPrincipals = principals.asList();
		Map<String, String> attributes = (Map<String, String>) listPrincipals.get(1);
		String userId = attributes.get("id");
		
		Map<String, Object> param = Maps.newHashMap();
		param.put("userId", userId);
		List<UserBizAuthorize> ubas = ntsIndexDao.selectUserAuthorize(param);
		if(ubas!=null&&!ubas.isEmpty()){
			for(UserBizAuthorize uba:ubas){
				String role = uba.getRole();
				String type = uba.getType();
				if(type.equals("course")){
					info.addRole(role+"_"+uba.getId());
					if (!info.getRoles().contains(role)) {
						info.addRole(role);
					}
				}else{
					if(WorkshopUserState.PASS.equals(uba.getState())){
						info.addRole(uba.getRole() + "_" + uba.getId());
						if (WorkshopType.TRAIN.equals(uba.getType()) && (WorkshopUserRole.MASSTER.equals(uba.getRole()) || WorkshopUserRole.MEMBER.equals(uba.getRole()))) {
							if (!info.getRoles().contains(RoleCodeConstant.WORKSHOP_MEMBER)) {
								info.addRole(RoleCodeConstant.WORKSHOP_MEMBER);
							}
						}else{
							if (!info.getRoles().contains(RoleCodeConstant.COURSE_STUDY)) {
								info.addRole(RoleCodeConstant.COURSE_STUDY);
							}
						}
					}
				}
			}
		}
		
	}

}
