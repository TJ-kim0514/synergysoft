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
	    ArrayList<Guide> list = guideService.selectAllGuide();  // ��ü ��� �ޱ�

	    logger.info("list : " + list);
	    if (list != null && list.size() > 0) {
	        model.addAttribute("guideList", list);  // "guideList"�� �̸� ����
	        return "guide/guideListView";  // ���� �̸��� ��ȯ
	    } else {
	        model.addAttribute("message", "��� ��ȸ ����!");
	        return "common/error";  // ���� ������ ���� �̸� ��ȯ
	    }
	}
	
	//�� ��α� ��� �������� �̵� ó��
	@RequestMapping("moveWrite.do")
	public String moveWritePage() {
	    return "guide/guideWriteForm";  // guideWriteForm.jsp�� �̵�
	}

	    
	
		
	}
	
	

	


