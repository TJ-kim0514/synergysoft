package com.synergysoft.bonvoyage.route.controller;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.synergysoft.bonvoyage.route.model.dto.Route;
import com.synergysoft.bonvoyage.route.model.service.RouteService;

@Controller
public class RouteController {
	private static final Logger logger = LoggerFactory.getLogger(RouteController.class);
	
	@Autowired
	private RouteService noticeService;
	
	// 뷰 페이지 이동 메소드
	@RequestMapping("moveWriteRoute.do")
	public String moveWritePage() {
		return "route/routeWritePage";
	}
	
	
	@RequestMapping("routeall.do")
	public ModelAndView selectAllRouteMethod(ModelAndView mv) {
		ArrayList<Route> list = noticeService.selectAllRoute();
		mv.setViewName("route/routeall");
		return mv;
	}//selectAllRouteMethod()
	
	
	
	
	
	
	
	
	
	
	
	
}








