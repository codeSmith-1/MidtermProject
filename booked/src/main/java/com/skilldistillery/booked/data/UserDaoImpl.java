package com.skilldistillery.booked.data;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.booked.entities.User;

@Service
@Transactional
public class UserDaoImpl implements UserDAO {
	
	@PersistenceContext
	private EntityManager em;

	
	@Override
	public User findUserById(int userId) {
		return em.find(User.class, userId);
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
