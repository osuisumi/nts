package com.haoyu.nts.workshop.service.impl;

import java.io.OutputStream;
import java.math.BigDecimal;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.nts.train.entity.TrainRegisterStat;
import com.haoyu.nts.workshop.excel.WorkshopWorkerExpert;
import com.haoyu.nts.workshop.service.IWorkshopBizService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.excel.ExcelExport;
import com.haoyu.sip.message.entity.Message;
import com.haoyu.sip.message.service.IMessageService;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.wsts.workshop.entity.Workshop;
import com.haoyu.wsts.workshop.entity.WorkshopUser;
import com.haoyu.wsts.workshop.service.IWorkshopService;
import com.haoyu.wsts.workshop.service.IWorkshopUserService;
import com.haoyu.wsts.workshop.service.impl.WorkshopUserService;
import com.haoyu.wsts.workshop.utils.WorkshopState;
import com.haoyu.wsts.workshop.utils.WorkshopUserRole;

@Service
public class WorkshopBizService implements IWorkshopBizService{
	@Resource
	private IWorkshopService workshopService;
	
	@Resource
	private IMessageService messageService;
	@Resource
	private IWorkshopUserService workshopUserService;

	@Override
	public Response createExtendWorkshops(String workshopId, String extendNames, int extendNum,String relationId) {
		List<String> extendNameList = Arrays.asList(extendNames.split(","));
		if(CollectionUtils.isEmpty(extendNameList)){
			return Response.failInstance().responseMsg("extendNames is null");
		}
		if(extendNum != extendNameList.size()){
			return Response.failInstance().responseMsg("extendNames != extendNum");
		}
		for(int i = 0;i<extendNameList.size();i++){
			if(i == 0){
				Workshop workshop = new Workshop();
				workshop.setId(workshopId);
				workshop.setTitle(extendNameList.get(i));
				workshopService.updateWorkshop(workshop);
			}else{
				Workshop workshop = new Workshop();
				workshop.setId(workshopId);
				workshop.setTitle(extendNameList.get(i));
				workshopService.createExtendWorkshop(workshop, relationId, null);
			}
		}
		return Response.successInstance();
	}

	@Override
	public Response audit(String state, String msg, List<Workshop> workshops) {
		if(CollectionUtils.isEmpty(workshops)){
			return Response.failInstance();
		}
		String ids = "";
		for(Workshop w:workshops){
			if(ids.equals("")){
				ids = w.getId();
			}else{
				ids = ids + "," + w.getId();
			}
		}
		Workshop updateWorkshop = new Workshop();
		updateWorkshop.setId(ids);
		updateWorkshop.setState(state);
		Response response = workshopService.updateWorkshop(updateWorkshop);
		if(response.isSuccess()){
			for(Workshop w:workshops){
				if(CollectionUtils.isNotEmpty(w.getMasters())){
					List<String> masterIds = Lists.newArrayList();
					for(WorkshopUser wu:w.getMasters()){
						if(StringUtils.isNotEmpty(wu.getId())){
							masterIds.add(wu.getId());
						}
					}
					if(CollectionUtils.isNotEmpty(masterIds)){
						messageService.sendMessageToUsers(createMessage(w,state,msg), masterIds);
					}
				}
			}
		}
		return response;
	}
	
	private Message createMessage(Workshop w,String state,String msg){
		Message message = new Message();
		message.setSender(ThreadContext.getUser());
		message.setTitle("工作坊审核结果");
		String result = WorkshopState.PUBLISHED.equals(state)?"通过":"不通过";
		message.setContent("工作坊'"+w.getTitle()+"'的审核结果为："+result+",审核意见："+msg+"");
		return message;
	}

