package com.synergysoft.bonvoyage.route.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.synergysoft.bonvoyage.common.Paging;
import com.synergysoft.bonvoyage.route.model.dao.RouteDao;
import com.synergysoft.bonvoyage.route.model.dto.Route;

@Service("routeService")
public class RouteServiceImpl implements RouteService {
	
	@Autowired
	private RouteDao routeDao;
	
	@Override
	public ArrayList<Route> selectAllRoute(Paging paging) {
		return routeDao.selectAllRoute(paging);
	}

	@Override
	public int insertRoute(Route route) {
		return routeDao.insertRoute(route);
	}

	@Override
	public Route selectRoute(String routeBoardId) {
		return routeDao.selectRoute(routeBoardId);
	}

	@Override
	public int selectListCount() {
		return routeDao.selectListCount();
	}

	@Override
	public int updateRoute(Route route) {
		return routeDao.updateRoute(route);
	}

	@Override
	public int deleteRoute(String routeBoardId) {
		return routeDao.deleteRoute(routeBoardId);
	}
	
}
