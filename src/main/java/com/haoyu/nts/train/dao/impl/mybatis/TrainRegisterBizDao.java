package com.haoyu.nts.train.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.train.dao.ITrainRegisterBizDao;
import com.haoyu.nts.train.entity.TrainRegisterExtend;
import com.haoyu.sip.core.jdbc.MybatisDao;

@Repository
public class TrainRegisterBizDao extends MybatisDao implements ITrainRegisterBizDao{

	@Override
	public List<TrainRegisterExtend> selectByParameter(Map<String, Object> param, PageBounds pageBounds) {
		return super.selectList("selectByParameter",param, pageBounds);
	}

}
