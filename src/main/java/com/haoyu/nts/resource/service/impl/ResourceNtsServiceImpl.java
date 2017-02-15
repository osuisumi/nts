package com.haoyu.nts.resource.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.stereotype.Service;

import com.google.common.collect.Lists;
import com.haoyu.nts.resource.excel.RecourceExport;
import com.haoyu.nts.resource.excel.ResourceModel;
import com.haoyu.nts.resource.service.IResourceNtsService;
import com.haoyu.sip.excel.ExcelExport;
import com.haoyu.sip.excel.ExcelImport;
import com.haoyu.sip.file.entity.FileInfo;
import com.haoyu.tip.resource.entity.Resources;
import com.haoyu.tip.resource.service.IResourceService;

@Service
public class ResourceNtsServiceImpl implements IResourceNtsService{

	@Resource
	private IResourceService resourceService;
	
	@Override
	public void importResource(String path, HttpServletResponse response) {
		File file = new File(path + "/import.xls");
		List<String> failList = Lists.newArrayList();
		ExcelImport<ResourceModel> ei = new ExcelImport<ResourceModel>(ResourceModel.class);
		Collection<ResourceModel> list = ei.importExcel(file, 0, 1);
		for (String str : ei.getErrorMsg()) {
			failList.add(str);
		}
		List<RecourceExport> dataList = Lists.newArrayList();
		for (ResourceModel rm : list) {
			RecourceExport resourceExport = new RecourceExport();
			int dataRow = rm.getLineNumber();
			String url = rm.getUrl();
			String fileName = rm.getFileName();
			
			File resourceFile = new File(url);
			if (resourceFile.exists()) {
				FileInfo fileInfo = new FileInfo();
				fileInfo.setUrl(url);
				fileInfo.setFileName(fileName);
				fileInfo.setFileSize(file.length());
				
				Resources resource = new Resources();
				resource.setBelong("public");
				resource.setTitle(fileName);
				resource.getFileInfos().add(fileInfo);
				
				resourceService.createResource(resource);
				resourceExport.setMsg("导入成功, url: " + fileInfo.getUrl());
			}else{
				resourceExport.setMsg("导入失败,第" + dataRow + "行,找不到该文件,请确认文件名和目录是否正确");
				failList.add("第" + dataRow + "行,找不到该文件,请确认文件名和目录是否正确");
			}
			dataList.add(resourceExport);
		}
		try {
			ExcelExport<RecourceExport> excelExport = new ExcelExport<RecourceExport>(RecourceExport.class);
			response.setCharacterEncoding("GBK");
			String outName = "导入结果"+DateFormatUtils.format(new Date(), "yyyy-MM-dd");
			outName = new String(outName.getBytes("GBK"),"ISO-8859-1");
			response.setContentType("application/xls;charset=GBK");
			response.setHeader("Content-disposition", "attachment; filename="+ outName + ".xls");
			excelExport.exportExcel(dataList, response.getOutputStream());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

//	private void showAllFiles(File dir) {
//		File[] fs = dir.listFiles();
//		if (fs != null) {
//			for (int i = 0; i < fs.length; i++) {
//				if (fs[i].isDirectory()) {
//					try {
//						showAllFiles(fs[i]);
//					} catch (Exception e) {
//						e.printStackTrace();
//					}
//				}else{
//					File file = fs[i];
//					
//					FileInfo fileInfo = new FileInfo();
//					fileInfo.setUrl(fs[i].getAbsolutePath());
//					fileInfo.setFileName(file.getName());
//					fileInfo.setFileSize(file.length());
//					
//					Resources resource = new Resources();
//					resource.setBelong("public");
//					resource.setTitle(file.getName());
//					resource.getFileInfos().add(fileInfo);
//					
//					resourceService.createResource(resource);
//				}
//			}
//		}
//	}

	@Override
	public void updateFilePath(String path, HttpServletResponse response) {
		File file = new File(path + "/资源列表整理.xlsx");
		List<String> failList = Lists.newArrayList();
		ExcelImport<ResourceModel> ei = new ExcelImport<ResourceModel>(ResourceModel.class);
		Collection<ResourceModel> list = ei.importExcel(file, 0, 1);
		for (String str : ei.getErrorMsg()) {
			failList.add(str);
		}
		int index = 0;
		List<RecourceExport> dataList = Lists.newArrayList();
		for (ResourceModel rm : list) {
			RecourceExport resourceExport = new RecourceExport();
			String url = rm.getUrl();
			String fileName = rm.getFileName();
			
			String fileUrl = path + "/" + url;
			File resourceFile = new File(fileUrl);
			if (resourceFile.exists()) {
				resourceFile.renameTo(new File(path + "/" + index + "." + StringUtils.substringAfterLast(resourceFile.getName(), ".")));
				resourceExport.setUrl(path + "/" + index + "." + StringUtils.substringAfterLast(resourceFile.getName(), "."));
				resourceExport.setFileName(fileName);
				index++;
				dataList.add(resourceExport);
			}
		}
		try {
			ExcelExport<RecourceExport> excelExport = new ExcelExport<RecourceExport>(RecourceExport.class);
			response.setCharacterEncoding("GBK");
			String outName = "import";
			outName = new String(outName.getBytes("GBK"),"ISO-8859-1");
			response.setContentType("application/xls;charset=GBK");
			response.setHeader("Content-disposition", "attachment; filename="+ outName + ".xls");
			excelExport.exportExcel(dataList, response.getOutputStream());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
