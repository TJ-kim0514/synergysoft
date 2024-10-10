package com.synergysoft.bonvoyage.comment.model.service;

import java.util.ArrayList;

import com.synergysoft.bonvoyage.comment.model.dto.Comment;

public interface CommentService {

	int insertRouteComment(Comment comment);

	ArrayList<Comment> selectComment(String routeBoardId);

}
