package com.skilldistillery.booked.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.booked.entities.Book;
import com.skilldistillery.booked.entities.Comment;
import com.skilldistillery.booked.entities.Rating;
import com.skilldistillery.booked.entities.ShelfBook;

@Service
@Transactional
public class BookDaoImpl implements BookDAO {
	
	@PersistenceContext
	private EntityManager em;
	 
	@Override
	public List<Rating> getRatingsByBookId(int bId) {
		String query = "SELECT r FROM Rating r WHERE bookId = :bId";
		List<Rating> ratings = em.createQuery(query, Rating.class).setParameter("bId", bId).getResultList();
		return ratings;
	 
	}

	@Override
	public List<Comment> getCommentsByBookId(int bId) {
		String query = "SELECT c FROM Comment c WHERE bookId = :bId";
		List<Comment> comments = em.createQuery(query, Comment.class).setParameter("bId", bId).getResultList();
		return comments;
	}

	@Override
	public Book findBookById(int id) {
		return em.find(Book.class, id);
	}

}
