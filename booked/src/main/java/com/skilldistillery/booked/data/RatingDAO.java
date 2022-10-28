package com.skilldistillery.booked.data;

import com.skilldistillery.booked.entities.Book;
import com.skilldistillery.booked.entities.Rating;
import com.skilldistillery.booked.entities.User;

public interface RatingDAO {
	
	Double getAverageRating(int bid);
	boolean createRating(int bid, int ratingValue, int uid);
	Rating getUserRating(User uid, Book bid);
	Rating updateRating(Rating rating);
	
}
