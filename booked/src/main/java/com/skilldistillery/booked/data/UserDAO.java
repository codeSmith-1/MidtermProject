package com.skilldistillery.booked.data;

import java.util.List;

import com.skilldistillery.booked.entities.Address;
import com.skilldistillery.booked.entities.Book;
import com.skilldistillery.booked.entities.User;

public interface UserDAO {
	
	public User findUserById(int userId);
	public User getUserByUserNameAndPassword(String username, String password);
	public User updateUser(int id, User user);
	public User updateUserPassword(int userId, String password);
	public User createUser(User user);
	public boolean removeUser(int id);
	public Address createAddress(Address addr);
	public List<String> getAllUserNames();
	public User updateFavList(int id, User user);
	public List<User> getUsersbyCity(User user);

}
