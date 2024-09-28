package com.synergysoft.bonvoyage.member.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.synergysoft.bonvoyage.member.model.dto.Member;

@Repository("memberDao")
public class MemberDao {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	// �Ϲ� �α���
	public Member selectLogin(String memId) {
		return sqlSessionTemplate.selectOne("memberMapper.selectLogin", memId);
	}
	
	// �Ҽ� �α���
	public Member selectSocialLogin(String memId) {
		return sqlSessionTemplate.selectOne("memberMapper.selectSocialLogin", memId);
	}
	
	// ���̵� �ߺ� �˻�
	public int selectCheckId(String memId) {
		return sqlSessionTemplate.selectOne("memberMapper.selectCheckId", memId);
	}
	
	// ���̵� ã��
	public Member selectIDSearch(String memPhone) {
		return sqlSessionTemplate.selectOne("memberMapper.selectIDSearch", memPhone);
	}
	
	// ��й�ȣ ã��
	public Member selectPWSearch(String memId) {
		return sqlSessionTemplate.selectOne("memberMapper.selectPWSearch", memId);
	}
	
	// �� ���� ��ȸ
	public Member selectMyinfo(String memId) {
		return sqlSessionTemplate.selectOne("memberMapper.selectMyinfo", memId);
	}
	
	// ������ : ȸ�� ��� ��ȸ
	public ArrayList<Member> selectMember(){
		List<Member> list = sqlSessionTemplate.selectList("memberMapper.selectMember");
		return (ArrayList<Member>) list;
	}
	
	// ������ : ȸ�� �� ��ȸ
	public Member selectMemberDetail(String memId) {
		return sqlSessionTemplate.selectOne("memberMapper.selectMemberDetail", memId);
	}
	
	// �Ϲ� ȸ������
	public int insertMember(Member member) {
		return sqlSessionTemplate.insert("memberMapper.insertMember", member);
	}
	
	// �Ҽ� ȸ������
	public int insertSocialMember(Member member) {
		return sqlSessionTemplate.insert("memberMapper.insertSocialMember", member);
	}
	
	// �� ���� ����
	public int updateMyinfo(Member member) {
		return sqlSessionTemplate.update("memberMapper.updateMyinfo", member);
	}
	
	// ȸ�� Ż��
	public int updateLeft(String memId) {
		return sqlSessionTemplate.update("memberMapper.updateLeft", memId);
	}
	
	// ������ : ȸ�� ���� ����
	public int updateMember(Member member) {
		return sqlSessionTemplate.update("memberMapper.updateMember", member);
	}
	
	// ������ : ȸ�� ���� ��ġ
	public int updateMemberAccount(String memId) {
		return sqlSessionTemplate.update("memberMapper.updateMemberAccount", memId);
	}
	
	// ������ : ȸ�� ������ �ο�
	public int updateMemberAdmin(String memId) {
		return sqlSessionTemplate.update("memberMapper.updateMemberAdmin", memId);
	}

}
