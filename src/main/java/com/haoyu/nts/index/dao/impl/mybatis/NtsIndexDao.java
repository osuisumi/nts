/**
 * 
 */
package com.haoyu.nts.index.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.haoyu.nts.index.dao.INtsIndexDao;
import com.haoyu.nts.index.entity.UserBizAuthorize;
import com.haoyu.sip.core.jdbc.MybatisDao;

/**
 * @author lianghuahuang
 *
 */
@Repository
public class NtsIndexDao extends MybatisDao implements INtsIndexDao {

	/* (non-Javadoc)
	 * @see com.haoyu.nts.index.dao.INtsIndexDao#selectUserAuthorize(java.util.Map)
	 */
	@Override
	public List<UserBizAuthorize> selectUserAuthorize(
			Map<String, Object> param) {
		return super.selectList("selectUserAuthorize", param);
	}

}
