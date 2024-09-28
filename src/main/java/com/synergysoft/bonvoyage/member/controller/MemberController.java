package com.synergysoft.bonvoyage.member.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;

import com.synergysoft.bonvoyage.member.model.dto.Member;
import com.synergysoft.bonvoyage.member.model.service.MemberService;

@Controller
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	// �α��� ������ ��� | 2024. 09. 28 �ۼ� �� �׽�Ʈ ����
	@RequestMapping(value = "loginPage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveLoginPage() {
		return "member/loginPage";
	}
	
	// ȸ������ ������ ��� | 2024. 09. 28 �ۼ� �� �׽�Ʈ ����
	@RequestMapping("enrollPage.do")
	public String moveEnrollPage() {
		return "member/enrollPage";
	}
	
	// �Ҽ� �α��� ������ ��� | 2024. 09. 28 �ۼ� �� �׽�Ʈ ����
	@RequestMapping(value = "socialLoginPage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveSocialLoginPage() {
		return "member/socialLoginPage";
	}
	
	// �Ҽ� ȸ������ ������ ��� | 2024. 09. 28 �ۼ� �� �׽�Ʈ ����
	@RequestMapping(value = "socialEnrollPage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveSocialEnrollPage() {
		return "member/socialEnrollPage";
	}
	
	// ���̵� ã�� ������ ��� | 2024. 09. 28 �ۼ� �� �׽�Ʈ ����
	@RequestMapping(value = "idSearchPage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveIDSearchPage() {
		return "member/idSearch";
	}
	
	// ��й�ȣ ã�� ������ ��� | 2024. 09. 28 �ۼ� �� �׽�Ʈ ����
	@RequestMapping(value = "pwSearchPage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String movePWSearchPage() {
		return "member/pwSearch";
	}
	
	// �� ���� ��ȸ ������ ��� | 2024. 09. 28 �ۼ� �� �׽�Ʈ ����
	@RequestMapping(value = "myinfo.do")
	public String moveMyInfoPage(@RequestParam("memId") String memId, Model model) {
		logger.info("myinfo.do : " + memId);
		
		Member member = memberService.selectMyinfo(memId);
		
		if (member != null) {
			model.addAttribute("member", member);
			return "member/myinfo/myinfo";
		} else {
			model.addAttribute("message", memId + " ���� ������ ��ȸ�ϴµ� �����Ͽ����ϴ�.");
			return "common/error";
		}
	} // �� ���� ��ȸ ������ ���
	
	// ���� �� ���(���̵�Խ���) ������ ��� | 2024. 09. 28 �ۼ� �� �׽�Ʈ ����
	@RequestMapping(value = "myinfo/comment/guideBoard.do")
	public String moveMyinfoCommentGuideBoard() {
		return "member/myinfo/comment/guideBoard";
	}
	
	// ���� �� ���(��ΰԽ���) ������ ��� | 2024. 09. 28 �ۼ� �� �׽�Ʈ ����
	@RequestMapping(value = "myinfo/comment/routeBoard.do")
	public String moveMyinfoCommentRouteBoard() {
		return "member/myinfo/comment/routeBoard";
	}

	// ������ : ȸ�� ��� ��ȸ ������ ��� | 2024. 09. 28 �ۼ� �� �׽�Ʈ ����
	@RequestMapping(value = "admin/memberList.do")
	public String moveMemberList() {
		return "admin/memberList";
	}
	
	// ������ : ȸ�� �� ��ȸ ������ ��� | 2024. 09. 28 �ۼ� �� �׽�Ʈ ����
	@RequestMapping(value = "admin/memberDetail.do")
	public String moveMemberDetail() {
		return "admin/memberDetail";
	}
	
	// �α��� ��� | 2024. 09. 28 �ۼ� �� �׽�Ʈ ����
	@RequestMapping(value = "login.do", method=RequestMethod.POST)
	public String loginMethod(Member member, HttpSession session, SessionStatus status, Model model) {
		logger.info("login : " + member);
		
		Member loginUser = memberService.selectLogin(member.getMemId());
		
		if (loginUser != null && this.bcryptPasswordEncoder.matches(member.getMemPw(), loginUser.getMemPw())) {
			session.setAttribute("loginUser", loginUser);
			status.setComplete();
			return "common/main";
		} else { 
			model.addAttribute("message", "�α��ο� �����Ͽ����ϴ�. ���̵�� ��й�ȣ�� Ȯ�� �� �ٽ� �õ����ֽñ� �ٶ��ϴ�.");
			return "common/error";
		}
	}
	
	// ȸ������ ��� | 2024. 09. 28 �ۼ� �� �׽�Ʈ ����
	@RequestMapping(value = "enroll.do", method=RequestMethod.POST)
	public String enrollMethod(Member member, Model model, HttpServletRequest request) {
		logger.info("enroll.do : " + member);
		
		member.setMemPw(bcryptPasswordEncoder.encode(member.getMemPw()));
		logger.info("after encode : " + member.getMemPw() + ", length : " + member.getMemPw().length());
		
		if (memberService.insertMember(member) > 0) {
			return "member/loginPage";
		} else {
			model.addAttribute("message", "ȸ�����Կ� �����Ͽ����ϴ�. �ٽ� �õ����ֽñ� �ٶ��ϴ�.");
			return "common/error";
		}
	}
	
	// �α׾ƿ� ��� | 2024. 09. 28 �ۼ� �� �׽�Ʈ ����
	@RequestMapping("logout.do")
	public String logoutMethod(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
		
		if (session != null) {
			session.invalidate();
			return "common/main";
		} else {
			model.addAttribute("message", "������ ����Ǿ� �α׾ƿ��� �����Ͽ����ϴ�. ������������ ���ư�����.");
			return "common/error";
		}
	} // �α׾ƿ� ���
	
	// ���̵� �ߺ� �˻� ��� | 2024. 09. 28 ���� �ʿ�
	@RequestMapping(value="idchk.do", method=RequestMethod.POST)
	@ResponseBody
	public void dupCheckIdMethod(@RequestParam("memId") String memId, 
			HttpServletResponse response) throws IOException {
		int userIdCount = memberService.selectCheckId(memId);
		String returnStr = null;
		if(userIdCount == 0) {
			returnStr = "ok";
		}else {
			returnStr = "dup";
		}
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.append(returnStr);
		out.flush();
		out.close();
	} // ���̵� �ߺ� �˻� ���
	
	// ���̵� ã�� ���
	@RequestMapping(value="idSearch.do", method=RequestMethod.POST)
	public String idSearchMethod() {
		return "member/idSearch";		
	} // ���̵� ã�� ���
	
	// ��й�ȣ ã�� ���
	@RequestMapping(value="pwSearch.do", method=RequestMethod.POST)
	public String pwSearchMethod() {
		return "member/pwSearch";		
	} // ��й�ȣ ã�� ���

	// �� ���� ���� ���
	@RequestMapping(value="myinfo/update.do", method=RequestMethod.POST)
	public String myinfoUpdateMethod() {
		return "member/myinfo/myinfo";
	} // �� ���� ���� ���
	
	// ȸ�� Ż�� ���
	@RequestMapping(value="myinfo/left.do", method=RequestMethod.POST)
	public String memberLeftMethod() {
		return "common/main";
	} // ȸ�� Ż�� ���
	
	// ������ : ȸ�� ���� ���� ���
	@RequestMapping(value="admin/memberUpdate.do", method=RequestMethod.POST)
	public String memberUpdateMethod() {
		return "admin/memberDetail";
	} // ������ : ȸ�� ���� ���� ���
	
	// ������ : ȸ�� ���� ��ġ ���
	@RequestMapping(value="admin/memberAccountUpdate.do", method=RequestMethod.POST)
	public String memberAccountUpdateMethod() {
		return "admin/memberDetail";		
	} // ������ : ȸ�� ���� ��ġ ���
	
	// ������ : ȸ�� ������ �ο� ���
	@RequestMapping(value="admin/memberAdmin.do", method=RequestMethod.POST)
	public String memberAdminMethod() {
		return "admin/memberDetail";
	} // ������ : ȸ�� ������ �ο� ���
}