	//<@workshopUsersDirective realName=(realName[0])! title=(title[0])! relationIdInTrain='Y'  withActionInfo='Y' roleNotEqual='student'   limit=10 page=(pageBounds.page)!1 orders=orders!'CREATE_TIME.DESC'>
	@Override
	public void exportWorkerStat(Map<String, Object> parameter, PageBounds pageBounds, OutputStream outputStream) {
		if(pageBounds != null){
			pageBounds.setContainsTotalCount(false);
			pageBounds.setOrders(Order.formString("CREATE_TIME.DESC"));
		}
		if(parameter!=null){
			parameter.put("relationIdInTrain", "Y");
			parameter.put("roleNotEqual", "student");
		}
		List<WorkshopUser> workshopUsers = workshopUserService.findWorkshopUsersWithActionInfo(parameter, pageBounds);
		if(CollectionUtils.isNotEmpty(workshopUsers)){
			List<String> workshopIds = Collections3.extractToList(workshopUsers, "workshopId");
			Set<String> s = new HashSet<String>();
			s.addAll(workshopIds);
			workshopIds.clear();
			workshopIds.addAll(s);
			
			List<Workshop> workshops = Lists.newArrayList();
			
			List<List<String>> workshopIdsArray = split(workshopIds);
			Map<String,Object> wParam = Maps.newHashMap();
			wParam.put("getStudentNum", "Y");
			wParam.put("getQualifiedStudentNum", "Y");
			wParam.put("getTrainName", "Y");
			for(List<String> wids:workshopIdsArray){
				wParam.put("workshopIds", wids);
				workshops.addAll(workshopService.findWorkshopsWithStat(wParam, null));
			}
			
			Map<String,Workshop> workshopMap = Collections3.extractToMap(workshops, "id", null);
			
			List<WorkshopWorkerExpert> expertList = Lists.newArrayList();
			if(CollectionUtils.isNotEmpty(workshopUsers)){
				for(WorkshopUser wu:workshopUsers){
					WorkshopWorkerExpert wwe = new WorkshopWorkerExpert();
					wwe.setRealName(wu.getUser().getRealName());
					wwe.setRole(WorkshopUserRole.MASSTER.equals(wu.getRole())?"坊主":"助理坊主");
					wwe.setTrainName(workshopMap.get(wu.getWorkshopId()).getTrainName());
					wwe.setWorkshopTitle(wu.getWorkshop().getTitle());
					wwe.setStudentNum(String.valueOf(workshopMap.get(wu.getWorkshopId()).getWorkshopRelation().getStudentNum()));
					if(workshopMap.get(wu.getWorkshopId()).getWorkshopRelation().getStudentNum()<=0){
						wwe.setPassPercent("0%");
					}else{
						BigDecimal qualifiedNum = new BigDecimal(workshopMap.get(wu.getWorkshopId()).getWorkshopRelation().getQualifiedStudentNum()) ;
						BigDecimal studentNum = new BigDecimal(workshopMap.get(wu.getWorkshopId()).getWorkshopRelation().getStudentNum());
						BigDecimal result = qualifiedNum.divide(studentNum, 2, BigDecimal.ROUND_HALF_UP);
						wwe.setPassPercent(result.multiply(new BigDecimal(100)) + "%");
					}
					
					wwe.setCreateActNum(String.valueOf(wu.getActionInfo().getActivityNum()));
					wwe.setFaqAnswerNum(String.valueOf(wu.getActionInfo().getFaqAnswerNum()));
					wwe.setUploadResourceNum(String.valueOf(wu.getActionInfo().getUploadResourceNum()));
					wwe.setCommentsNum(String.valueOf(wu.getActionInfo().getCommentsNum()));
					expertList.add(wwe);
				}
			}
			ExcelExport<WorkshopWorkerExpert> ee = new ExcelExport<WorkshopWorkerExpert>(WorkshopWorkerExpert.class);
			ee.exportExcel(expertList, outputStream);
		}
	}
	
	private static List<List<String>> split(List<String> input){
		List<List<String>> result = Lists.newArrayList();
		if(input.size()<=999){
			result.add(input);
			return result;
		}else{
			while(CollectionUtils.isNotEmpty(input)){
				if(input.size()>999){
					List<String> sub = Lists.newArrayList(input.subList(0, 998));
					result.add(sub);
					input = input.subList(998,input.size());
				}else{
					result.add(Lists.newArrayList(input));
					input.clear();
				}
			}
		}
		return result;
	}
	
}
