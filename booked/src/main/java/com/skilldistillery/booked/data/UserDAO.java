package com.skilldistillery.booked.data;

import com.skilldistillery.booked.entities.User;

public interface UserDAO {
	
	User findUserById(int userId);
	User getUserByUserNameAndPassword(String username, String password);
	User updateUser(int userId, User user);
	public User updateUserPassword(int userId, String password);
	User createUser(User user);
	boolean removeUser(int id);
	
}
