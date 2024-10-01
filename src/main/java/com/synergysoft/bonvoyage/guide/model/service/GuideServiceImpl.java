package com.synergysoft.bonvoyage.guide.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.synergysoft.bonvoyage.guide.model.dao.GuideDao;
import com.synergysoft.bonvoyage.guide.model.dto.Guide;


@Service("guideService")
public class GuideServiceImpl implements GuideService{
	
	// ���̺� ��α� ����ȭ�� ��üȭ�� ��¿� ����
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
