package com.synergysoft.bonvoyage.comment.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.synergysoft.bonvoyage.comment.model.dao.CommentDao;
import com.synergysoft.bonvoyage.comment.model.dto.Comment;

@Service("commentService")
public 	class CommentServiceImpl implements CommentService {

	@Autowired
	private CommentDao commentDao;
	
	@Override
	public int insertRouteComment(Comment comment) {
		return commentDao.insertRouteComment(comment);
	}

	@Override
	public ArrayList<Comment> selectComment(String routeBoardId) {
		return commentDao.selectComment(routeBoardId);
	}

}
