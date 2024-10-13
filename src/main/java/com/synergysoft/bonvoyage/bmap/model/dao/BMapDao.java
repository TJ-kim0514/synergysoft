package com.synergysoft.bonvoyage.bmap.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository("bmapDao")
public class BMapDao {

	private SqlSessionTemplate sqlSessionTemplate;
}
