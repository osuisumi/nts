package com.haoyu.nts.dict.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.dict.entity.DictEntry;
import com.haoyu.dict.service.IDictEntryService;
import com.haoyu.dict.service.IDictTypeService;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("dict/nts")
public class DictNtsController extends AbstractBaseController{

	@Resource
	private IDictTypeService dictTypeService;
	@Resource
	private IDictEntryService dictEntryService;
	
	protected String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/dict/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(DictEntry dictEntry,Model model){
		model.addAttribute("dictEntry",dictEntry);
		model.addAttribute("pageBounds", getPageBounds(10, true));
		return getLogicalViewNamePrefix() + "list_dictEntry";
	}
	
	@RequestMapping(value="create",method=RequestMethod.GET)
	public String create(DictEntry dictEntry, Model model){
		model.addAttribute("dictEntry",dictEntry);
		return getLogicalViewNamePrefix() + "edit_dictEntry";
	}
	
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response save(DictEntry dictEntry){
		return this.dictEntryService.create(dictEntry);
	}
	
	@RequestMapping(value="edit",method=RequestMethod.GET)
	public String edit(DictEntry dictEntry,Model model){
		model.addAttribute("dictEntry",this.dictEntryService.get(dictEntry.getId()));
		return getLogicalViewNamePrefix() + "edit_dictEntry";
	}
	
	@RequestMapping(method=RequestMethod.PUT)
	@ResponseBody
	public Response update(DictEntry dictEntry){
		return this.dictEntryService.update(dictEntry);
	}
	
	@RequestMapping(value="delete",method=RequestMethod.DELETE)
	@ResponseBody
	public Response delete(DictEntry dictEntry){
		return this.dictEntryService.delete(dictEntry);
	}
	
}
