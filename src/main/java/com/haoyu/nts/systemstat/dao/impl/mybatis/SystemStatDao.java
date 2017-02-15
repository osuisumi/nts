package com.haoyu.nts.systemstat.dao.impl.mybatis;

import org.springframework.stereotype.Repository;

import com.haoyu.nts.systemstat.dao.ISystemStatDao;
import com.haoyu.nts.systemstat.entity.SystemStat;
import com.haoyu.sip.core.jdbc.MybatisDao;

@Repository
public class SystemStatDao extends MybatisDao implements ISystemStatDao {

	@Override
	public SystemStat get() {
		return super.selectOne("select");
	}

}
