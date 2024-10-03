package com.synergysoft.bonvoyage.member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

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
	// jmoh03 (오정민)
	@RequestMapping(value = "loginPage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveLoginPage(Member member, HttpSession session, SessionStatus status, HttpServletRequest request,
			Model model) {
		logger.info("로그인 페이지 요청");
		return "member/loginPage";
	}

	// 소셜 로그인 구현(카카오) | 2024. 10. 02 작성
	// jmoh03 (오정민)
	@RequestMapping(value = "kakaoLogin.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveKakaoLoginPage(HttpSession session,
			@RequestParam String kakao_kakaoId,
			@RequestParam String kakao_email,
			@RequestParam String kakao_name) {
		
		logger.info("카카오 로그인 페이지 요청");
		
		int result = memberService.selectKakakoEmailCheck(kakao_email);
		
		if(result != 0) {
			return "Kakao_Login";
		} else {
			return "Kakao_Enroll";			
		}
	}

	// 소셜 로그인 구현(네이버) | 2024. 10. 02 작성
	// jmoh03 (오정민)
	@RequestMapping(value = "naverLogin.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveNaverLoginPage() {
		return "";
	}

	// 소셜 로그인 구현(구글) | 2024. 10. 02 작성
	// jmoh03 (오정민)
	@RequestMapping(value = "googleLogin.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveGoogleLoginPage() {
		return "";
	}

	// 회원가입 페이지 출력 | 2024. 09. 28 작성 및 테스트 성공
	// jmoh03 (오정민)
	@RequestMapping("enrollPage.do")
	public String moveEnrollPage() {
		logger.info("회원가입 페이지 요청");
		return "member/enrollPage";
	}

	// 아이디 찾기 페이지 출력 | 2024. 09. 28 작성 및 테스트 성공
	// jmoh03 (오정민)
	@RequestMapping(value = "idSearchPage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveIDSearchPage() {
		logger.info("아이디 찾기 페이지 요청");
		return "member/idSearch";
	}

	// 비밀번호 찾기 페이지 출력 | 2024. 09. 28 작성 및 테스트 성공
	// jmoh03 (오정민)
	@RequestMapping(value = "pwSearchPage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String movePWSearchPage() {
		logger.info("비밀번호 찾기 페이지 요청");
		return "member/pwSearch";
	}

	// 내 정보 조회 페이지 출력 | 2024. 09. 28 작성 및 테스트 성공
	// jmoh03 (오정민)
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
	// jmoh03 (오정민)
	@RequestMapping(value = "myGuideBoardComment.do")
	public String moveMyinfoCommentGuideBoard() {
		logger.info("내가 쓴 댓글(가이드게시판) 페이지 요청");
		return "member/myinfo/comment/guideBoard";
	}

	// 내가 쓴 댓글(경로게시판) 페이지 출력 | 2024. 09. 28 작성 및 테스트 성공
	// jmoh03 (오정민)
	@RequestMapping(value = "myRouteBoardComment.do")
	public String moveMyinfoCommentRouteBoard() {
		logger.info("내가 쓴 댓글(경로게시판) 페이지 요청");
		return "member/myinfo/comment/routeBoard";
	}

	// 관리자 : 회원 목록 조회 페이지 출력 | 2024. 10. 02 수정
	// ejjung02 (정은지)
	@RequestMapping(value = "memberList.do")
	public String moveMemberList(Model model,
			@RequestParam(name = "page", required = false) String page,
			@RequestParam(name = "limit", required = false) String slimit,
			@RequestParam(name = "groupLimit", required = false) String glimit) {
		logger.info("회원 목록 조회 페이지 요청");

		// paging
		// 기본세팅-----------------------------------------------------------------------
		// 출력할 페이지(기본값 1페이지)
		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}
		// 한페이지에 출력할 회운 수 (20명)
		int limit = 20;
		if (slimit != null) {
			limit = Integer.parseInt(slimit);
		}
		// 페이징 그룹 갯수 (기본값 5개 세팅)
		int groupLimit = 5;
		if (glimit != null) {
			groupLimit = Integer.parseInt(glimit);
		}
		// 총 회원 수 조회
		int listCount = memberService.selectMemberListCount();
		logger.info("회원 수 : " + listCount);

		// 페이징 처리 값생성
		Paging paging = new Paging(listCount, limit, currentPage, "memberList.do", groupLimit);
		paging.calculate();

		ArrayList<Member> memberList = memberService.selectMember(paging);

		logger.info("memberList : " + memberList);
		if (memberList != null && memberList.size() > 0) {
			model.addAttribute("memberList", memberList);
			model.addAttribute("paging", paging);
			model.addAttribute("currentPage", currentPage);
			return "admin/memberList"; // 뷰의 이름을 반환
		} else {
			model.addAttribute("message", "목록 조회 실패!");
			return "common/error"; // 에러 페이지 뷰의 이름 반환
		}
	}

	// 관리자 : 회원 상세 조회 페이지 출력 (정은지) | 2024. 10. 02 수정
	// ejjung02 (정은지)
	@RequestMapping(value = "memberDetail.do")
	public String moveMemberDetail() {
		logger.info("회원 상세 조회 페이지 요청");
		return "admin/memberDetail";
	}

	// 로그인 기능 | 2024. 09. 28 작성 및 테스트 성공
	// jmoh03 (오정민)
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
	// jmoh03 (오정민)
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
	// jmoh03 (오정민)
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
	// jmoh03 (오정민)
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
	// jmoh03 (오정민)
	@RequestMapping(value = "idSearch.do", method = RequestMethod.POST)
	public String idSearchMethod() {
		return "member/idSearch";
	} // 아이디 찾기 기능

	// 비밀번호 찾기 기능
	// jmoh03 (오정민)
	@RequestMapping(value = "pwSearch.do", method = RequestMethod.POST)
	public String pwSearchMethod() {
		return "member/pwSearch";
	} // 비밀번호 찾기 기능

	// 내 정보 수정 기능
	// jmoh03 (오정민)
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
	// jmoh03 (오정민)
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
	// ejjung02 (정은지)
	@RequestMapping(value = "memberUpdate.do", method = RequestMethod.POST)
	public String memberUpdateMethod() {
		return "memberDetail.do";
	} // 관리자 : 회원 정보 수정 기능

	// 관리자 : 회원 계정 조치 기능
	// ejjung02 (정은지)
	@RequestMapping(value = "memberAccountUpdate.do", method = RequestMethod.POST)
	public String memberAccountUpdateMethod() {
		return "memberDetail.do";
	} // 관리자 : 회원 계정 조치 기능

	// 관리자 : 회원 관리자 부여 기능
	// ejjung02 (정은지)
	@RequestMapping(value = "memberAdmin.do", method = RequestMethod.POST)
	public String memberAdminMethod() {
		return "memberDetail.do";
	} // 관리자 : 회원 관리자 부여 기능
}
