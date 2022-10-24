package com.skilldistillery.booked.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.booked.entities.User;


@Controller
public class BookController {

	@RequestMapping(path = "myBookshelf.do", method = RequestMethod.GET)
	public String viewBookshelf(HttpSession session) {
		if (session.getAttribute("loggedIn") != null) {
			User user = (User) session.getAttribute("user");
			session.setAttribute("books", user.getShelfBooks());
			session.setAttribute("favs", user.getFavBooks());
			return "bookshelf";
		}
		return "login";
	}	
}
