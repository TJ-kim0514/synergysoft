package com.synergysoft.bonvoyage.guide.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.synergysoft.bonvoyage.guide.model.dao.GuideDao;
import com.synergysoft.bonvoyage.guide.model.dto.Guide;


@Service("guideService")
public class GuideServiceImpl implements GuideService{
	
	// 가이브 블로그 메인화면 전체화면 출력용 서비스
	@Autowired
	private GuideDao guideDao;

	@Override
	public ArrayList<Guide> selectAllGuide() {
		return guideDao.selectAllGuide();
	}

	@Override
	public int insertGuide(Guide guide) {
		return guideDao.insertGuide(guide);
	}

	@Override
	public Guide selectGuide(Guide guidepostId) {
		return guideDao.selectGuide(guidepostId);
	}






}
