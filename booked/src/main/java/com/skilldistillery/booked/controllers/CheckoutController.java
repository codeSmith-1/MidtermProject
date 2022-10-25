package com.skilldistillery.booked.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.config.ScheduledTasksBeanDefinitionParser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.booked.data.CheckoutDAO;
import com.skilldistillery.booked.entities.Checkout;
import com.skilldistillery.booked.entities.ShelfBook;
import com.skilldistillery.booked.entities.User;

@Controller
public class CheckoutController {
	
	@Autowired
	CheckoutDAO cdao;
	
	@RequestMapping(path = "checkout.do", method = RequestMethod.GET)
	public String postComment(HttpSession session, String comment) {
		User u = (User) session.getAttribute("user");
		ShelfBook sb = (ShelfBook) session.getAttribute("book");
		Checkout chkout = new Checkout();
		chkout.setRequestMessage(comment);
		chkout.setUser(u);
		chkout.setShelfBook(sb);
		cdao.createCheckout(chkout);
		return "redirect:viewBook.do";
	}

	
	
	
}
