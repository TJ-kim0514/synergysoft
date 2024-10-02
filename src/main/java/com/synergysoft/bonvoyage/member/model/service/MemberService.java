package com.synergysoft.bonvoyage.member.model.service;

import java.util.ArrayList;

import com.synergysoft.bonvoyage.common.Paging;
import com.synergysoft.bonvoyage.member.model.dto.Member;

// jmoh03 (오정민)
public interface MemberService {
	
	Member selectLogin(String memId);
	Member selectSocialLogin(String memId);
	Member selectIDSearch(String memPhone);
	Member selectPWSearch(String memId);
	Member selectMyinfo(String memId);
	ArrayList<Member> selectMember(Paging paging);
	int selectMemberListCount();
	Member selectMemberDetail(String memId);
	int selectCheckId(String memId);
	
	int insertMember(Member member);
	int insertSocialMember(Member member);
	
	int updateMyinfo(Member member);
	int updateLeft(String memId);
	int updateMember(Member member);
	int updateMemberAccount(String memId);
	int updateMemberAdmin(String memId);
	
}
