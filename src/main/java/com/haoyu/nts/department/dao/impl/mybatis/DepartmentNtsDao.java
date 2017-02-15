package com.haoyu.nts.department.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.department.dao.IDepartmentNtsDao;
import com.haoyu.nts.department.entity.DepartmentExtend;
import com.haoyu.sip.core.jdbc.MybatisDao;

@Repository
public class DepartmentNtsDao extends MybatisDao implements IDepartmentNtsDao{

	@Override
	public DepartmentExtend selectDepartmentById(String id) {
		return super.selectByPrimaryKey(id);
	}

	@Override
	public List<DepartmentExtend> selectByParameter(Map<String, Object> parameter, PageBounds pageBounds) {
		return super.selectList("selectByParameter", parameter, pageBounds);
	}

	@Override
	public int updateDeparment(DepartmentExtend department) {
		return super.update(department);
	}

	@Override
	public int insertDepartment(DepartmentExtend department) {
		return super.insert(department);
	}

}
