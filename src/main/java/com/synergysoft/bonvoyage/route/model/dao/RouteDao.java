package com.synergysoft.bonvoyage.route.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.synergysoft.bonvoyage.common.Paging;
import com.synergysoft.bonvoyage.route.model.dto.Route;

@Repository("RouteDao")
public class RouteDao {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public ArrayList<Route> selectAllRoute(Paging paging) {
		List<Route> list = sqlSessionTemplate.selectList("routeMapper.selectAllRoute", paging);
		return (ArrayList<Route>)list;
	}

	public int insertRoute(Route route) {
		return sqlSessionTemplate.insert("routeMapper.insertRoute", route);
	}

	public Route selectRoute(String routeBoardId) {
		return sqlSessionTemplate.selectOne("routeMapper.selectRoute", routeBoardId);
	}

	public int selectListCount() {
		return sqlSessionTemplate.selectOne("routeMapper.selectListCount");
	}

	public int updateRoute(Route route) {
		return sqlSessionTemplate.update("routeMapper.updateRoute", route);
	}

	public int deleteRoute(String routeBoardId) {
		return sqlSessionTemplate.delete("routeMapper.deleteRoute", routeBoardId);
	}

	public int updateRouteLikeCount(String postId) {
		return sqlSessionTemplate.update("routeMapper.updateRouteLikeCount", postId);
	}
}
