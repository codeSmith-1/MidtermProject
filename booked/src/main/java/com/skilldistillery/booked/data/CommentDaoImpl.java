package com.skilldistillery.booked.data;

import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.booked.entities.Book;
import com.skilldistillery.booked.entities.Comment;
import com.skilldistillery.booked.entities.User;
@Service
@Transactional
public class CommentDaoImpl implements CommentDAO {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public Comment findCommentById(int cid) {
		return em.find(Comment.class, cid);
	}

//	@Override
//	public List<Comment> findCommentByUserIdAndBookId(int uid, int bid) {
//		String sql = "SELECT c FROM Comment WHERE c.book.id = :bid AND c.user.id = :uid";
//		List<Comment> comments = em.createQuery(sql, Comment.class).setParameter("bid", bid).setParameter("uid", uid).getResultList();
//		return comments;
//	}

	@Override
	public List<Comment> findCommentsByBookId(int bid) {
		String sql = "SELECT c FROM Comment c WHERE c.book.id = :bid ORDER BY c.commentDate";
		List<Comment> comments = em.createQuery(sql, Comment.class).setParameter("bid", bid).getResultList();
//		return comments.stream().sorted(Comparator.comparing(Comment::getCommentDate)).collect(Collectors.toList());
		return comments;
	}

	@Override
	public Comment findCommentByReplyId(int rid) {
		return null;
	}

	@Override
	public List<Comment> findCommentsByUserIdAndBookId(int uid, int bid) {
		return null;
	}

	@Override
	public Comment createComment(Comment comment) {
		em.persist(comment);
		return comment;
	}

}
