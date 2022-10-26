package com.skilldistillery.booked.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.booked.data.BookDAO;
import com.skilldistillery.booked.data.UserDAO;
import com.skilldistillery.booked.entities.Book;
import com.skilldistillery.booked.entities.User;

@Controller
public class UserController {

	@Autowired
	private UserDAO dao;
	@Autowired
	private BookDAO bookdao;

	@RequestMapping(path = { "/", "home.do" })
	public String home() {
//		HttpSession session, Model model
//		User user = (User) session.getAttribute("user");
//		model.addAttribute("user", dao.findUserById());
//		if (user != null) {
//			model.addAttribute("allBooks", bookdao.findAllBooks());
//			return "library";
//		}
		return "login";
	}

	@RequestMapping(path = "account.do", method = RequestMethod.GET)
	public String getAccount(HttpSession session, Integer id, Model model) {
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
		return "account";
	}
	
	@RequestMapping(path = "editAccountForm.do", method = RequestMethod.GET)
	public String editAccount(HttpSession session) {
//		User user = (User) session.getAttribute("user");
//		if((user) != null) {
		if(session.getAttribute("user") !=null) {
			
//			model.addAttribute("updated", dao.updateUser(id, user));
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
	public String createAccount() {
		return "accountCreate";
	}
	
	@RequestMapping(path = "createAccount.do", method = RequestMethod.POST)
	public String createAccount(User user, Model model) {
		try {
			dao.createUser(user);
			model.addAttribute("user", user);
		} catch (Exception e) {
			model.addAttribute("user", user);
			e.printStackTrace();
			if(e.getMessage().equals("Username already exists")) {
				model.addAttribute("Error", "Username already exists");
			}
			return "accountCreate";
		}
//		Address addr = dao.createAddress(address);
//		dao.createUser(user, addr);
		return "login";
	}
	
	@RequestMapping(path = "updatePassword.do", method = RequestMethod.GET)
	public String updatePassword(HttpSession session) {
		User user = (User) session.getAttribute("user");
		if((user) != null) {
			return "passwordChange";
		}
		return "login";
	}
	
	@RequestMapping(path = "updatePassword.do", method = RequestMethod.POST)
	public String updatePassword(User user, String newPassword, Model model) {
		user = dao.getUserByUserNameAndPassword(user.getUsername(), user.getPassword());
		dao.updateUserPassword(user.getId(), newPassword);
		
		return "login";
	}
	
	
	
}
