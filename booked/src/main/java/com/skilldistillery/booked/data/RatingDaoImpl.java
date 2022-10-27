package com.skilldistillery.booked.data;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.booked.entities.Book;
import com.skilldistillery.booked.entities.Rating;
import com.skilldistillery.booked.entities.RatingId;
import com.skilldistillery.booked.entities.User;

@Service
@Transactional
public class RatingDaoImpl implements RatingDAO {

	@PersistenceContext
	private EntityManager em;

	@Override
	public Rating getUserRating(User user, Book book) {
		String sql = "SELECT r FROM Rating r WHERE user.id = :uid AND book.id = :bid";
		Rating rating = null;
		try {
			rating = em.createQuery(sql, Rating.class).setParameter("uid", user.getId())
					.setParameter("bid", book.getId())
					.getSingleResult();
		} catch (Exception e) {
			System.err.println("Rating not found.");
		}
		return rating;
	}

	@Override
	public Rating getAverageRating(int bid) {
		String sql = "SELECT AVG(r) FROM Rating r WHERE book.id = :bid";
		Rating avg = em.createQuery(sql, Rating.class).setParameter("bid", bid).getSingleResult();
		return avg;
	}

	@Override
	public boolean createRating(int bid, int ratingValue, int uid) {
		Book book = em.find(Book.class, bid);
		User user = em.find(User.class, uid);
		if (user != null && book != null) {
			RatingId id = new RatingId(bid, uid);
			Rating rating = new Rating();
			rating.setId(id);
			rating.setRating(ratingValue);
			rating.setBook(book);
			rating.setUser(user);
			em.persist(rating);
			return true;
		} else {
			return false;
		}
	}

	@Override
	public Rating updateRating(Rating rating) {
		Rating userRating = em.find(Rating.class, rating.getId());
		em.remove(userRating);
		em.persist(rating);
		return userRating;
	}

}
