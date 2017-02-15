package com.haoyu.nts.point.listener;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.google.common.collect.Maps;
import com.haoyu.aip.discussion.entity.Discussion;
import com.haoyu.aip.discussion.entity.DiscussionRelation;
import com.haoyu.aip.discussion.service.IDiscussionService;
import com.haoyu.cmts.community.entity.CommunityRelation;
import com.haoyu.cmts.community.service.ICommunityRelationService;
import com.haoyu.cmts.point.utils.PointType;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.point.entity.PointRecord;
import com.haoyu.sip.point.entity.PointStrategy;
import com.haoyu.sip.point.service.IPointRecordService;
import com.haoyu.sip.point.service.IPointStrategyService;
import com.haoyu.sip.status.entity.Status;
import com.haoyu.sip.status.event.UpdateStatusEvent;
import com.haoyu.sip.status.utils.StatusState;
import com.haoyu.sip.utils.Collections3;

@Component
public class UpdateStatusForPointListener implements ApplicationListener<UpdateStatusEvent> {
	
	@Resource
	private IPointRecordService pointRecordService;
	@Resource
	private IDiscussionService discussionService;
	@Resource
	private ICommunityRelationService communityRelationService;
	@Resource
	private IPointStrategyService pointStrategyService;

	@Override
	public void onApplicationEvent(UpdateStatusEvent event) {
		Status status = (Status) event.getSource();
		if ("discussion".equals(status.getRelation().getType())) {
			Discussion discussion = discussionService.get(status.getRelation().getId());
			DiscussionRelation discussionRelation = discussion.getDiscussionRelations().get(0);
			String userId = discussion.getCreator().getId();
			
			Map<String, Object> param = Maps.newHashMap();
			param.put("betweenDate", new Date());
			param.put("userId", userId);
			List<CommunityRelation> communityRelations = communityRelationService.listCommunityRelation(param, null);
			if (Collections3.isNotEmpty(communityRelations)) {
				for (CommunityRelation communityRelation : communityRelations) {
					PointRecord pointRecord = new PointRecord();
					pointRecord.setUserId(userId);
					pointRecord.setRelationId(communityRelation.getRelation().getId());
					pointRecord.setEntityId(discussion.getId());
					if (StatusState.ESSENCE.equals(status.getState())) {
						pointRecord.setPointStrategy(PointStrategy.getMd5IdInstance(PointType.SET_DISCUSSION_ESSENCE, "cmts"));
						int setPassCount = 0;//pointRecordService.getCount(pointRecord);
						pointRecord.setPointStrategy(PointStrategy.getMd5IdInstance(PointType.CANCEL_DISCUSSION_ESSENCE, "cmts"));
						int setNoPassCount = 0;//pointRecordService.getCount(pointRecord);
						if (status.getDays() != null && status.getDays().intValue() != 0) {
							if (setPassCount <= setNoPassCount) {
								pointRecord.setPointStrategy(PointStrategy.getMd5IdInstance(PointType.SET_DISCUSSION_ESSENCE, "cmts"));
								pointRecordService.createPointRecord(pointRecord, true);
							}
						}else{
							if (setPassCount > setNoPassCount) {
								pointRecord.setPointStrategy(PointStrategy.getMd5IdInstance(PointType.CANCEL_DISCUSSION_ESSENCE, "cmts"));
								pointRecordService.createPointRecord(pointRecord, true);
							}
						}
					}else if(StatusState.REFUSE.equals(status.getState())){
						if (status.getDays() != null && status.getDays().intValue() != 0) {
							Response response = pointRecordService.deletePointRecord(null, discussion.getCreator().getId(), communityRelation.getRelation().getId(), discussion.getId());
							if ("discussion".equals(discussionRelation.getRelation().getType())) {
								pointRecord.setPointStrategy(PointStrategy.getMd5IdInstance(PointType.REFUSE_DISCUSSION, "cmts"));
							}else if("lesson".equals(discussionRelation.getRelation().getType())){
								pointRecord.setPointStrategy(PointStrategy.getMd5IdInstance(PointType.REFUSE_LESSON, "cmts"));
							}
							if (response.isSuccess()) {
								pointRecordService.createPointRecord(pointRecord, true);
							}
						}/*else{
							Response response = pointRecordService.restorePointRecord(null, discussion.getCreator().getId(), communityRelation.getRelation().getId(), discussion.getId());
							if ("discussion".equals(discussionRelation.getRelation().getType())) {
								pointRecord.setPointStrategy(PointStrategy.getMd5IdInstance(PointType.RESTORE_DISCUSSION, "cmts"));
							}else if("lesson".equals(discussionRelation.getRelation().getType())){
								pointRecord.setPointStrategy(PointStrategy.getMd5IdInstance(PointType.RESTORE_LESSON, "cmts"));
							}
							if (response.isSuccess()) {
								pointRecordService.createPointRecord(pointRecord, true);
							}
						}*/
					}
				}
			}
		}
	}

}
