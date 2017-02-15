package com.haoyu.nts.task;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.google.common.collect.Maps;
import com.haoyu.nts.train.service.ITrainRegisterStatService;
import com.haoyu.tip.train.entity.Train;
import com.haoyu.tip.train.entity.TrainRegister;
import com.haoyu.tip.train.service.ITrainRegisterService;
import com.haoyu.tip.train.service.ITrainService;
import com.haoyu.tip.train.utils.TrainRegisterResult;

@Component
public class TrainTask {

	@Resource
	private RedisTemplate redisTemplate;
	@Resource
	private ITrainRegisterStatService trainRegisterStatService;
	@Resource
	private ITrainService trainService;
	@Resource
	private ITrainRegisterService trainRegisterService;

	//每天凌晨4点执行更新培训结果
	@Scheduled(cron = "0 0 4 * * ?")
	public void updateTrainRegisterResult() {
		redisTemplate.setValueSerializer(redisTemplate.getDefaultSerializer());
		ValueOperations<String,String> valueOper = redisTemplate.opsForValue();
		String key = "update_train_register_result_date";
		String today = DateFormatUtils.format(new Date(), "yyyy-MM-dd");
		if(redisTemplate.hasKey(key)){
			String date = valueOper.get(key);
			if (today.equals(date)) {
				return;
			}
		}
		List<Train> trains = trainService.findTrains(Maps.newHashMap());
		for (Train train : trains) {
			List<String> trainRegisterIds = trainRegisterStatService.getTrainResult(train.getId(), null);
			for (String trid : trainRegisterIds) {
				TrainRegister trainRegister = new TrainRegister();
				trainRegister.setId(trid);
				trainRegister.setResult(TrainRegisterResult.PASSED);
				trainRegisterService.updateTrainRegister(trainRegister);
			}
		}
		valueOper.set(key, today);
	}
}
