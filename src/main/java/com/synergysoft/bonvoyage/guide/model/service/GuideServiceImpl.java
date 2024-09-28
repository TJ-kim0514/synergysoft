package com.synergysoft.bonvoyage.guide.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.synergysoft.bonvoyage.guide.model.dao.GuideDao;

@Service("guideService")
public class GuideServiceImpl implements GuideService{
	
	@Autowired
	private GuideDao guideDao;
	
	

}
