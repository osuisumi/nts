package com.haoyu.nts.department.service;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.department.entity.DepartmentExtend;
import com.haoyu.sip.core.service.Response;

public interface IDepartmentNtsService {

	Response createDepartment(DepartmentExtend department);

	DepartmentExtend findDepartmentById(String id);

	Response updateDepartment(DepartmentExtend department);
	
	List<DepartmentExtend> findByParameter(Map<String,Object> parameter,PageBounds pageBounds);
}
