package com.skilldistillery.booked.data;

import java.util.List;

import com.skilldistillery.booked.entities.Comment;

public interface CommentDAO {
	
	Comment findCommentById(int cid);
	List<Comment> findCommentsByUserIdAndBookId(int uid, int bid);
	List<Comment> findCommentsByBookId(int bid);
	Comment findCommentByReplyId(int rid);
	Comment createComment(Comment comment);
	
}
