package com.skilldistillery.booked.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.booked.data.UserDAO;
import com.skilldistillery.booked.entities.Address;
import com.skilldistillery.booked.entities.User;
import com.skilldistillery.booked.entities.userAddressDTO;

@Controller
public class UserController {

	@Autowired
	private UserDAO dao;

	@RequestMapping(path = { "/", "home.do" })
	public String home(Model model) {
		model.addAttribute("SMOKETEST", dao.findUserById(1));
		return "login";
	}

	@RequestMapping(path = "account.do", method = RequestMethod.GET)
	public String getAccount(HttpSession session, Integer id) {
		// if logic to check if user in session
		return "account";
	}
	@RequestMapping(path = "editAccountForm.do", method = RequestMethod.GET)
	public String editAccount(HttpSession session) {
		User user = (User) session.getAttribute("user");
		if((user) != null) {
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
	
	
}
