package com.synergysoft.bonvoyage.member.model.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.synergysoft.bonvoyage.common.Paging;
import com.synergysoft.bonvoyage.member.model.dao.MemberDao;
import com.synergysoft.bonvoyage.member.model.dto.Member;

//jmoh03 (오정민)
@Service("memberService")
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;

	@Override
	// 일반 로그인
	public Member selectLogin(String memId) {
		return memberDao.selectLogin(memId);
	}
	
	// 카카오 로그인
	@Override
	public int selectKakakoEmailCheck(String kakao_email) {
		return memberDao.selectKakakoEmailCheck(kakao_email);
	}

	@Override
	// 소셜 로그인
	public Member selectSocialLogin(String memId) {
		return memberDao.selectSocialLogin(memId);
	}

	@Override
	// 아이디 중복 검사
	public int selectCheckId(String memId) {
		return memberDao.selectCheckId(memId);
	}

	@Override
	// 아이디 찾기
	public Member selectIDSearch(String memPhone) {
		return memberDao.selectIDSearch(memPhone);
	}

	@Override
	// 비밀번호 찾기
	public Member selectPWSearch(String memId) {
		return memberDao.selectPWSearch(memId);
	}

	@Override
	// 내 정보 조회
	public Member selectMyinfo(String memId) {
		return memberDao.selectMyinfo(memId);
	}

	@Override
	// 관리자 : 회원 목록 조회
	public ArrayList<Member> selectMember(Paging paging) {
		return memberDao.selectMember(paging);
	}

	@Override
	// 관리자 : 회원 목록 카운트 조회
	public int selectMemberListCount() {
		return memberDao.selectMemberListCount();
	}

	@Override
	// 관리자 : 회원 상세 조회
	public Member selectMemberDetail(String memId) {
		return memberDao.selectMemberDetail(memId);
	}

	@Override
	// 일반 회원가입
	public int insertMember(Member member) {
		return memberDao.insertMember(member);
	}

	@Override
	// 소셜 회원가입
	public int insertSocialMember(Member member) {
		return memberDao.insertSocialMember(member);
	}

	@Override
	// 내 정보 수정
	public int updateMyinfo(Member member) {
		return memberDao.updateMyinfo(member);
	}

	@Override
	// 회원 탈퇴
	public int updateLeft(String memId) {
		return memberDao.updateLeft(memId);
	}

	@Override
	// 관리자 : 회원 정보 수정
	public int updateMember(Member member) {
		return memberDao.updateMember(member);
	}

	@Override
	// 관리자 : 회원 계정 조치
	public int updateMemberAccount(String memId) {
		return memberDao.updateMemberAccount(memId);
	}

	@Override
	// 관리자 : 회원 관리자 부여
	public int updateMemberAdmin(String memId) {
		return memberDao.updateMemberAdmin(memId);
	}

}
