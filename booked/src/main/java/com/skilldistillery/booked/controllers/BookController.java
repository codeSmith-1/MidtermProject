package com.skilldistillery.booked.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.skilldistillery.booked.data.BookDAO;
import com.skilldistillery.booked.data.RatingDAO;


@Controller
public class BookController {
	
	@Autowired
	private RatingDAO rdao;

	@Autowired
	private BookDAO bdao;

	
	
	
	
}
