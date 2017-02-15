package com.haoyu.nts.tempimport.dao.impl.mybatis;

import org.springframework.stereotype.Repository;

import com.haoyu.nts.tempimport.dao.ITempImportDao;
import com.haoyu.nts.tempimport.entity.TempImport;
import com.haoyu.sip.core.jdbc.MybatisDao;

@Repository
public class TempImportDao extends MybatisDao implements ITempImportDao{

	@Override
	public int createTempImport(TempImport tempImport) {
		return super.insert(tempImport);
	}

	@Override
	public int deleteTempImportByPid(String pid) {
		return super.delete("deleteByPid",pid);
	}


}
