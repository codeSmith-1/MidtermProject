package com.skilldistillery.booked.data;

import java.util.LinkedHashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.skilldistillery.booked.entities.User;

@Repository
public class InMemoryUserDAO implements UserDAO {
	
	private Map<Integer, User> users;
	
	public InMemoryUserDAO() {
		users = new LinkedHashMap<>(); 
		
		users.put(2, new User("TKC", "password", true, "admin"));
	}

	@Override
	public User findUserById(int userId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public User getUserByUserNameAndPassword(String username, String password) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public User updateUser(int userId, User user) {
		// TODO Auto-generated method stub
		return null;
	}

}
