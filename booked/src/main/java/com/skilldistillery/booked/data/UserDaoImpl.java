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
		User user = null;
//		String jpql = "SELECT u FROM User u where u.username = :username AND u.password = :password";
		String jpqlUsername = "Select u.username FROM User u WHERE u.username = :username";
		String jpqlPassword = "Select u.password FROM User u WHERE u.password = :password";
//		User user = em.createQuery(jpql, User.class).setParameter("username", username).setParameter("password", password).getSingleResult();
//		em.close();
		String dbUserNameResult = em.createQuery(jpqlUsername, String.class).setParameter("username", username).getSingleResult();
		String dbPassword = em.createQuery(jpqlPassword, String.class).setParameter("password", password).getSingleResult();
//		if(username.equals(dbUserNameResult)) {
//			user.setUsername(dbUserNameResult);
//		} else {
//			user.setUsername("false");
//		}
//		if(username.equals(dbPassword)) {
//			user.setPassword(dbPassword);
//		} else {
//			user.setPassword("false");
//		}
		return user;
	}

	@Override
	public User updateUser(int userId, User user) {
		User updateMe = em.find(User.class, userId);
		if (updateMe != null) {
			updateMe.setFirstName(user.getFirstName());
			updateMe.setLastName(user.getLastName());
			updateMe.setAboutMe(user.getAboutMe());
			updateMe.setEmail(user.getEmail());
			em.getTransaction().begin();
			em.persist(updateMe);
			em.getTransaction().commit();
		}
		em.close();
		return updateMe;
	}

	@Override
	public User createUser(User user) {
		if (user != null) {
			em.getTransaction().begin();
			user.setEmail(user.getEmail());
			user.setPassword(user.getEmail());
			user.setEnabled(true);
			user.setRole("user");
			user.setProfileImg(user.getProfileImg());
			em.persist(user);
			em.getTransaction().commit();
			em.close();
		}
		return user;
	}

	@Override
	public boolean removeUser(int userId) {
		boolean success = false;
		User deleteMe = em.find(User.class, findUserById(userId));
		if (deleteMe != null) {
			em.getTransaction().begin();
			em.remove(deleteMe);
			success = !em.contains(deleteMe);
			em.getTransaction().commit();
		}
		em.close();
		return success;
	}

}
