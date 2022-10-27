package com.skilldistillery.booked.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.booked.data.BookDAO;
import com.skilldistillery.booked.data.CheckoutDAO;
import com.skilldistillery.booked.data.UserDAO;
import com.skilldistillery.booked.entities.Book;
import com.skilldistillery.booked.entities.Checkout;
import com.skilldistillery.booked.entities.User;

@Controller
public class LoginController {

	@Autowired
	private UserDAO dao;
	@Autowired
	private BookDAO bookdao;
	
	@Autowired
	private CheckoutDAO cdao;
	
	@RequestMapping(path = "login.do", method = RequestMethod.GET)
	public String loginView(HttpSession session, Model model) {
		if (session.getAttribute("user") != null) {
			User user = (User) session.getAttribute("user");
			model.addAttribute("favs", user.getFavBooks());
			user = dao.findUserById(user.getId());
			if (user.getGenres().size() > 0) {
				int genreId = user.getGenres().get(0).getId();
				List<Book> books = bookdao.booksInGenre(genreId);
				model.addAttribute("booksInGenre", books);
			}
			return "account";
		} 
		return "login";
	}

	@RequestMapping(path = "login.do", method = RequestMethod.POST)
	public String loginUser(String username, String password, HttpSession session, Model model) {
		User user = new User();
		try {
			user = dao.getUserByUserNameAndPassword(username, password);
			if (!user.getEnabled()) {
				throw new Exception("Disabled account");
			}
		} catch (Exception e) {
			model.addAttribute("invalid", true);
			return "login";
		}
		if (user != null) {
			session.setAttribute("user", user);
		}
		List<Checkout> checkouts = cdao.userHasApprovedCheckouts(user.getId());
		if (checkouts != null) {
			model.addAttribute("checkouts", checkouts);
		}
		List<Book> favs = user.getFavBooks();
		if (favs != null) {
			model.addAttribute("favs", favs);
		}
		user = dao.findUserById(user.getId());
		if (user.getGenres().size() > 0) {
			int genreId = user.getGenres().get(0).getId();
			List<Book> books = bookdao.booksInGenre(genreId);
			model.addAttribute("booksInGenre", books);
		}
		return "account";
	}


	@RequestMapping(path = "logout.do", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.removeAttribute("user");
		return "login";
	}

}
