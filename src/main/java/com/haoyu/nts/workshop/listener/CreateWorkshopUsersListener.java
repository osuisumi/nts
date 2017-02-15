package com.haoyu.nts.workshop.listener;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.google.common.collect.Maps;
import com.haoyu.sip.excel.utils.StringUtils;
import com.haoyu.sip.message.entity.Message;
import com.haoyu.sip.message.service.IMessageService;
import com.haoyu.sip.message.utils.MessageType;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.wsts.workshop.entity.Workshop;
import com.haoyu.wsts.workshop.event.CreateWorkshopUsersEvent;
import com.haoyu.wsts.workshop.service.IWorkshopService;
import com.haoyu.wsts.workshop.utils.WorkshopUserRole;
@Component
public class CreateWorkshopUsersListener implements ApplicationListener<CreateWorkshopUsersEvent>{
	@Resource
	private IWorkshopService workshopService;
	@Resource
	private IMessageService messageService;

	@Override
	public void onApplicationEvent(CreateWorkshopUsersEvent event) {
		Workshop workshop = (Workshop) event.getSource();
		if(CollectionUtils.isNotEmpty(workshop.getWorkshopUsers())){
			String role = workshop.getWorkshopUsers().get(0).getRole();
			if(StringUtils.isNotEmpty(role)){
				List<String> userIds = Collections3.extractToList(workshop.getWorkshopUsers(), "user.id");
				messageService.sendMessageToUsers(generateMessage(workshop.getId(),role), userIds);
			}
		}
	}
	
	private Message generateMessage(String workshopId,String role){
		Map<String,Object> parameter = Maps.newHashMap();
		parameter.put("workshopId", workshopId);
		parameter.put("getTrainName", "Y");
		Workshop workshop = workshopService.findWorkshopByIdWithStat(parameter);
		if(workshop!=null){
			Message message = new Message();
			String trainName = StringUtils.isEmpty(workshop.getTrainName())?"":"'"+workshop.getTrainName()+"'培训";
			message.setType(MessageType.SYSTEM_MESSAGE);
			if(WorkshopUserRole.MASSTER.equals(role)){
				message.setContent("您被指派为"+trainName+"'"+workshop.getTitle()+"'工作坊的坊主。请帮助学员完成研修");
			}else if(WorkshopUserRole.MEMBER.equals(role)){
				message.setContent("您被指派为"+trainName+"'"+workshop.getTitle()+"'工作坊的助理坊主。请帮助学员完成研修");
			}else if(WorkshopUserRole.STUDENT.equals(role)){
				message.setContent("欢迎您参与"+trainName+"'"+workshop.getTitle()+"'工作坊，请及时完成研修任务。");
			}
			return message;
		}else{
			return null;
		}
	}

}
