package com.skilldistillery.booked.data;

import com.skilldistillery.booked.entities.Book;
import com.skilldistillery.booked.entities.Rating;
import com.skilldistillery.booked.entities.User;

public interface RatingDAO {
	public Rating getAverageRating(int bid);
	public Rating createRating(Rating rating);
	public Rating getUserRating(User uid, Book bid);
	public Rating updateRating(Rating rating);
}
