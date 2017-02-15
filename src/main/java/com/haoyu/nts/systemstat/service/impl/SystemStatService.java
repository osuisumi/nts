package com.haoyu.nts.systemstat.service.impl;

import java.util.concurrent.TimeUnit;

import javax.annotation.Resource;

import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.data.redis.serializer.JacksonJsonRedisSerializer;
import org.springframework.stereotype.Service;

import com.haoyu.nts.systemstat.dao.ISystemStatDao;
import com.haoyu.nts.systemstat.entity.SystemStat;
import com.haoyu.nts.systemstat.service.ISystemStatService;
import com.haoyu.sip.core.utils.PropertiesLoader;

@Service
public class SystemStatService implements ISystemStatService {
	@Resource
	private ISystemStatDao systemStatDao;
	@Resource
	private RedisTemplate redisTemplate;
	
	@Override
	public SystemStat get() {
		redisTemplate.setValueSerializer(new JacksonJsonRedisSerializer(SystemStat.class));
		String key = PropertiesLoader.get("redis.app.key") + ":nts_system_stat";
		ValueOperations<String,SystemStat> valueOper = redisTemplate.opsForValue();
		SystemStat systemStat = null;
		if(redisTemplate.hasKey(key)){
			systemStat = valueOper.get(key);
		}else{
			systemStat = systemStatDao.get();
			valueOper.set(key, systemStat);
			redisTemplate.expire(key, 12, TimeUnit.HOURS);
		}
		return systemStat;
	}

}
