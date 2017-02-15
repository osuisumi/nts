package com.haoyu.nts.utils;

import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.utils.Collections3;

import freemarker.core.Environment;
import freemarker.ext.beans.BeanModel;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateModelException;

public class PageSplitUtils {

	public static PageBounds getPageBounds(Map params, Environment env){
		PageBounds pageBounds = null;
		if (params.containsKey("pageBounds")  && params.get("pageBounds") != null) {
			BeanModel beanModel = (BeanModel) params.get("pageBounds");
			pageBounds = (PageBounds)beanModel.getWrappedObject();
			if (Collections3.isEmpty(pageBounds.getOrders())) {
				String orders = "CREATE_TIME.DESC";
				pageBounds.setOrders(Order.formString(orders));
				try {
					env.setVariable("orders", new DefaultObjectWrapper().wrap(orders));
				} catch (TemplateModelException e) {
					e.printStackTrace();
				}
			}
		}
		return pageBounds;
	}
	
}
