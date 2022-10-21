package com.skilldistillery.booked.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class UserTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private User user;
	
	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPAbooked");
		
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		user = em.find(User.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		user = null;
	}

	@Test
	void test_User_basic_mappings() {
		assertNotNull(user);
		assertEquals("admin", user.getUsername());
	}
	
	@Test
	void test_User_ratings() {
		assertNotNull(user);
		assertNotNull(user.getRatings());
		
	}
	
	@Test
	void test_User_currently_reading() {
		assertNotNull(user);
		assertNotNull(user.getReading());
		
	}
	
	@Test
	void test_User_favorite_genres() {
		assertNotNull(user);
		assertNotNull(user.getFavBooks());
		
	}
	
	@Test
	void test_User_address() {
		assertNotNull(user);
		assertNotNull(user.getAddress());
		
	}
	
	@Test
	void test_User_shelfbooks() {
		assertNotNull(user);
		assertNotNull(user.getShelfBooks());
		
	}
	
	@Test
	void test_User_checkouts() {
		assertNotNull(user);
		assertNotNull(user.getCheckouts());
		
	}
	
	@Test
	void test_User_comments() {
		assertNotNull(user);
		assertNotNull(user.getComments());
		
	}

}
