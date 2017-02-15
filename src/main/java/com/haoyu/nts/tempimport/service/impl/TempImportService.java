package com.haoyu.nts.tempimport.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.haoyu.nts.tempimport.dao.ITempImportDao;
import com.haoyu.nts.tempimport.entity.TempImport;
import com.haoyu.nts.tempimport.service.ITempImportService;
import com.haoyu.sip.core.service.Response;

@Service
public class TempImportService implements ITempImportService {

	@Resource
	private ITempImportDao tempImportDao;

	@Resource
	private DataSourceTransactionManager transactionManager;


	@Override
	public Response createList(List<TempImport> tempImports) {
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW); // 事物隔离级别，开启新事务，与A类和B类不使用同一个事务。
		TransactionStatus status = transactionManager.getTransaction(def); // 获得事务状态
		try {
			for (TempImport ti : tempImports) {
				 tempImportDao.createTempImport(ti);
			}
			transactionManager.commit(status);
			return Response.successInstance();
		} catch (Exception e) {
			// TODO: handle exception
			transactionManager.rollback(status);
			return Response.failInstance();
		}
	}


	@Override
	public Response deleteByPid(String pid) {
		return tempImportDao.deleteTempImportByPid(pid)>0?Response.successInstance():Response.failInstance();
	}

}
