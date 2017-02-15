package com.haoyu.nts.point.listener;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.context.ApplicationListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import com.google.common.collect.Maps;
import com.haoyu.aip.discussion.entity.Discussion;
import com.haoyu.aip.discussion.entity.DiscussionRelation;
import com.haoyu.aip.discussion.event.UpdateDiscussionEvent;
import com.haoyu.aip.discussion.service.IDiscussionService;
import com.haoyu.cmts.community.entity.CommunityRelation;
import com.haoyu.cmts.community.service.ICommunityRelationService;
import com.haoyu.cmts.lesson.utils.LessonState;
import com.haoyu.cmts.point.utils.PointType;
import com.haoyu.sip.point.entity.PointRecord;
import com.haoyu.sip.point.entity.PointStrategy;
import com.haoyu.sip.point.service.IPointRecordService;
import com.haoyu.sip.point.service.IPointStrategyService;
import com.haoyu.sip.utils.Collections3;

@Async
@Component
public class UpdateDiscussionStateForPointListener implements ApplicationListener<UpdateDiscussionEvent> {
	
	@Resource
	private IPointRecordService pointRecordService;
	@Resource
	private IDiscussionService discussionService;
	@Resource
	private ICommunityRelationService communityRelationService;
	@Resource
	private IPointStrategyService pointStrategyService;

	@Override
	public void onApplicationEvent(UpdateDiscussionEvent event) {
		Discussion discussion = (Discussion) event.getSource();
		Discussion dis = discussionService.get(discussion.getId());
		DiscussionRelation discussionRelation = dis.getDiscussionRelations().get(0);
		String userId = dis.getCreator().getId();
		if(discussionRelation.getRelation().getType().equals("lesson")){
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
					
					if (discussion.getState().equals(LessonState.AUDITING)) {
						pointRecord.setPointStrategy(PointStrategy.getMd5IdInstance(PointType.SET_LESSON_AUDITING, "cmts"));
						pointRecordService.createPointRecord(pointRecord, false);
					}else{
						pointRecord.setPointStrategy(PointStrategy.getMd5IdInstance(PointType.SET_LESSON_PASSED, "cmts"));
						int setPassCount = 0;//pointRecordService.getCount(pointRecord);
						pointRecord.setPointStrategy(PointStrategy.getMd5IdInstance(PointType.SET_LESSON_NO_PASS, "cmts"));
						int setNoPassCount = 0;//pointRecordService.getCount(pointRecord);
						if(discussion.getState().equals(LessonState.PASSED)){
							if (setPassCount <= setNoPassCount) {
								pointRecord.setPointStrategy(PointStrategy.getMd5IdInstance(PointType.SET_LESSON_PASSED, "cmts"));
								pointRecordService.createPointRecord(pointRecord, true);
							}
						}else if(discussion.getState().equals(LessonState.NO_PASS)){
							if (setPassCount > setNoPassCount) {
								pointRecord.setPointStrategy(PointStrategy.getMd5IdInstance(PointType.SET_LESSON_NO_PASS, "cmts"));
								pointRecordService.createPointRecord(pointRecord, true);
							}
						}
					}
				}
			}
		}
	}
}
