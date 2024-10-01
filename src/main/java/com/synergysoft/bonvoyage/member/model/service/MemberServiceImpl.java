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

import com.synergysoft.bonvoyage.member.model.dao.MemberDao;
import com.synergysoft.bonvoyage.member.model.dto.Member;

@Service("memberService")
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDao memberDao;
	
	@Override
	// 일반 로그인
	public Member selectLogin(String memId) {
		return memberDao.selectLogin(memId);
	}
	
//	@Override
//	// 카카오 로그인
//	public int selectKakaoLogin(String access_Token) {
//		HashMap<String, Object> memberInfo = new HashMap<String, Object>();
//		String reqURL = "https://kapi.kakao.com/v2/user/me";
//		
//		try {
//			URL url = new URL(reqURL);
//			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//			conn.setRequestMethod("GET");
//			conn.setRequestProperty("Authorization", "Bearer " + access_Token);
//			int responseCode = conn.getResponseCode();
//			System.out.println("responseCode : " + responseCode);
//			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
//			String line = "";
//			String result = "";
//			while ((line = br.readLine()) != null) {
//				result += line;
//			}
//			System.out.println("response body : " + result);
//			JsonParser parser = new JsonParser();
//			JsonElement element = parser.parse(result);
//			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
//			JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
//			String nickname = properties.getAsJsonObject().get("nickname").getAsString();
//			String email = kakao_account.getAsJsonObject().get("email").getAsString();
//			userInfo.put("nickname", nickname);
//			userInfo.put("email", email);
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//		Member result = memberDao.selectKakaoLogin(memberInfo);
//		// 위 코드는 먼저 정보가 저장되있는지 확인하는 코드.
//		System.out.println("S:" + result);
//		if(result==null) {
//		// result가 null이면 정보가 저장이 안되있는거므로 정보를 저장.
//			memberDao.insertKakao(memberInfo);
//			// 위 코드가 정보를 저장하기 위해 Repository로 보내는 코드임.
//			return memberDao.insertKakao(memberInfo);
//			// 위 코드는 정보 저장 후 컨트롤러에 정보를 보내는 코드임.
//			//  result를 리턴으로 보내면 null이 리턴되므로 위 코드를 사용.
//		} else {
//			return result;
//			// 정보가 이미 있기 때문에 result를 리턴함.
//		}
//	}
	
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
	public ArrayList<Member> selectMember() {
		return memberDao.selectMember();
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
