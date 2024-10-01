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
	// �Ϲ� �α���
	public Member selectLogin(String memId) {
		return memberDao.selectLogin(memId);
	}
	
//	@Override
//	// īī�� �α���
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
//		// �� �ڵ�� ���� ������ ������ִ��� Ȯ���ϴ� �ڵ�.
//		System.out.println("S:" + result);
//		if(result==null) {
//		// result�� null�̸� ������ ������ �ȵ��ִ°ŹǷ� ������ ����.
//			memberDao.insertKakao(memberInfo);
//			// �� �ڵ尡 ������ �����ϱ� ���� Repository�� ������ �ڵ���.
//			return memberDao.insertKakao(memberInfo);
//			// �� �ڵ�� ���� ���� �� ��Ʈ�ѷ��� ������ ������ �ڵ���.
//			//  result�� �������� ������ null�� ���ϵǹǷ� �� �ڵ带 ���.
//		} else {
//			return result;
//			// ������ �̹� �ֱ� ������ result�� ������.
//		}
//	}
	
	@Override
	// �Ҽ� �α���
	public Member selectSocialLogin(String memId) {
		return memberDao.selectSocialLogin(memId);
	}
	
	@Override
	// ���̵� �ߺ� �˻�
	public int selectCheckId(String memId) {
		return memberDao.selectCheckId(memId);
	}

	@Override
	// ���̵� ã��
	public Member selectIDSearch(String memPhone) {
		return memberDao.selectIDSearch(memPhone);
	}

	@Override
	// ��й�ȣ ã��
	public Member selectPWSearch(String memId) {
		return memberDao.selectPWSearch(memId);
	}

	@Override
	// �� ���� ��ȸ
	public Member selectMyinfo(String memId) {
		return memberDao.selectMyinfo(memId);
	}

	@Override
	// ������ : ȸ�� ��� ��ȸ
	public ArrayList<Member> selectMember() {
		return memberDao.selectMember();
	}

	@Override
	// ������ : ȸ�� �� ��ȸ
	public Member selectMemberDetail(String memId) {
		return memberDao.selectMemberDetail(memId);
	}

	@Override
	// �Ϲ� ȸ������
	public int insertMember(Member member) {
		return memberDao.insertMember(member);
	}

	@Override
	// �Ҽ� ȸ������
	public int insertSocialMember(Member member) {
		return memberDao.insertSocialMember(member);
	}

	@Override
	// �� ���� ����
	public int updateMyinfo(Member member) {
		return memberDao.updateMyinfo(member);
	}

	@Override
	// ȸ�� Ż��
	public int updateLeft(String memId) {
		return memberDao.updateLeft(memId);
	}

	@Override
	// ������ : ȸ�� ���� ����
	public int updateMember(Member member) {
		return memberDao.updateMember(member);
	}

	@Override
	// ������ : ȸ�� ���� ��ġ
	public int updateMemberAccount(String memId) {
		return memberDao.updateMemberAccount(memId);
	}

	@Override
	// ������ : ȸ�� ������ �ο�
	public int updateMemberAdmin(String memId) {
		return memberDao.updateMemberAdmin(memId);
	}

}
