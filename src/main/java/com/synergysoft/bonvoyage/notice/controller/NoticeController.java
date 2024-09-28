package com.synergysoft.bonvoyage.notice.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.synergysoft.bonvoyage.notice.model.dto.Notice;
import com.synergysoft.bonvoyage.notice.model.service.NoticeService;

@Controller
public class NoticeController {
	// �α� ������ü ����
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@Autowired
	private NoticeService noticeService;
	
	@RequestMapping("sanotice.do")
	public String noticeListMethod(Model model) {
		
	    // ���񽺸� ��� ��ȸ ��û�ϰ� ��� �ޱ�
	    ArrayList<Notice> list = noticeService.selectAllNotice();  // ��ü��� �޾ƿ���

	    logger.info("list : " + list);
	    if(list != null && list.size() > 0) {
	        model.addAttribute("list", list);
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
