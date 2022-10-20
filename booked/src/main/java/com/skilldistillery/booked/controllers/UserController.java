package com.skilldistillery.booked.controllers;

import org.springframework.stereotype.Controller;

import com.skilldistillery.booked.data.UserDAO;

@Controller
public class UserController {
	
	@AutoWired
	private UserDAO dao;

}
