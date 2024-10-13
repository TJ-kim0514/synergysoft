package com.synergysoft.bonvoyage.bmap.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BMapController {

	@RequestMapping("movebmap.do")
	public String movebmapMethod () {
		return "bmap/bmapView";
	}
}
