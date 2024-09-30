package com.synergysoft.bonvoyage.guide.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.synergysoft.bonvoyage.guide.model.dto.Guide;

@Repository("guideDao")
public class GuideDao {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	public ArrayList<Guide> selectAllGuide(){
		List<Guide> list = sqlSessionTemplate.selectList("guideMapper.selectAllGuide");
		return (ArrayList<Guide>)list;
		
	}

}//EndGuidDao
