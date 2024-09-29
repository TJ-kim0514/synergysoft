package com.synergysoft.bonvoyage.member.model.service;

import java.util.ArrayList;

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
