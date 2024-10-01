package com.synergysoft.bonvoyage.notice.controller;

import java.util.ArrayList;

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

import com.synergysoft.bonvoyage.common.Paging;
import com.synergysoft.bonvoyage.member.model.dto.Member;
import com.synergysoft.bonvoyage.notice.model.dto.Notice;
import com.synergysoft.bonvoyage.notice.model.service.NoticeService;

@Controller
public class NoticeController {
	// �α� ������ü ����
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@Autowired
	private NoticeService noticeService;
	
	@RequestMapping("sanotice.do")
	public String noticeListMethod(Model model,
			@RequestParam(name="page", required=false) String page,
			@RequestParam(name="limit", required=false) String slimit,
			@RequestParam(name="groupLimit", required=false) String glimit
			) {
		
		//paging �⺻����-----------------------------------------------------------------------
		// ����� ������(�⺻�� 1������)
		int currentPage=1;
		if(page!=null) {
			currentPage = Integer.parseInt(page);
		}
		// ���������� ����� ������ ���� (�⺻�� 10�� ����)
		int limit =10;
		if(slimit !=null) {
			limit= Integer.parseInt(slimit);
		}
		// ����¡ �׷� ���� (�⺻�� 5�� ����)
		int groupLimit =5;
		if(glimit!=null) {
			groupLimit=Integer.parseInt(glimit);
		}
		// �� ��� ���� ��ȸ
		int listCount = noticeService.selectListCount();
		logger.info("�������� �� ���� : " +listCount);
		
		// ����¡ ó�� ������
		Paging paging = new Paging(listCount, limit, currentPage, "sanotice.do", groupLimit);
		paging.calculate();
		//paging ����---------------------------------------------------------------------------
	    // ���񽺸� ��� ��ȸ ��û�ϰ� ��� �ޱ�(����¡ ó��)
	    ArrayList<Notice> list = noticeService.selectAllNotice(paging);  // ��ü��� �޾ƿ���

	    logger.info("list : " + list);
	    if(list != null && list.size() > 0) {
	        model.addAttribute("list", list);
			model.addAttribute("paging",paging);
			model.addAttribute("currentPage",currentPage);
	        return "notice/noticeListView";  // ���� �̸��� ��ȯ
	    } else {
	        model.addAttribute("message", "��� ��ȸ ����!");
	        return "common/error";  // ���� ������ ���� �̸� ��ȯ
	    }
	}
	
	// �������� �ۼ������� �̵�
	@RequestMapping("minotice.do")
	public String moveInsertNotice(
			) {
		return "notice/insertNoticeView";
	}
	
	// �������� ���
	@RequestMapping(value="inotice.do", method=RequestMethod.POST)
	public String insertNotice(Notice notice, Model model
			
			) {
		logger.info("ninsert.do : " + notice);

		if(noticeService.insertNotice(notice)>0) {
			// �� ������ ��� ������ ��� ������ �������� ��û
			return "redirect:sanotice.do";  // ���� �ִ� Ŭ������ �޼ҵ� ���� : redirect:url��
		} else {
			model.addAttribute("message","�� ������ ��� ����");
			return "common/error";
		}
	}
	
	// �������� �󼼺���
	@RequestMapping("msnotice.do")
	public ModelAndView selectDetailNotice(ModelAndView mv,  	// view ������ ���۰�ü
			@RequestParam("noticeId") String noticeId,			// �˻��� ������ id�ҷ�����
			HttpSession session									// ������ ���� Ȯ�ο� ��ü
			) {
		logger.info("�󼼺��� noticeId : " + noticeId);
		Notice notice = noticeService.selectDetailNotice(noticeId);
		logger.info("�󼼺��� notice : "+notice);
		if(notice != null) {
			mv.addObject("notice", notice);
			Member loginUser = (Member)session.getAttribute("loginUser");
			if(loginUser != null && loginUser.getMemType().equals("ADMIN")) {
				mv.setViewName("notice/noticeAdminDetailView");
			} else {
				mv.setViewName("notice/noticeUserDetailView");
			}
			
		} else {
			mv.addObject("message", noticeId +"�� ������ �󼼺��� ��û ����");
			mv.setViewName("common/error");
		}
		return mv;
	}
	
	// �������� ���������� �̵�
	@RequestMapping("munotice.do")
	public ModelAndView noticeMoveUpdate(
			@RequestParam("noticeId") String noticeId,
			ModelAndView mv
			) {
		Notice notice = noticeService.selectDetailNotice(noticeId);
		
		if(notice!=null) {
			mv.addObject("notice",notice);
			mv.setViewName("notice/noticeUpdateView");
		} else {
			mv.addObject("message",noticeId+ "�� ������ ���������� �̵� ����");
			mv.setViewName("common/error");
		}
				
		return mv;
	}
	
	// �������� ���� ó��
	@RequestMapping(value="unotice.do", method=RequestMethod.POST)
	public String noticeUpdate(
			Notice notice,
			Model model
			) {
		logger.info("notice : " + notice);
		if(noticeService.updateNotice(notice)>0) {
			return "redirect:sanotice.do";
		}else {
			model.addAttribute("message",notice.getNoticeId()+ "�� ������ ������ �����Ͽ����ϴ�.");
			return "common/error";
		}
		
		
		
	}
	
	
	// �������� ���� ó��(����)
	@RequestMapping("dnotice.do")
	public String noticeDelete(
			Notice notice,
			Model model) {
		logger.info("noticedelete id: "+notice.getNoticeId());
		if(noticeService.deleteNotice(notice)>0) {
			return "redirect:sanotice.do";
		} else {
			model.addAttribute("message",notice.getNoticeId()+"�� ������ ���� ����");
			return "common/error";
		}
	}
	
}	
