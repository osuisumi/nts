package com.haoyu.nts.resource.service;

import javax.servlet.http.HttpServletResponse;

public interface IResourceNtsService {

	void importResource(String path, HttpServletResponse response);

	void updateFilePath(String path, HttpServletResponse response);

}
