package com.haoyu.nts.point.listener;

import java.math.BigDecimal;

import javax.annotation.Resource;

import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.haoyu.cmts.community.entity.CommunityRelation;
import com.haoyu.cmts.community.entity.CommunityResult;
import com.haoyu.cmts.community.service.ICommunityRelationService;
import com.haoyu.cmts.community.service.ICommunityResultService;
import com.haoyu.cmts.community.utils.CommunityResultState;
import com.haoyu.sip.core.entity.Relation;
import com.haoyu.sip.core.entity.User;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.point.entity.PointRecord;
import com.haoyu.sip.point.event.DeletePointRecordEvent;
import com.haoyu.sip.point.service.IPointRecordService;

@Component
public class DeletePointRecordListener implements ApplicationListener<DeletePointRecordEvent>{
	
	@Resource
	private IPointRecordService pointRecordService;
	@Resource
	private ICommunityResultService communityResultService;
	@Resource
	private ICommunityRelationService communityRelationService;

	@Override
	public void onApplicationEvent(DeletePointRecordEvent event) {
		PointRecord pointRecord = (PointRecord) event.getSource();
		Float sumPoint = pointRecordService.findUserPoint(pointRecord.getUserId(), pointRecord.getRelationId(), "cmts");
		CommunityResult communityResult = new CommunityResult();
		String id = CommunityResult.getId(pointRecord.getRelationId(), pointRecord.getUserId());
		communityResult.setId(id);
		communityResult.setRelation(new Relation(pointRecord.getRelationId()));
		communityResult.setUser(new User(pointRecord.getUserId()));
		communityResult.setScore(BigDecimal.valueOf(sumPoint));
		CommunityRelation communityRelation = communityRelationService.getCommunityRelation(pointRecord.getRelationId());
		if (sumPoint < communityRelation.getScore().floatValue()) {
			communityResult.setState(CommunityResultState.NO_PASS);
		}
		Response response = communityResultService.updateCommunityResult(communityResult);
		if (!response.isSuccess()) {
			communityResultService.createCommunityResult(communityResult);
		}
	}

}
