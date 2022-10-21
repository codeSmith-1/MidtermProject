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

class BookConditionTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private BookCondition bookCondition;
	
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
		bookCondition = em.find(BookCondition.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		bookCondition = null;
	}

	@Test
	void test_BookCondition_basic_mappings() {
		assertNotNull(bookCondition);
		assertNotNull(bookCondition.getName());
	}	

}
