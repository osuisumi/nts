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
import com.haoyu.aip.discussion.event.DeleteDiscussionEvent;
import com.haoyu.aip.discussion.service.IDiscussionService;
import com.haoyu.cmts.community.entity.CommunityRelation;
import com.haoyu.cmts.community.service.ICommunityRelationService;
import com.haoyu.cmts.point.utils.PointType;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.point.entity.PointRecord;
import com.haoyu.sip.point.entity.PointStrategy;
import com.haoyu.sip.point.service.IPointRecordService;
import com.haoyu.sip.utils.Collections3;

@Component
public class DeleteDiscussionForPointListener implements ApplicationListener<DeleteDiscussionEvent> {
	
	@Resource
	private IPointRecordService pointRecordService;
	@Resource
	private IDiscussionService discussionService;
	@Resource
	private ICommunityRelationService communityRelationService;

	@Override
	public void onApplicationEvent(DeleteDiscussionEvent event) {
		Discussion discussion = (Discussion) event.getSource();
		discussion = discussionService.get(discussion.getId());
		DiscussionRelation discussionRelation = discussion.getDiscussionRelations().get(0);
		String userId = discussion.getCreator().getId();
		
		Map<String, Object> param = Maps.newHashMap();
		param.put("betweenDate", new Date());
		param.put("userId", userId);
		List<CommunityRelation> communityRelations = communityRelationService.listCommunityRelation(param, null);
		if (Collections3.isNotEmpty(communityRelations)) {
			for (CommunityRelation communityRelation : communityRelations) {
				PointRecord pointRecord = new PointRecord();
				if (discussionRelation.getRelation().getType().equals("discussion")) {
					pointRecord.setPointStrategy(PointStrategy.getMd5IdInstance(PointType.DELETE_DISCUSSION, "cmts"));
				}else if(discussionRelation.getRelation().getType().equals("lesson")){
					pointRecord.setPointStrategy(PointStrategy.getMd5IdInstance(PointType.DELETE_LESSON, "cmts"));
				}
				pointRecord.setUserId(userId);
				pointRecord.setRelationId(communityRelation.getRelation().getId());
				pointRecord.setEntityId(discussion.getId());
				Response response = pointRecordService.deletePointRecord(null, discussion.getCreator().getId(), communityRelation.getRelation().getId(), discussion.getId());
				if (response.isSuccess()) {
					pointRecordService.createPointRecord(pointRecord, false);
				}
			}
		}
	}

}
