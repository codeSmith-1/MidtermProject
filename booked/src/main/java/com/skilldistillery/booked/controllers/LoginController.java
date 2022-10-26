package com.skilldistillery.booked.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.booked.data.UserDAO;
import com.skilldistillery.booked.entities.User;

@Controller
public class LoginController {

	@Autowired
	private UserDAO dao;
	@RequestMapping(path = "login.do", method = RequestMethod.GET)
	public String loginView(HttpSession session) {
		if (session.getAttribute("user") != null) {
			return "account";
		} 
		return "login";
	}

	@RequestMapping(path = "login.do", method = RequestMethod.POST)
	public String loginUser(String username, String password, HttpSession session) {
		User user;
		try {
			user = dao.getUserByUserNameAndPassword(username, password);
		} catch (Exception e) {
			e.printStackTrace();
			boolean invalid = true;
			session.setAttribute("invalid", invalid);
			return "login";
		}
		if (user != null) {
			session.setAttribute("user", user);
		}
		return "account";
	}


	@RequestMapping(path = "logout.do", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.removeAttribute("user");
		return "login";
	}

}
