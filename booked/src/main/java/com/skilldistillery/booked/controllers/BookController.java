package com.skilldistillery.booked.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.booked.data.BookDAO;
import com.skilldistillery.booked.data.ShelfBookDAO;
import com.skilldistillery.booked.entities.User;


@Controller
public class BookController {
	
	@Autowired
	private BookDAO bookdao;
	@Autowired
	private ShelfBookDAO sbdao;
	
	@RequestMapping(path = "viewBook.do", method = RequestMethod.GET)
	public String viewBook(int id, HttpSession session) {
		session.setAttribute("book", bookdao.findBookById(id));
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
	
	@RequestMapping(path = "search.do", method = RequestMethod.GET)
	public String searchLibrary(String search, HttpSession session) {
		session.setAttribute("allBooks", sbdao.findShelfBooksByKeyword(search));
		return "library";
	}
	
}
