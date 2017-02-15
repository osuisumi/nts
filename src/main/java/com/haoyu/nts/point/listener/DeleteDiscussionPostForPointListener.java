package com.haoyu.nts.point.listener;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.google.common.collect.Maps;
import com.haoyu.aip.discussion.entity.Discussion;
import com.haoyu.aip.discussion.entity.DiscussionPost;
import com.haoyu.aip.discussion.entity.DiscussionRelation;
import com.haoyu.aip.discussion.event.DeleteDiscussionEvent;
import com.haoyu.aip.discussion.event.DeleteDiscussionPostEvent;
import com.haoyu.aip.discussion.service.IDiscussionPostService;
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
public class DeleteDiscussionPostForPointListener implements ApplicationListener<DeleteDiscussionPostEvent> {
	
	@Resource
	private IPointRecordService pointRecordService;
	@Resource
	private IDiscussionPostService discussionPostService;
	@Resource
	private ICommunityRelationService communityRelationService;

	@Override
	public void onApplicationEvent(DeleteDiscussionPostEvent event) {
		DiscussionPost post = (DiscussionPost) event.getSource();
		post = discussionPostService.get(post.getId());
		String userId = post.getCreator().getId();
		
		Map<String, Object> param = Maps.newHashMap();
		param.put("betweenDate", new Date());
		param.put("userId", userId);
		List<CommunityRelation> communityRelations = communityRelationService.listCommunityRelation(param, null);
		if (Collections3.isNotEmpty(communityRelations)) {
			for (CommunityRelation communityRelation : communityRelations) {
				PointRecord pointRecord = new PointRecord();
				pointRecord.setPointStrategy(PointStrategy.getMd5IdInstance(PointType.DELETE_DISCUSSION_POST, "cmts"));
				pointRecord.setUserId(userId);
				pointRecord.setRelationId(communityRelation.getRelation().getId());
				pointRecord.setEntityId(post.getId());
				pointRecordService.createPointRecord(pointRecord, true);
			}
		}
	}

}
