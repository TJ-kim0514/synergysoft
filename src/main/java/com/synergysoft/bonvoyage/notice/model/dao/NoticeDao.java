package com.synergysoft.bonvoyage.notice.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.synergysoft.bonvoyage.common.Paging;
import com.synergysoft.bonvoyage.notice.model.dto.Notice;

@Repository("noticeDao")
public class NoticeDao {
	// sql ���ø� ����
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	// �������� ���������� �������� ���
	public ArrayList<Notice> selectAllNotice(Paging paging){
		List<Notice> list = sqlSessionTemplate.selectList("noticeMapper.selectAllNotice", paging);
		return (ArrayList<Notice>)list;
	}
	// �������� ���
	public int insertNotice(Notice notice) {
		return sqlSessionTemplate.insert("noticeMapper.insertNotice",notice);
	}
	// �������� �󼼺���
	public Notice selectDetailNotice(String noticeId) {
		return sqlSessionTemplate.selectOne("noticeMapper.selectDetailNotice",noticeId);
	}
	
	// ����¡�� �������� ����Ʈ �ҷ�����
	public int selectListCount() {
		return sqlSessionTemplate.selectOne("noticeMapper.selectListCount");
	}
	// �������� ����
	public int updateNotice(Notice notice) {
		return sqlSessionTemplate.update("noticeMapper.updateNotice",notice);
	}
	// �������� ����
	public int deleteNotice(Notice notice) {
		return sqlSessionTemplate.update("noticeMapper.deleteNotice",notice);
	}
	
	
}
