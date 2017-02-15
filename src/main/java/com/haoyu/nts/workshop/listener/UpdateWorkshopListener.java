package com.haoyu.nts.workshop.listener;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.message.entity.Message;
import com.haoyu.sip.message.service.IMessageService;
import com.haoyu.sip.message.utils.MessageType;
import com.haoyu.wsts.workshop.entity.Workshop;
import com.haoyu.wsts.workshop.entity.WorkshopUser;
import com.haoyu.wsts.workshop.event.UpdateWorkshopEvent;
import com.haoyu.wsts.workshop.service.IWorkshopUserService;
import com.haoyu.wsts.workshop.utils.WorkshopType;
import com.haoyu.wsts.workshop.utils.WorkshopUserRole;

@Component
public class UpdateWorkshopListener implements ApplicationListener<UpdateWorkshopEvent>{
	@Resource
	private IWorkshopUserService workshopUserService;
	@Resource
	private IMessageService messageService;

	@Override
	public void onApplicationEvent(UpdateWorkshopEvent event) {
		Workshop workshop = (Workshop) event.getSource();
		if(WorkshopType.TRAIN.equals(workshop.getType())&&"Y".equals(workshop.getIsTemplate())){
			List<String> workshopIds = Arrays.asList(workshop.getId().split(","));
			if(CollectionUtils.isNotEmpty(workshopIds)){
				Map<String,Object> parameter = Maps.newHashMap();
				parameter.clear();
				parameter.put("workshopIds", workshopIds);
				List<String> roles = Lists.newArrayList();
				roles.add(WorkshopUserRole.MASSTER);
				roles.add(WorkshopUserRole.MEMBER);
				List<WorkshopUser> workshopUsers = workshopUserService.findWorkshopUsers(parameter, null);
				if(CollectionUtils.isNotEmpty(workshopUsers)){
					for(WorkshopUser wu:workshopUsers){
						Message message = new Message();
						message.setType(MessageType.SYSTEM_MESSAGE);
						message.setSender(ThreadContext.getUser());
						message.setReceiver(wu.getUser());
						String workshopTitle = "";
						if(wu.getWorkshop() != null && StringUtils.isNotEmpty(wu.getWorkshop().getTitle())){
							workshopTitle  = wu.getWorkshop().getTitle();
						}
						message.setContent("恭喜您！'"+workshopTitle+"'工作坊被选为示范性工作坊");
						messageService.createMessage(message);
					}
				}
			}
		}
		
	}

}
