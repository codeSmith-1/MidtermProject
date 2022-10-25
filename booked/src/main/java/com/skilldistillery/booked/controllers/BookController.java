package com.skilldistillery.booked.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.booked.data.BookDAO;
import com.skilldistillery.booked.data.CommentDAO;
import com.skilldistillery.booked.data.ShelfBookDAO;
import com.skilldistillery.booked.entities.Book;
import com.skilldistillery.booked.entities.Comment;
import com.skilldistillery.booked.entities.ShelfBook;
import com.skilldistillery.booked.entities.User;


@Controller
public class BookController {
	
	@Autowired
	private BookDAO bookdao;
	@Autowired
	private ShelfBookDAO sbdao;
	@Autowired
	private CommentDAO cdao;
	
	@RequestMapping(path = "viewBook.do", method = RequestMethod.GET)
	public String viewBook(int id, HttpSession session) {
		Book book = bookdao.findBookById(id);
	
		List<Comment> comments = cdao.findCommentsByBookId(id);
		book.setComments(comments);
		session.setAttribute("book", book);
		// in jsp access list comments
		session.setAttribute("books", sbdao.findShelfBooksByBookId(id));
		return "viewShelfBook";
	}
	
	@RequestMapping(path = "viewShelfBook.do", method = RequestMethod.GET)
	public String viewShelfBook(int id, HttpSession session) {
		ShelfBook sb = sbdao.findShelfBookById(id);
		session.setAttribute("sb", sb);
		// in jsp access list comments
		return "viewShelfBook";
	}

	@RequestMapping(path = "myBookshelf.do", method = RequestMethod.GET)
	public String viewBookshelf(HttpSession session, Model model) {
		if (session.getAttribute("user") != null) {
			User user = (User) session.getAttribute("user");
			model.addAttribute("books", sbdao.findShelfBooksByOwnerId(user.getId()));
			model.addAttribute("favs", user.getFavBooks());
			
			return "bookshelf";
		}
		return "login";
	}
	
	@RequestMapping(path = "library.do", method = RequestMethod.GET)
	public String viewLibrary(HttpSession session) {
		session.setAttribute("allBooks", bookdao.findAllBooks());
		return "library";
	}
	
	@RequestMapping(path = "search.do", method = RequestMethod.GET)
	public String searchLibrary(String search, HttpSession session) {
		session.setAttribute("allBooks", bookdao.findBooksByKeyword(search));
		return "library";
	}
	
	@RequestMapping(path = "addShelfBook.do", method = RequestMethod.GET)
	public String addShelfBook(Integer id, HttpSession session, Model model) {
		if (id != null) {
			model.addAttribute("book", bookdao.findBookById(id));
		}
		model.addAttribute("conditions", bookdao.findAllConditions());
		return "shelfBookCreate";
	}
	
	@RequestMapping(path = "addShelfBook.do", method = RequestMethod.POST)
	public String addShelfBook(Integer bookId, ShelfBook sBook, HttpSession session, Model model) {
		
		sBook.setBook(bookdao.findBookById(bookId));
		sBook.setUser((User) session.getAttribute("user"));
		sbdao.createShelfBook(sBook);
		if (session.getAttribute("user") != null) {
			User user = (User) session.getAttribute("user");
			model.addAttribute("books", sbdao.findShelfBooksByOwnerId(user.getId()));
			model.addAttribute("favs", user.getFavBooks());
		}
		return "bookshelf";
	}
	
	@RequestMapping(path = "deleteShelfBook.do", method = RequestMethod.GET)
	public String deleteShelfBook(Integer id, HttpSession session, Model model) {
		sbdao.removeShelfBook(id);
		if (session.getAttribute("user") != null) {
			User user = (User) session.getAttribute("user");
			model.addAttribute("books", sbdao.findShelfBooksByOwnerId(user.getId()));
			model.addAttribute("favs", user.getFavBooks());
		}
		return "bookshelf";
	}
	
}
