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
import org.springframework.web.servlet.ModelAndView;

import com.synergysoft.bonvoyage.common.Paging;
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
	public String moveLoginPage(Member member, HttpSession session, SessionStatus status, HttpServletRequest request, Model model) {
		logger.info("로그인 페이지 요청");
		return "member/loginPage";
	}

	// 회원가입 페이지 출력 | 2024. 09. 28 작성 및 테스트 성공
	@RequestMapping("enrollPage.do")
	public String moveEnrollPage() {
		logger.info("회원가입 페이지 요청");
		return "member/enrollPage";
	}


//	// 카카오 로그인 페이지 출력
//	@RequestMapping(value = "kakaoLogin.do", method = { RequestMethod.GET })
//	public String moveKakaoLoginPage(@RequestParam(value = "code", required = false) String code, HttpSession session) throws Exception {
//		logger.info("카카오 로그인 페이지 요청");
//		
//		System.out.println("#########" + code);
//		String access_Token = memberService.getAccessToken(code);
//		Member memberInfo = memberService.getMemberInfo(access_Token);
//		System.out.println("###access_Token#### : " + access_Token);
//		System.out.println("###nickname#### : " + memberInfo.getMemNickNm());
//		System.out.println("###email#### : " + memberInfo.getMemId());
//		
//		// 아래 코드가 추가되는 내용
//		session.invalidate();
//		// 위 코드는 session객체에 담긴 정보를 초기화 하는 코드.
//		session.setAttribute("kakaoN", memberInfo.getMemNickNm());
//		session.setAttribute("kakaoE", memberInfo.getMemId());
//		
//		return "member/kakaoLogin";
//	}

	// 아이디 찾기 페이지 출력 | 2024. 09. 28 작성 및 테스트 성공
	@RequestMapping(value = "idSearchPage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveIDSearchPage() {
		logger.info("아이디 찾기 페이지 요청");
		return "member/idSearch";
	}

	// 비밀번호 찾기 페이지 출력 | 2024. 09. 28 작성 및 테스트 성공
	@RequestMapping(value = "pwSearchPage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String movePWSearchPage() {
		logger.info("비밀번호 찾기 페이지 요청");
		return "member/pwSearch";
	}

	// 내 정보 조회 페이지 출력 | 2024. 09. 28 작성 및 테스트 성공
	@RequestMapping(value = "myinfo.do")
	public String moveMyInfoPage(@RequestParam("memId") String memId, Model model) {

		logger.info("내 정보 조회 페이지 요청 : " + memId);


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
		logger.info("내가 쓴 댓글(가이드게시판) 페이지 요청");
		return "member/myinfo/comment/guideBoard";
	}

	// 내가 쓴 댓글(경로게시판) 페이지 출력 | 2024. 09. 28 작성 및 테스트 성공
	@RequestMapping(value = "myinfo/comment/routeBoard.do")
	public String moveMyinfoCommentRouteBoard() {
		logger.info("내가 쓴 댓글(경로게시판) 페이지 요청");
		return "member/myinfo/comment/routeBoard";
	}

	// 관리자 : 회원 목록 조회 페이지 출력 | 2024. 09. 28 작성 및 테스트 성공
	@RequestMapping(value = "admin/memberList.do")

	public String moveMemberList() {
		logger.info("회원 목록 조회 페이지 요청");
		return "admin/memberList";
	}

	// 관리자 : 회원 상세 조회 페이지 출력 | 2024. 09. 28 작성 및 테스트 성공
	@RequestMapping(value = "admin/memberDetail.do")
	public String moveMemberDetail() {
		logger.info("회원 상세 조회 페이지 요청");
		return "admin/memberDetail";
	}

	// 로그인 기능 | 2024. 09. 28 작성 및 테스트 성공
	@RequestMapping(value = "login.do", method = RequestMethod.POST)
	public String loginMethod(Member member, HttpSession session, SessionStatus status, Model model) {

		logger.info("로그인 요청 : " + member);

		Member loginUser = memberService.selectLogin(member.getMemId());

		if (loginUser != null && this.bcryptPasswordEncoder.matches(member.getMemPw(), loginUser.getMemPw())) {
			session.setAttribute("loginUser", loginUser);
			status.setComplete();

			logger.info("로그인 요청 : " + loginUser.getMemNickNm() + "(" + loginUser.getMemId() + ")" + " 님이 로그인 하였습니다.");
			return "redirect:main.do";
		} else {
			model.addAttribute("message", "로그인에 실패하였습니다. 아이디와 비밀번호를 확인 후 다시 시도해주시기 바랍니다.");
			return "common/error";
		}
	}

	// 회원가입 기능 | 2024. 09. 28 작성 및 테스트 성공
	@RequestMapping(value = "enroll.do", method = RequestMethod.POST)
	public String enrollMethod(Member member, Model model, HttpServletRequest request) {
		logger.info("enroll.do : " + member);

		member.setMemPw(bcryptPasswordEncoder.encode(member.getMemPw()));
		logger.info("after encode : " + member.getMemPw() + ", length : " + member.getMemPw().length());

		if (memberService.insertMember(member) > 0) {
			logger.info("회원가입 요청 : " + member.getMemNickNm() + "(" + member.getMemId() + ")" + "님이 회원가입에 성공하였습니다.");
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
	@RequestMapping(value = "idchk.do", method = RequestMethod.POST)
	@ResponseBody
	public void dupCheckIdMethod(@RequestParam("memId") String memId, HttpServletResponse response) throws IOException {
		int userIdCount = memberService.selectCheckId(memId);
		String returnStr = null;
		if (userIdCount == 0) {
			returnStr = "ok";
		} else {
			returnStr = "dup";
		}

		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.append(returnStr);
		out.flush();
		out.close();
	} // 아이디 중복 검사 기능

	// 아이디 찾기 기능
	@RequestMapping(value = "idSearch.do", method = RequestMethod.POST)
	public String idSearchMethod() {
		return "member/idSearch";
	} // 아이디 찾기 기능

	// 비밀번호 찾기 기능
	@RequestMapping(value = "pwSearch.do", method = RequestMethod.POST)
	public String pwSearchMethod() {
		return "member/pwSearch";
	} // 비밀번호 찾기 기능

	// 내 정보 수정 기능
	@RequestMapping(value = "myinfo/update.do", method = RequestMethod.POST)
	public String myinfoUpdateMethod(Member member, Model model, HttpServletRequest request,
			@RequestParam("originalMemPw") String originalMemPw) {


		logger.info("내 정보 수정 요청 : " + member);


		// 내 정보 수정에서 회원이 비밀번호를 변경한 경우 변경한 요청에 따라 비밀번호를 변경하는 기능
		if (member.getMemPw() != null && member.getMemPw().length() > 0) {
			member.setMemPw(bcryptPasswordEncoder.encode(member.getMemPw()));
			logger.info("after encode : " + member.getMemPw() + ", length : " + member.getMemPw().length());
		} else {
			member.setMemPw(originalMemPw);
		}

		// 내 정보 수정 요청 성공여부
		if (memberService.updateMyinfo(member) > 0) {
			logger.info("내 정보 수정 요청 성공 : " + member);
			return "redirect:../main.do";
		} else {
			model.addAttribute("message", "회원정보 수정에 실패하였습니다.");
			logger.info("내 정보 수정 요청 실패 : " + member);
			return "common/error";
		}
	} // 내 정보 수정 기능

	// 회원 탈퇴 기능
	@RequestMapping(value = "myinfo/left.do")
	public String memberLeftMethod(@RequestParam("memId") String memId, Model model) {

		if (memberService.updateLeft(memId) > 0) {

			logger.info("회원탈퇴 요청 성공 : " + memId);

			return "redirect:../logout.do";
		} else {
			model.addAttribute("message", "회원탈퇴에 실패하였습니다.");
			logger.info("회원탈퇴 요청 실패 : " + memId);
			return "common/error";
		}
	} // 회원 탈퇴 기능

	// 관리자 : 회원 정보 수정 기능
	@RequestMapping(value = "admin/memberUpdate.do", method = RequestMethod.POST)
	public String memberUpdateMethod() {
		return "admin/memberDetail.do";
	} // 관리자 : 회원 정보 수정 기능

	// 관리자 : 회원 계정 조치 기능
	@RequestMapping(value = "admin/memberAccountUpdate.do", method = RequestMethod.POST)
	public String memberAccountUpdateMethod() {
		return "admin/memberDetail.do";
	} // 관리자 : 회원 계정 조치 기능

	// 관리자 : 회원 관리자 부여 기능
	@RequestMapping(value = "admin/memberAdmin.do", method = RequestMethod.POST)
	public String memberAdminMethod() {
		return "admin/memberDetail.do";
	} // 관리자 : 회원 관리자 부여 기능
}
