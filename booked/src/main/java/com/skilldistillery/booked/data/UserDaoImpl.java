package com.skilldistillery.booked.data;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.booked.entities.Address;
import com.skilldistillery.booked.entities.ShelfBook;
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
		user.getShelfBooks().size();
		for(ShelfBook sb : user.getShelfBooks()) {
			sb.getBook().getGenres().size();
//			getAverageRating(sb.getId());
		}
		user.getFavBooks().size();
		em.clear();
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
	public boolean removeUser(int userId) {
		boolean success = false;
		User user = em.find(User.class, findUserById(userId));
		if (user!= null && user.getEnabled()) {
			user.setEnabled(false);
			em.persist(user);
			success = true;
		}
		return success;
	}

	@Override
	public User createUser(User user) {
		if (user != null) {
			user.setEnabled(true);
			user.setRole("user");
			user.setUsername(user.getEmail());
			createAddress(user.getAddress());
			em.persist(user);
		}
		return user;
	}

	@Override
	public Address createAddress(Address addr) {
		if(addr != null) {
			em.persist(addr);
		}
		return addr;
	}

	


}
