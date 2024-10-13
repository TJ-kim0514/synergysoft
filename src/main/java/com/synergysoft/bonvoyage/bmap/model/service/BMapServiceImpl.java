package com.synergysoft.bonvoyage.bmap.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.synergysoft.bonvoyage.bmap.model.dao.BMapDao;

@Service("bmapService")
public class BMapServiceImpl {

	@Autowired
	private BMapDao bmapDao;
}
