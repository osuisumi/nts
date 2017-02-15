package com.haoyu.nts.department.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.department.entity.DepartmentExtend;

public interface IDepartmentNtsDao {

	DepartmentExtend selectDepartmentById(String id);
	
	List<DepartmentExtend> selectByParameter(Map<String,Object> parameter,PageBounds pageBounds);

	int updateDeparment(DepartmentExtend department);

	int insertDepartment(DepartmentExtend department);
}
