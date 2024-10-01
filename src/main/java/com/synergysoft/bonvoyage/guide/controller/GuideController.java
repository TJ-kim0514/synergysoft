package com.synergysoft.bonvoyage.guide.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.synergysoft.bonvoyage.guide.model.dto.Guide;
import com.synergysoft.bonvoyage.guide.model.service.GuideService;
import com.synergysoft.bonvoyage.member.model.dto.Member;


@Controller
public class GuideController {
	private static final Logger logger = LoggerFactory.getLogger(GuideController.class);
	
	@Autowired
	private GuideService guideService;
	
	@RequestMapping("sagBlog.do")
	public String guideListMethod(Model model) {
	    ArrayList<Guide> list = guideService.selectAllGuide();  // ��ü ��� �ޱ�

	    logger.info("guide list : " + list);
	    if (list != null && list.size() > 0) {
	        model.addAttribute("guideList", list);  // "guideList"�� �̸� ����
	        return "guide/guideListView";  // ���� �̸��� ��ȯ
	    } else {
	        model.addAttribute("message", "��� ��ȸ ����!");
	        return "common/error";  // ���� ������ ���� �̸� ��ȯ
	    }
	}
	

	//�� ��α� ��� �������� �̵� ó��
	@RequestMapping("gmoveWrite.do")
	public String moveWritePage() {
	    return "guide/guideWriteForm";  // guideWriteForm.jsp�� �̵�
	}
	
	// �� ������ ��� ��û ó���� 
	@RequestMapping(value="ginsert.do", method=RequestMethod.POST)
	public String guideInsertMethod(Guide guide, Model model, HttpServletRequest request) {
	    // ���ǿ��� �α��ε� ����� ���� ��������
	    HttpSession session = request.getSession();
	    Member loginUser = (Member) session.getAttribute("loginUser");
	    
	    // loginUser�� null�� �ƴ� ��쿡 guideUserId�� ����
	    if (loginUser != null) {
	        guide.setGuideUserId(loginUser.getMemId());  // guideUserId�� �α����� ����� ID ����
	    } else {
	        model.addAttribute("message", "�α��� ������ �����ϴ�.");
	        return "common/error";
	    }
	    
	    logger.info("ginsert.do : " + guide);
	    
	    if (guideService.insertGuide(guide) > 0) {
	        // ��α� ��� ������ ��� �������� �����̷�Ʈ
	        return "redirect:sagBlog.do";
	    } else {
	        model.addAttribute("message", "�� ������ ��� ����!");
	        return "common/error";
	    }
	}
	
	//��α� �󼼳��� ���� ��û ó�� �޼ҵ�(��� �� �Բ� �������� ���)
	@RequestMapping("gdetail.do")
	public ModelAndView guideDetailMethod(
	        @RequestParam("postno") Guide guidepostId,
	        ModelAndView mv, HttpSession session) {

	    // ��α� �����͸� guidepostId�� �̿��� ������
	    Guide guide = guideService.selectGuide(guidepostId);

	    if (guide != null) {
	        // ��α� �����Ͱ� ���� ��� �󼼺��� �������� �̵�
	        mv.addObject("guide", guide);  // guide ��ü�� �信 ����
	        mv.setViewName("guide/guideDetailView");  // guideDetailView�� �̵�
	    } else {
	        // ��α� �����Ͱ� ���� ��� ���� �������� �̵�
	        mv.addObject("message", guidepostId + "�� ��α� �󼼺��� ��û ����!");
	        mv.setViewName("common/error");  // ���� �������� �̵�
	    }

	    return mv;  // ModelAndView ��ȯ
	}
		
		
		
}
		
		
		
	
			
			

	//�����ϱ�
	
	//�����ϱ�
	


	
		

	
	

	


