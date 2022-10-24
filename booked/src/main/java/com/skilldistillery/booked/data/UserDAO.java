package com.skilldistillery.booked.data;

import com.skilldistillery.booked.entities.Address;
import com.skilldistillery.booked.entities.User;

public interface UserDAO {
	
	public User findUserById(int userId);
	public User getUserByUserNameAndPassword(String username, String password);
	public User updateUser(int userId, User user);
	public User updateUserPassword(int userId, String password);
	public User createUser(User user);
	public boolean removeUser(int id);
	public User createShelfBook(int user);
	public Address createAddress(Address addr);
}
