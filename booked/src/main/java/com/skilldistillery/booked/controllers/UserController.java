package com.skilldistillery.booked.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.skilldistillery.booked.data.UserDAO;

@Controller
public class UserController {
	
	@Autowired
	private UserDAO dao;

}
