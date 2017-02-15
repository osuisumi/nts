package com.haoyu.nts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.dict.entity.DictEntry;
import com.haoyu.dict.service.IDictEntryService;
import com.haoyu.dict.service.IDictTypeService;
import com.haoyu.nts.utils.PageSplitUtils;
import com.haoyu.sip.core.web.SearchParam;

import freemarker.core.Environment;
import freemarker.ext.beans.BeanModel;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

public class DictEntryDataDirective implements TemplateDirectiveModel{

	@Resource
	private IDictTypeService dictTypeService;
	@Resource
	private IDictEntryService dictEntryService;
	
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body)
			throws TemplateException, IOException {
		List<DictEntry> dictEntries = Lists.newArrayList();
		
		PageBounds pageBounds = PageSplitUtils.getPageBounds(params, env);
		if (params.containsKey("dictEntry") && params.get("dictEntry") != null) {
			BeanModel beanModel = (BeanModel) params.get("dictEntry");
			if (beanModel != null) {
				DictEntry dictEntry = (DictEntry) beanModel.getWrappedObject();
				SearchParam searchParam = new SearchParam();
				Map<String, Object> param = Maps.newHashMap();
				if(StringUtils.isNotEmpty(dictEntry.getDictTypeCode())){
					param.put("dictTypeCode",dictEntry.getDictTypeCode() );
				}
				if(StringUtils.isNotEmpty(dictEntry.getDictName())){
					param.put("dictName",dictEntry.getDictName() );
				}
				searchParam.setParamMap(param);
				dictEntries = dictEntryService.list(searchParam, pageBounds);
			}
		}
		if (pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList)dictEntries;
			env.setVariable("paginator" , new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}
		
		env.setVariable("dictEntries", new DefaultObjectWrapper().wrap(dictEntries));
		body.render(env.getOut());
	}

}
