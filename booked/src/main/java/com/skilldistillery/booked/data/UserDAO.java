package com.skilldistillery.booked.data;

import java.util.List;

import com.skilldistillery.booked.entities.Address;
import com.skilldistillery.booked.entities.Book;
import com.skilldistillery.booked.entities.User;

public interface UserDAO {
	
	User findUserById(int userId);
	User getUserByUserNameAndPassword(String username, String password);
	User updateUser(int id, User user);
	User updateUserPassword(int userId, String password);
	User createUser(User user);
	boolean removeUser(int id);
	Address createAddress(Address addr);
	List<String> getAllUserNames();
	User updateFavList(int id, User user);
	List<User> getUsersbyCity(User user);

}
