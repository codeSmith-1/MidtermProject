package com.skilldistillery.booked.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.booked.data.UserDAO;
import com.skilldistillery.booked.entities.User;

@Controller
//@SessionAttributes("user")
public class LoginController {

	@Autowired
	private UserDAO dao;

	@RequestMapping(path = "login.do", method = RequestMethod.GET)
	public String loginView(HttpSession session) {
		if (session.getAttribute("loggedIn") != null) {
			return "account";
		}
		return "login";
	}

	@RequestMapping(path = "login.do", method = RequestMethod.POST)
	public String loginUser(User user, HttpSession session) {
		user = dao.getUserByUserNameAndPassword(user.getUsername(), user.getPassword());
		
		if (user == null) {
			boolean invalid = true;
			session.setAttribute("invalid", invalid);
			return "login";
		} else {
			session.setAttribute("loggedIn", user);
			return "account";
		}
	}

	@RequestMapping(path = "logout.do", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.removeAttribute("loggedIn");
		return "index";
	}

}