package com.skilldistillery.booked.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.skilldistillery.booked.data.CheckoutDAO;
import com.skilldistillery.booked.data.ShelfBookDAO;
import com.skilldistillery.booked.entities.Checkout;
import com.skilldistillery.booked.entities.ShelfBook;
import com.skilldistillery.booked.entities.User;

@Controller
public class CheckoutController {

	@Autowired
	CheckoutDAO cdao;
	@Autowired
	ShelfBookDAO sbdao;

	@RequestMapping(path = "requestBook.do", method = RequestMethod.GET)
	public String requestBook(HttpSession session, int id, Model model) {
		ShelfBook sb = sbdao.findShelfBookById(id);
		User u = (User) session.getAttribute("user");
		if (u == null) {
			return "login";
		}
		String message = "";
		boolean bool = false;
		if (cdao.checkoutHasCheckoutRequestFromUserId(u.getId(), id)) {
			message = "You previously requested this book.";
			bool = true;
		}
		if (cdao.checkoutApprovedForUserByOwner(u.getId(), id)) {
			message = "Your rental request was approved.";
			bool = true;
		}

		model.addAttribute("sb", sb);
		model.addAttribute("checkedOut", bool);
		model.addAttribute("message", message);

		return "requestBook";
	}

	@RequestMapping(path = "checkoutBook.do", method = RequestMethod.POST)
	public String postComment(HttpSession session, @RequestParam int id, @RequestParam String comment, Model model) {
		User u = (User) session.getAttribute("user");
		if (u == null) {
			return "login";
		}
		ShelfBook sb = sbdao.findShelfBookById(id);
		model.addAttribute("sb", sb);
		Checkout chkout = new Checkout();
		chkout.setRequestMessage(comment);
		chkout.setUser(u);
		chkout.setShelfBook(sb);
		cdao.createCheckout(chkout);
		model.addAttribute("checkedOut", true);
		return "requestBook";
	}

//	@RequestMapping(path = "viewCheckouts.do", method = RequestMethod.GET)
//	public String viewCheckoutRequests(HttpSession session, Integer id, String comment, Model model) {
//		ShelfBook sb = sbdao.findShelfBookById(id); 
//		// find checkouts for book id
//		// list checkout requests
//		// assign model
//		model.addAttribute("sb", sb);
//		return "viewCheckouts";
//	}

	@RequestMapping(path = "approveCheckout.do", method = RequestMethod.POST)
	public String viewCheckoutRequests(HttpSession session, int id, Model model) {
		boolean approved = cdao.reviewCheckout(id, true);
		ShelfBook sb = cdao.findCheckoutById(id).getShelfBook();
		model.addAttribute("sb", sb);
		model.addAttribute("approved", approved);
		return "viewShelfBook";
	}

	@RequestMapping(path = "rejectCheckout.do", method = RequestMethod.POST)
	public String rejectCheckout(HttpSession session, int id, Model model) {
		ShelfBook sb = cdao.findCheckoutById(id).getShelfBook();
		model.addAttribute("sb", sb);
		cdao.reviewCheckout(id, false);
		return "viewShelfBook";
	}

	@RequestMapping(path = "returned.do", method = RequestMethod.POST)
	public String returned(HttpSession session, int id, Model model) {
		cdao.receiveCheckout(id);
		ShelfBook sb = cdao.findCheckoutById(id).getShelfBook();
		model.addAttribute("sb", sb);
		return "viewShelfBook";
	}
	@RequestMapping(path = "returnedByBorrower.do", method = RequestMethod.POST)
	public String returnedByBorrower(HttpSession session, int id, Model model) {
		cdao.receiveCheckout(id);
		return "account";
	}

}
