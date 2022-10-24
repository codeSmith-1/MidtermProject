package com.skilldistillery.booked.data;

import java.util.List;

import com.skilldistillery.booked.entities.Book;
import com.skilldistillery.booked.entities.Comment;
import com.skilldistillery.booked.entities.Rating;
import com.skilldistillery.booked.entities.ShelfBook;

public interface BookDAO {

	List<Rating> getRatingsByBookId(int bId);
	List<Comment> getCommentsByBookId(int bId);
	Book findBookById(int id);

}
