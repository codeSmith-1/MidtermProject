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
	public Rating getUserRating(User uid, Book bid) {
		String sql = "SELECT r FROM Rating WHERE user.id = :uid AND book.id = :bid";
		Rating rating = em.createQuery(sql, Rating.class).setParameter("uid", uid).setParameter("bid", bid)
				.getSingleResult();
		return rating;
	}

	@Override
	public Rating getAverageRating(int bid) {
		String sql = "SELECT AVG(r) FROM Rating r WHERE book.id = :bid";
		Rating avg = em.createQuery(sql, Rating.class).setParameter("bid", bid).getSingleResult();
		return avg;
	}

	@Override
	public boolean createRating(int bid, int uid) {
		boolean rated = false;
		Book book = em.find(Book.class, uid);
		User user = em.find(User.class, uid);
		if (user != null && book != null) {
			RatingId id = new RatingId(bid, uid);
			Rating rating = new Rating();
			rating.setId(id);
			rating.setBook(book);
			rating.setUser(user);
			em.persist(rating);
			rated = true;
		}
		return rated;
	}

	@Override
	public Rating updateRating(Rating rating) {
		Rating userRating = em.find(Rating.class, rating.getId());
		if (rating != null) {
			userRating.setRating(rating.getRating());
		}
		// will overwrite existing rating with "empty string" if none provided. Need to
		// test for " " if we want to use
//		userRating.setRatingComment(rating.getRatingComment());
		em.persist(userRating);
		return userRating;
	}

}
