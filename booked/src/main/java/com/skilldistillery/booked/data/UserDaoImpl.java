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
		String jpql = "SELECT u FROM User u where u.username = :username AND u.password = :password";
		User user = em.createQuery(jpql, User.class).setParameter("username", username).setParameter("password", password).getSingleResult();
		if (user == null) {
			System.out.println("idk what happened");
		}
		return user;
	}

	@Override
	public User updateUser(int userId, User user) {
		User updateMe = em.find(User.class, userId);
		if (updateMe != null) {
			updateMe.setAddress(user.getAddress());
			updateMe.setFirstName(user.getFirstName());
			updateMe.setLastName(user.getLastName());
			updateMe.setAboutMe(user.getAboutMe());
			updateMe.setEmail(user.getEmail());
			updateMe.setProfileImg(user.getProfileImg());
			em.persist(updateMe);
		}
		return updateMe;
	}
	
	@Override
	public User updateUserPassword(int userId, String newPassword) {
		User updateMyPword = em.find(User.class, userId);
		if (updateMyPword != null && newPassword.length() > 8) {
			updateMyPword.setPassword(newPassword);
			em.persist(updateMyPword);
		}
		return updateMyPword;
	}

	@Override
	public User createUser(User user) {
		// Setting fields to the same value already in that object?
		if (user != null) {
			user.setEmail(user.getEmail());
			user.setPassword(user.getPassword());
			user.setEnabled(true);
			user.setRole("user");
			user.setProfileImg(user.getProfileImg());
			em.persist(user);
		}
		return user;
	}

	@Override
	public boolean removeUser(int userId) {
		// Do we want to actually remove the user, or set them to disabled?
		boolean success = false;
		User deleteMe = em.find(User.class, findUserById(userId));
		if (deleteMe != null) {
			em.remove(deleteMe);
			success = !em.contains(deleteMe);
		}
		return success;
	}

}
