package com.skilldistillery.booked.data;

import com.skilldistillery.booked.entities.User;

public interface UserDAO {
	
	User findById(int userId);
	
}
