package com.haoyu.nts.point.listener;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.google.common.collect.Maps;
import com.haoyu.cmts.community.entity.CommunityRelation;
import com.haoyu.cmts.community.service.ICommunityRelationService;
import com.haoyu.cmts.movement.entity.Movement;
import com.haoyu.cmts.movement.entity.MovementRelation;
import com.haoyu.cmts.movement.event.DeleteMovementEvent;
import com.haoyu.cmts.movement.service.IMovementCmtsService;
import com.haoyu.cmts.point.utils.PointType;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.point.entity.PointRecord;
import com.haoyu.sip.point.entity.PointStrategy;
import com.haoyu.sip.point.service.IPointRecordService;
import com.haoyu.sip.utils.Collections3;

@Component
public class DeleteMovementForPointListener implements ApplicationListener<DeleteMovementEvent>{

	@Resource
	private IPointRecordService pointRecordService;
	@Resource
	private ICommunityRelationService communityRelationService;
	@Resource
	private IMovementCmtsService movementService;
	
	@Override
	public void onApplicationEvent(DeleteMovementEvent event) {
		Movement movement = (Movement) event.getSource();
		MovementRelation movementRelation = movement.getMovementRelations().get(0);
		String userId = movement.getCreator().getId();
		
		Map<String, Object> param = Maps.newHashMap();
		param.put("betweenDate", new Date());
		param.put("userId", userId);
		List<CommunityRelation> communityRelations = communityRelationService.listCommunityRelation(param, null);
		if (Collections3.isNotEmpty(communityRelations)) {
			for (CommunityRelation communityRelation : communityRelations) {
				PointRecord pointRecord = new PointRecord();
				if (movementRelation.getRelation().getType().equals("movement")) {
					pointRecord.setPointStrategy(PointStrategy.getMd5IdInstance(PointType.DELETE_MOVEMENT, "cmts"));
				}
				pointRecord.setUserId(userId);
				pointRecord.setRelationId(communityRelation.getRelation().getId());
				pointRecord.setEntityId(movement.getId());
				Response response = pointRecordService.deletePointRecord(communityRelation.getRelation().getId(), movement.getId());
				if (response.isSuccess()) {
					pointRecordService.createPointRecord(pointRecord, false);
				}
			}
		}
	}

}
