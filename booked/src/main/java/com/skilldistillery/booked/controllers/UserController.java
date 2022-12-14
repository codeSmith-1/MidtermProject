package com.skilldistillery.booked.controllers;

import java.util.ArrayList;
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

import com.skilldistillery.booked.entities.Genre;
import com.skilldistillery.booked.entities.Checkout;
import com.skilldistillery.booked.entities.User;

@Controller
public class UserController {

	@Autowired
	private UserDAO dao;
	@Autowired
	private BookDAO bookdao;
	@Autowired
	private CheckoutDAO cdao;

	@RequestMapping(path = { "/", "home.do" })
	public String home(HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if (user != null) {
			model.addAttribute("allBooks", bookdao.findAllBooks());
			return "library";
		}
		return "login";
	}

	@RequestMapping(path = "account.do", method = RequestMethod.GET)
	public String getAccount(HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "login";
		}
		model.addAttribute("favs", user.getFavBooks());
		user = dao.findUserById(user.getId());
		if (user.getGenres().size() > 0) {
			int genreId = user.getGenres().get(0).getId();
			List<Book> books = bookdao.booksInGenre(genreId);
			model.addAttribute("booksInGenre", books);
		}
		model.addAttribute("checkouts", cdao.userHasApprovedCheckouts(user.getId()));
		return "account";
	}
	
	@RequestMapping(path = "editAccountForm.do", method = RequestMethod.GET)
	public String editAccount(HttpSession session) {
		if(session.getAttribute("user") !=null) {
			return "editAccountForm";
		}
		return "login";
	}
	
	@RequestMapping(path = "editAccount.do", method = RequestMethod.POST)
	public String editAccount(HttpSession session, Model model, User user, int id) {
		user = dao.updateUser(id, user);
		if(user != null) {
			session.setAttribute("user", user);
			return "redirect:account.do";
		}
		return "login";
	}
	
	@RequestMapping(path = "createAccount.do", method = RequestMethod.GET)
	public String createAccount(Model model) {
		model.addAttribute("genres", bookdao.findAllGenres());
		return "accountCreate";
	}
	
	@RequestMapping(path = "createAccount.do", method = RequestMethod.POST)
	public String createAccount(Integer genreId, User user, Model model) {
		Genre favGenre = bookdao.findGenreById(genreId);
		List<Genre> genres = new ArrayList<>();
		genres.add(favGenre);
		user.setGenres(genres);
		try {
			user = dao.createUser(user);
			model.addAttribute("user", user);
		} catch (Exception e) {
			model.addAttribute("user", user);
			e.printStackTrace();
			if(e.getMessage().equals("Username already exists")) {
				model.addAttribute("Error", "Username already exists");
			}
			return "accountCreate";
		}
		return "login";
	}
	
	@RequestMapping(path = "updatePassword.do", method = RequestMethod.GET)
	public String updatePassword(HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		boolean recruiter = false;
		if((user) != null) {
			if (user.getPassword().equals("recruiter")) {
				recruiter = true;
				model.addAttribute("recruiter", recruiter);
			}
			return "passwordChange";
		}
		return "login";
	}
	
	@RequestMapping(path = "updatePassword.do", method = RequestMethod.POST)
	public String updatePassword(String newPassword, HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
	
		dao.updateUserPassword(user.getId(), newPassword);
		
		return "login";
	}
	
	@RequestMapping(path = "delete.do", method = RequestMethod.POST)
	public String userInactive(HttpSession session, Model model) {
		User user = (User)session.getAttribute("user");
		if(user != null) {
			model.addAttribute("inactive", dao.removeUser(user.getId()));
			session.removeAttribute("user");
		}
		return "login";
	}
	
}
