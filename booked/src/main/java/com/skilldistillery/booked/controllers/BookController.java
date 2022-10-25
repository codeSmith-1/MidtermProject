package com.skilldistillery.booked.controllers;

import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.booked.data.BookDAO;
import com.skilldistillery.booked.data.ShelfBookDAO;
import com.skilldistillery.booked.entities.Book;
import com.skilldistillery.booked.entities.Comment;
import com.skilldistillery.booked.entities.User;


@Controller
public class BookController {
	
	@Autowired
	private BookDAO bookdao;
	@Autowired
	private ShelfBookDAO sbdao;
	
	@RequestMapping(path = "viewBook.do", method = RequestMethod.GET)
	public String viewBook(int id, HttpSession session) {
		Book book = bookdao.findBookById(id);
		List<Comment> comments = book.getComments();
		comments = comments.stream().sorted(Comparator.comparing(Comment::getCommentDate)).collect(Collectors.toList());
		book.setComments(comments);
		session.setAttribute("book", book);
		
		// in jsp access list comments
		session.setAttribute("books", sbdao.findShelfBooksByBookId(id));
		return "bookView";
	}

	@RequestMapping(path = "myBookshelf.do", method = RequestMethod.GET)
	public String viewBookshelf(HttpSession session) {
		if (session.getAttribute("user") != null) {
			User user = (User) session.getAttribute("user");
			session.setAttribute("books", user.getShelfBooks());
			session.setAttribute("favs", user.getFavBooks());
			
			return "bookshelf";
		}
		return "login";
	}
	
	@RequestMapping(path = "library.do", method = RequestMethod.GET)
	public String viewLibrary(HttpSession session) {
		session.setAttribute("allBooks", sbdao.findAllShelfBooks());
		return "library";
	}
	
}
