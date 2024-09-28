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
	
	// 로그인 페이지 출력 | 2024. 09. 28 작성 및 테스트 성공
	@RequestMapping(value = "loginPage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveLoginPage() {
		return "member/loginPage";
	}
	
	// 회원가입 페이지 출력 | 2024. 09. 28 작성 및 테스트 성공
	@RequestMapping("enrollPage.do")
	public String moveEnrollPage() {
		return "member/enrollPage";
	}
	
	// 소셜 로그인 페이지 출력 | 2024. 09. 28 작성 및 테스트 성공
	@RequestMapping(value = "socialLoginPage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveSocialLoginPage() {
		return "member/socialLoginPage";
	}
	
	// 소셜 회원가입 페이지 출력 | 2024. 09. 28 작성 및 테스트 성공
	@RequestMapping(value = "socialEnrollPage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveSocialEnrollPage() {
		return "member/socialEnrollPage";
	}
	
	// 아이디 찾기 페이지 출력 | 2024. 09. 28 작성 및 테스트 성공
	@RequestMapping(value = "idSearchPage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveIDSearchPage() {
		return "member/idSearch";
	}
	
	// 비밀번호 찾기 페이지 출력 | 2024. 09. 28 작성 및 테스트 성공
	@RequestMapping(value = "pwSearchPage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String movePWSearchPage() {
		return "member/pwSearch";
	}
	
	// 내 정보 조회 페이지 출력 | 2024. 09. 28 작성 및 테스트 성공
	@RequestMapping(value = "myinfo.do")
	public String moveMyInfoPage(@RequestParam("memId") String memId, Model model) {
		logger.info("myinfo.do : " + memId);
		
		Member member = memberService.selectMyinfo(memId);
		
		if (member != null) {
			model.addAttribute("member", member);
			return "member/myinfo/myinfo";
		} else {
			model.addAttribute("message", memId + " 님의 정보를 조회하는데 실패하였습니다.");
			return "common/error";
		}
	} // 내 정보 조회 페이지 출력
	
	// 내가 쓴 댓글(가이드게시판) 페이지 출력 | 2024. 09. 28 작성 및 테스트 성공
	@RequestMapping(value = "myinfo/comment/guideBoard.do")
	public String moveMyinfoCommentGuideBoard() {
		return "member/myinfo/comment/guideBoard";
	}
	
	// 내가 쓴 댓글(경로게시판) 페이지 출력 | 2024. 09. 28 작성 및 테스트 성공
	@RequestMapping(value = "myinfo/comment/routeBoard.do")
	public String moveMyinfoCommentRouteBoard() {
		return "member/myinfo/comment/routeBoard";
	}

	// 관리자 : 회원 목록 조회 페이지 출력 | 2024. 09. 28 작성 및 테스트 성공
	@RequestMapping(value = "admin/memberList.do")
	public String moveMemberList() {
		return "admin/memberList";
	}
	
	// 관리자 : 회원 상세 조회 페이지 출력 | 2024. 09. 28 작성 및 테스트 성공
	@RequestMapping(value = "admin/memberDetail.do")
	public String moveMemberDetail() {
		return "admin/memberDetail";
	}
	
	// 로그인 기능 | 2024. 09. 28 작성 및 테스트 성공
	@RequestMapping(value = "login.do", method=RequestMethod.POST)
	public String loginMethod(Member member, HttpSession session, SessionStatus status, Model model) {
		logger.info("login : " + member);
		
		Member loginUser = memberService.selectLogin(member.getMemId());
		
		if (loginUser != null && this.bcryptPasswordEncoder.matches(member.getMemPw(), loginUser.getMemPw())) {
			session.setAttribute("loginUser", loginUser);
			status.setComplete();
			return "common/main";
		} else { 
			model.addAttribute("message", "로그인에 실패하였습니다. 아이디와 비밀번호를 확인 후 다시 시도해주시기 바랍니다.");
			return "common/error";
		}
	}
	
	// 회원가입 기능 | 2024. 09. 28 작성 및 테스트 성공
	@RequestMapping(value = "enroll.do", method=RequestMethod.POST)
	public String enrollMethod(Member member, Model model, HttpServletRequest request) {
		logger.info("enroll.do : " + member);
		
		member.setMemPw(bcryptPasswordEncoder.encode(member.getMemPw()));
		logger.info("after encode : " + member.getMemPw() + ", length : " + member.getMemPw().length());
		
		if (memberService.insertMember(member) > 0) {
			return "member/loginPage";
		} else {
			model.addAttribute("message", "회원가입에 실패하였습니다. 다시 시도해주시기 바랍니다.");
			return "common/error";
		}
	}
	
	// 로그아웃 기능 | 2024. 09. 28 작성 및 테스트 성공
	@RequestMapping("logout.do")
	public String logoutMethod(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
		
		if (session != null) {
			session.invalidate();
			return "common/main";
		} else {
			model.addAttribute("message", "세션이 만료되어 로그아웃에 실패하였습니다. 메인페이지로 돌아가세요.");
			return "common/error";
		}
	} // 로그아웃 기능
	
	// 아이디 중복 검사 기능 | 2024. 09. 28 수정 필요
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
	} // 아이디 중복 검사 기능
	
	// 아이디 찾기 기능
	@RequestMapping(value="idSearch.do", method=RequestMethod.POST)
	public String idSearchMethod() {
		return "member/idSearch";		
	} // 아이디 찾기 기능
	
	// 비밀번호 찾기 기능
	@RequestMapping(value="pwSearch.do", method=RequestMethod.POST)
	public String pwSearchMethod() {
		return "member/pwSearch";		
	} // 비밀번호 찾기 기능

	// 내 정보 수정 기능
	@RequestMapping(value="myinfo/update.do", method=RequestMethod.POST)
	public String myinfoUpdateMethod() {
		return "member/myinfo/myinfo";
	} // 내 정보 수정 기능
	
	// 회원 탈퇴 기능
	@RequestMapping(value="myinfo/left.do", method=RequestMethod.POST)
	public String memberLeftMethod() {
		return "common/main";
	} // 회원 탈퇴 기능
	
	// 관리자 : 회원 정보 수정 기능
	@RequestMapping(value="admin/memberUpdate.do", method=RequestMethod.POST)
	public String memberUpdateMethod() {
		return "admin/memberDetail";
	} // 관리자 : 회원 정보 수정 기능
	
	// 관리자 : 회원 계정 조치 기능
	@RequestMapping(value="admin/memberAccountUpdate.do", method=RequestMethod.POST)
	public String memberAccountUpdateMethod() {
		return "admin/memberDetail";		
	} // 관리자 : 회원 계정 조치 기능
	
	// 관리자 : 회원 관리자 부여 기능
	@RequestMapping(value="admin/memberAdmin.do", method=RequestMethod.POST)
	public String memberAdminMethod() {
		return "admin/memberDetail";
	} // 관리자 : 회원 관리자 부여 기능
}
