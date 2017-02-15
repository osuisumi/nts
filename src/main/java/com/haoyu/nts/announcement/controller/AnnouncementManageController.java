package com.haoyu.nts.announcement.controller;

import java.util.Date;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.tip.announcement.entity.Announcement;
import com.haoyu.tip.announcement.service.IAnnouncementService;

@Controller
@RequestMapping("**/manage/announcement")
public class AnnouncementManageController extends AbstractBaseController{
	
	@Resource
	private IAnnouncementService announcementService;
	
	private String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/announcement/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Model model){
		getPageBounds(10, true);
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "list_announcement";
	}
	
	@RequestMapping(value="create", method=RequestMethod.GET)
	public String create(Announcement announcement, Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("announcement", announcement);
		return getLogicalViewNamePrefix() + "edit_announcement";
	}
	
	@RequestMapping(value="{id}/edit", method=RequestMethod.GET)
	public String edit(Announcement announcement, Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("announcement", announcementService.get(announcement.getId()));
		return getLogicalViewNamePrefix() + "edit_announcement";
	}
	
	@RequestMapping(method = RequestMethod.POST)
	@ResponseBody
	public Response create(Announcement announcement) {
		return announcementService.createAnnouncement(announcement);
	}
	
	@RequestMapping(value="{id}", method = RequestMethod.PUT)
	@ResponseBody
	public Response update(Announcement announcement) {
		return announcementService.updateAnnouncement(announcement);
	}
	
	@RequestMapping(value="{id}/view", method=RequestMethod.GET)
	public String view(Announcement announcement, Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("announcement", announcementService.viewAnnouncement(announcement));
		return getLogicalViewNamePrefix() + "view_announcement";
	}
	
	@RequestMapping(value="more", method=RequestMethod.GET)
	public String more(SearchParam searchParam, Model model){
		if (ThreadContext.getUser() != null) {
			searchParam.getParamMap().put("userId", ThreadContext.getUser().getId());
		}
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("announcements", announcementService.list(searchParam, getPageBounds(10, true)));
		return getLogicalViewNamePrefix() + "list_more_announcement";
	}

	@RequestMapping(method=RequestMethod.DELETE)
	@ResponseBody
	public Response delete(Announcement announcement, Model model){
		return announcementService.deleteAnnouncement(announcement);
	}
	
	//直接在页面生成id保存
	@RequestMapping("saveAnnouncement")
	@ResponseBody
	public Response saveResource(Announcement announcement){
		if(("1").equals(announcement.getState())){
			announcement.setPublishTime(new Date());
		}
		String id = request.getParameter("uuid");
		if(StringUtils.isNotEmpty(id)){
			announcement.setId(id);
		}
		return announcementService.createAnnouncement(announcement);
	}
}
