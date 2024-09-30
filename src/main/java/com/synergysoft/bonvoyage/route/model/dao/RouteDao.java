package com.synergysoft.bonvoyage.route.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.synergysoft.bonvoyage.route.model.dto.Route;

@Repository("RouteDao")
public class RouteDao {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public ArrayList<Route> selectAllRoute() {
		List<Route> list = sqlSessionTemplate.selectList("routeMapper.selectAllRoute");
		return (ArrayList<Route>)list;
	}
}
