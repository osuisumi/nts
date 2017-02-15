//package com.haoyu.nts.workshop.listener;
//
//import java.util.List;
//
//import javax.annotation.Resource;
//
//import org.springframework.context.ApplicationListener;
//import org.springframework.stereotype.Component;
//
//import com.haoyu.sip.auth.realm.CacheCleaner;
//import com.haoyu.tip.workshop.event.UpdateWorkshopAuthorizeEvent;
//
//@Component
//public class UpdateWorkshopAuthorizeListener implements ApplicationListener<UpdateWorkshopAuthorizeEvent>{
//
//	@Resource
//	private CacheCleaner authRealm;
//	
//	@Override
//	public void onApplicationEvent(UpdateWorkshopAuthorizeEvent event) {
//		List<String> ids = (List<String>) event.getSource();
//		authRealm.clearUserCacheByIds(ids);
//	}
//
//}
