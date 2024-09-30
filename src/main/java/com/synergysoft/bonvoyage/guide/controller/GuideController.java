package com.synergysoft.bonvoyage.guide.controller;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.synergysoft.bonvoyage.guide.model.dto.Guide;
import com.synergysoft.bonvoyage.guide.model.service.GuideService;

@Controller
public class GuideController {
	private static final Logger logger = LoggerFactory.getLogger(GuideController.class);
	
	@Autowired
	private GuideService guideService;
	
	@RequestMapping("sagBlog.do")
	public String guideListMethod(Model model) {
	    ArrayList<Guide> list = guideService.selectAllGuide();  // 전체 목록 받기

	    logger.info("list : " + list);
	    if (list != null && list.size() > 0) {
	        model.addAttribute("guideList", list);  // "guideList"로 이름 변경
	        return "guide/guideListView";  // 뷰의 이름을 반환
	    } else {
	        model.addAttribute("message", "목록 조회 실패!");
	        return "common/error";  // 에러 페이지 뷰의 이름 반환
	    }
	}
	
	//새 블로그 등록 페이지로 이동 처리
	@RequestMapping("moveWrite.do")
	public String moveWritePage() {
	    return "guide/guideWriteForm";  // guideWriteForm.jsp로 이동
	}

	    
	
		
	}
	
	

	


