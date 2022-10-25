package com.skilldistillery.booked.data;

import java.util.List;

import com.skilldistillery.booked.entities.Book;
import com.skilldistillery.booked.entities.BookCondition;
import com.skilldistillery.booked.entities.Comment;
import com.skilldistillery.booked.entities.Rating;

public interface BookDAO {

	List<Rating> getRatingsByBookId(int bId);
	List<Comment> getCommentsByBookId(int bId);
	Book findBookById(int id);
	List<Book> findAllBooks();
	List<Book> findBooksByKeyword(String keyword);
	Book createBook(Book book);
	List<BookCondition> findAllConditions();
	
}
