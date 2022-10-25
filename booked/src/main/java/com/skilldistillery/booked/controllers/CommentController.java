package com.skilldistillery.booked.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.skilldistillery.booked.data.CommentDAO;
import com.skilldistillery.booked.entities.Book;
import com.skilldistillery.booked.entities.Comment;
import com.skilldistillery.booked.entities.User;

@Controller
public class CommentController {

	@Autowired
	private CommentDAO cdao;
	
	@RequestMapping(path = "postComment.do", method = RequestMethod.POST)
	public String postComment(HttpSession session, String comment) {
		User u = (User) session.getAttribute("user");
		Book b = (Book) session.getAttribute("book");
		Comment cmnt = new Comment();
		cmnt.setComment(comment);
		cmnt.setUser(u);
		cmnt.setBook(b);
		cdao.createComment(cmnt);
		return "redirect:viewBook.do?id="+cmnt.getBook().getId();
	}
}