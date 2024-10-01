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
	// sql 템플릿 생성
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	// 공지사항 메인페이지 공지사항 출력
	public ArrayList<Notice> selectAllNotice(Paging paging){
		List<Notice> list = sqlSessionTemplate.selectList("noticeMapper.selectAllNotice", paging);
		return (ArrayList<Notice>)list;
	}
	// 공지사항 등록
	public int insertNotice(Notice notice) {
		return sqlSessionTemplate.insert("noticeMapper.insertNotice",notice);
	}
	// 공지사항 상세보기
	public Notice selectDetailNotice(String noticeId) {
		return sqlSessionTemplate.selectOne("noticeMapper.selectDetailNotice",noticeId);
	}
	
	// 페이징용 공지사항 리스트 불러오기
	public int selectListCount() {
		return sqlSessionTemplate.selectOne("noticeMapper.selectListCount");
	}
	// 공지사항 수정
	public int updateNotice(Notice notice) {
		return sqlSessionTemplate.update("noticeMapper.updateNotice",notice);
	}
	// 공지사항 삭제
	public int deleteNotice(Notice notice) {
		return sqlSessionTemplate.update("noticeMapper.deleteNotice",notice);
	}
	
	
}
