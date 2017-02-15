package com.haoyu.nts.tempimport.dao;

import com.haoyu.nts.tempimport.entity.TempImport;

public interface ITempImportDao {
	
	int createTempImport(TempImport TempImport);

	int deleteTempImportByPid(String pid);

}
