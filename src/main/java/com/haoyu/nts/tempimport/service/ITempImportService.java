package com.haoyu.nts.tempimport.service;

import java.util.List;

import com.haoyu.nts.tempimport.entity.TempImport;
import com.haoyu.sip.core.service.Response;

public interface ITempImportService {
	
	Response createList(List<TempImport> tempImports);
	
	Response deleteByPid(String pid);

}
