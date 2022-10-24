package com.skilldistillery.booked.data;

import com.skilldistillery.booked.entities.Book;
import com.skilldistillery.booked.entities.Rating;
import com.skilldistillery.booked.entities.User;

public interface RatingDAO {
	Rating getAverageRating(int bid);
	Rating createRating(Rating rating);
	Rating getUserRating(User uid, Book bid);
	Rating updateRating(Rating rating);
}
