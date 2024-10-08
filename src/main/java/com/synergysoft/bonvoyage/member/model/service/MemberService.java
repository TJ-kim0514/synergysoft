package com.synergysoft.bonvoyage.member.model.service;

import java.util.ArrayList;
import java.util.Map;

import com.synergysoft.bonvoyage.common.Paging;
import com.synergysoft.bonvoyage.member.model.dto.Member;

// jmoh03 (오정민)
public interface MemberService {
	
	Member selectLogin(String memId);
	String getReturnAccessToken(String code); // 2024. 10. 04 작성 및 테스트 성공
	Map<String, Object> getMemberInfo(String kakaoToken); // 2024. 10. 04 작성 및 테스트 성공
	Map<String, Object> naverConnectionCheck(Map<String, Object> apiJson); // 2024. 10. 05 작성
	Member userNaverLoginPro(Map<String, Object> apiJson); // 2024. 10. 05 작성
	Member selectSocialLogin(String memId);
	Member selectSocialLogin(Member member);
	Member selectIDSearch(String memPhone);
	Member selectPWSearch(String memId);
	Member selectMyinfo(String memId);
	ArrayList<Member> selectMember(Paging paging);
	int selectMemberListCount();
	Member selectMemberDetail(String memId);
	int selectCheckId(String memId);
	Member selectMemberByEmailId(Member member);
	
	int insertMember(Member member);
	int insertSocialMember(Member member);
	
	int updateLoginLog(String memId);
	int updateLogoutLog(String memId);
	int updateMyinfo(Member member);
	int updateMemberPw(Member member);
	int updateLeft(String memId);
	int updateMember(Member member);
	int updateMemberAccount(String memId);
	int updateMemberAdmin(String memId);
	
}
