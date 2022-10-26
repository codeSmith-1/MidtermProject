package com.skilldistillery.booked.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.booked.entities.Address;
import com.skilldistillery.booked.entities.Book;
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
		for(Book book : user.getFavBooks()) {
			book.getGenres().size();
		}
		em.clear();
		return user;
	}

	@Override
	public User updateUser(int id, User user) {
		User updateMe = em.find(User.class, id);
		if (updateMe != null) {
//			updateMe.setAddress(user.getAddress());
			updateMe.setFirstName(user.getFirstName());
			updateMe.setLastName(user.getLastName());
			updateMe.setAboutMe(user.getAboutMe());
//			updateMe.setEmail(user.getEmail());
			updateMe.setProfileImg(user.getProfileImg());
			if(user.getAddress() != null) {
				updateMe.getAddress().setStreet(user.getAddress().getStreet());
				updateMe.getAddress().setStreet2(user.getAddress().getStreet2());
				updateMe.getAddress().setCity(user.getAddress().getCity());
				updateMe.getAddress().setState(user.getAddress().getState());
				updateMe.getAddress().setZipcode(user.getAddress().getZipcode());
			}
			em.persist(updateMe);
		}
		return updateMe;
	}
	
	@Override
	public User updateUserPassword(int userId, String newPassword) {
		User updateMyPword = em.find(User.class, userId);
		if (updateMyPword != null && newPassword.length() > 8) {
			updateMyPword.setPassword(newPassword);
			em.remove(em.find(User.class, userId));
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
			List<String> userList = getAllUserNames();
			if(userList.contains(user.getUsername())) {
				throw new RuntimeException("Username already exists");
			}
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

	@Override
	public List<String> getAllUserNames(){
		String jpql = "SELECT u.username FROM User u WHERE u.id > 0";
		List<String> userList = em.createQuery(jpql, String.class).getResultList();
		return userList;
	}

	@Override
	public User updateFavList(int id, User user) {
		User dbUser = em.find(User.class, user.getId());
		dbUser.setFavBooks(user.getFavBooks());
		em.remove(em.find(User.class, id));
		em.persist(dbUser);
		return dbUser;
	}

}
