/**
 * 
 */
package com.haoyu.nts.index.dao;

import java.util.List;
import java.util.Map;

import com.haoyu.nts.index.entity.UserBizAuthorize;

/**
 * @author lianghuahuang
 *
 */
public interface INtsIndexDao {
	List<UserBizAuthorize> selectUserAuthorize(Map<String,Object> param );
}
