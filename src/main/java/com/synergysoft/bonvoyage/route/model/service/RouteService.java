package com.synergysoft.bonvoyage.route.model.service;

import java.util.ArrayList;

import com.synergysoft.bonvoyage.common.Paging;
import com.synergysoft.bonvoyage.route.model.dto.Route;

public interface RouteService {
	ArrayList<Route> selectAllRoute(Paging paging);
	int insertRoute(Route route);
	Route selectRoute(String routeBoardId);
	int selectListCount();
	int updateRoute(Route route);
	int deleteRoute(String routeBoardId);
	
}
