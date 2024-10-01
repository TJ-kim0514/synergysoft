package com.synergysoft.bonvoyage.notice.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.synergysoft.bonvoyage.common.Paging;
import com.synergysoft.bonvoyage.notice.model.dao.NoticeDao;
import com.synergysoft.bonvoyage.notice.model.dto.Notice;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService{
	// dao 생성 
	@Autowired
	private NoticeDao noticeDao;
	
	// 공지사항 메인화면 전체화면 출력용 서비스
	@Override
	public ArrayList<Notice> selectAllNotice(Paging paging) {
		return noticeDao.selectAllNotice(paging);
	}
	
	// 공지사항 등록
	@Override
	public int insertNotice(Notice notice) {
		return noticeDao.insertNotice(notice);
	}
	
	// 공지사항 상세보기
	@Override
	public Notice selectDetailNotice(String noticeId) {
		return noticeDao.selectDetailNotice(noticeId);
	}
	
	// 페이징용 공지사항 갯수확인
	@Override
	public int selectListCount() {
		return noticeDao.selectListCount();
	}

}
