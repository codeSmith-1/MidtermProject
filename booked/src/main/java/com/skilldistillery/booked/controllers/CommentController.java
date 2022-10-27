package com.skilldistillery.booked.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.booked.data.BookDAO;
import com.skilldistillery.booked.data.CommentDAO;
import com.skilldistillery.booked.entities.Book;
import com.skilldistillery.booked.entities.Comment;
import com.skilldistillery.booked.entities.User;

@Controller
public class CommentController {

	@Autowired
	private CommentDAO cdao;
	@Autowired
	private BookDAO bookdao;
	
	@RequestMapping(path = "postComment.do", method = RequestMethod.POST)
	public String postComment(int id, HttpSession session, String comment) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "login";
		}
		Book book = bookdao.findBookById(id);
		Comment cmnt = new Comment();
		cmnt.setComment(comment);
		cmnt.setUser(user);
		cmnt.setBook(book);
		cdao.createComment(cmnt);
		return "redirect:viewBook.do?id="+cmnt.getBook().getId();
	}
	
}
