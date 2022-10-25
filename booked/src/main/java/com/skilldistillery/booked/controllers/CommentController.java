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
	
	@RequestMapping(path = "Comment.do", method = RequestMethod.POST)
	public String postComment(HttpSession session, ModelAndView mv, String cmnt) {
		User u = (User) session.getAttribute("user");
		Book b = (Book) session.getAttribute("book");
		Comment comment = new Comment();
		comment.setComment(cmnt);
		comment.setUser(u);
		comment.setBook(b);
		cdao.createComment(comment);
		return "redirect:viewBook.do?id="+comment.getBook().getId();
	}
}
