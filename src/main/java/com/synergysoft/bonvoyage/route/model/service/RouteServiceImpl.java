package com.synergysoft.bonvoyage.route.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.synergysoft.bonvoyage.route.model.dao.RouteDao;
import com.synergysoft.bonvoyage.route.model.dto.Route;

@Service("routeService")
public class RouteServiceImpl implements RouteService {
	
	@Autowired
	private RouteDao routeDao;
	
	@Override
	public ArrayList<Route> selectAllRoute() {
		return routeDao.selectAllRoute();
	}
	
}
