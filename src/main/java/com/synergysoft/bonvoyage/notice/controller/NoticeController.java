package com.synergysoft.bonvoyage.notice.controller;

import java.util.ArrayList;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.synergysoft.bonvoyage.common.Paging;
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
	public String moveInsertNotice() {

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
	public String selectDetailNotice(Model model,
			@RequestParam("noticeId") String noticeId 
			) {
		logger.info("noticeId : " + noticeId);
		Notice notice = noticeService.selectDetailNotice(noticeId);
		logger.info("notice : "+notice);
		model.addAttribute("notice",notice);
		return "notice/noticeDetail";
		
	}
}	
