package com.skilldistillery.booked.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class RatingTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Rating rating;
	
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
		RatingId ratingId = new RatingId(1,1);
		rating = em.find(Rating.class, ratingId);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		rating = null;
	}

	@Test
	void test_Rating_basic_mappings() {
		assertNotNull(rating);
		assertNotNull(rating.getRatingComment());
	}
	
//	@Test
//	void test_Rating_user() {
//		assertNotNull(rating);
//		assertNotNull(rating.getUser());
//	}
//	
//	@Test
//	void test_Rating_book() {
//		assertNotNull(rating);
//		assertNotNull(rating.getBook());
//	}

}
