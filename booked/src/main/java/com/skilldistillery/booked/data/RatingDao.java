package com.skilldistillery.booked.data;

import com.skilldistillery.booked.entities.Book;
import com.skilldistillery.booked.entities.Rating;
import com.skilldistillery.booked.entities.User;

public interface RatingDao {
	public Rating createRating(int rating);
	public Rating getUserRating(User uid, Book bid);
}
