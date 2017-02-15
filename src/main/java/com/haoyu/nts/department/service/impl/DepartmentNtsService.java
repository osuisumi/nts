package com.haoyu.nts.department.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.department.dao.IDepartmentNtsDao;
import com.haoyu.nts.department.entity.DepartmentExtend;
import com.haoyu.nts.department.service.IDepartmentNtsService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.user.dao.IDeparmentDao;
import com.haoyu.sip.utils.Identities;

@Service
public class DepartmentNtsService implements IDepartmentNtsService{

	@Resource
	private IDeparmentDao deparmentDao;
	@Resource
	private IDepartmentNtsDao adminDeparmentNtsDao;
	
	@Override
	public Response createDepartment(DepartmentExtend department) {
		Response response = Response.failInstance();
		if (department == null) {
			return Response.failInstance();
		}
		if (StringUtils.isEmpty(department.getId())) {
			department.setId(Identities.uuid2());
		}
		department.setDefaultValue();
		int count = adminDeparmentNtsDao.insertDepartment(department);
		if (count > 0) {
			response = Response.successInstance();
		}
		return response;
	}

	@Override
	public DepartmentExtend findDepartmentById(String id) {
		return adminDeparmentNtsDao.selectDepartmentById(id);
	}

	@Override
	public Response updateDepartment(DepartmentExtend department) {
		Response response = Response.failInstance();
		if (department == null || StringUtils.isEmpty(department.getId())) {
			return Response.failInstance();
		}
		department.setUpdateValue();
		int count = adminDeparmentNtsDao.updateDeparment(department);
		if (count > 0) {
			response =Response.successInstance();
		}
		return response;
	}

	@Override
	public List<DepartmentExtend> findByParameter(Map<String, Object> parameter, PageBounds pageBounds) {
		return adminDeparmentNtsDao.selectByParameter(parameter, pageBounds);
	}
}
