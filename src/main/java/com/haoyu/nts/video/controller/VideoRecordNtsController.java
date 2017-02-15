package com.haoyu.nts.video.controller;

import java.rmi.RemoteException;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.tempuri.AppVideo;
import org.tempuri.MessageResultOfVideoResourcePath;
import org.tempuri.VideoResourcePath;
import org.tempuri.WebServiceSoapProxy;

import com.haoyu.aip.video.service.IVideoRecordService;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("**/video/record/nts")
public class VideoRecordNtsController extends AbstractBaseController{
	
	@Resource
	private IVideoRecordService videoRecordService;
	@Autowired
	private WebServiceSoapProxy videoProxy;
	
	private String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/video/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Model model){
		this.getPageBounds(10, true);
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "list_video_record";
	}
	
	@RequestMapping(value="{guid}/entity", method=RequestMethod.GET)
	@ResponseBody
	public VideoResourcePath entity(AppVideo appVideo, Model model){
		MessageResultOfVideoResourcePath messageResultOfVideoResourcePath = null;
		try {
			messageResultOfVideoResourcePath = videoProxy.videoResourcePath(appVideo.getGuid());
		} catch (RemoteException e) {
			e.printStackTrace();
		}
		return messageResultOfVideoResourcePath.getData();
	}

}
