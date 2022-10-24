package com.skilldistillery.booked.data;

public class UserDAOImplTest {

	public static void main(String[] args) {
		UserDAO userDao = new UserDaoImpl();
		System.out.println(userDao.getUserByUserNameAndPassword("Wall@example.com", "Wall!"));
	}

}
