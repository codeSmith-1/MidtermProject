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

class CheckoutTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Checkout checkout;
	
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
		checkout = em.find(Checkout.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		checkout = null;
	}

	@Test
	void test_Checkout_basic_mappings() {
		assertNotNull(checkout);
		assertNotNull(checkout.getRequestDate());
	}
	
	@Test
	void test_Checkout_user() {
		assertNotNull(checkout);
		assertNotNull(checkout.getUser());
		assertEquals("admin", checkout.getUser().getUsername());
	}
	
	@Test
	void test_Checkout_shelfBook() {
		assertNotNull(checkout);
		assertNotNull(checkout.getShelfBook());
		assertEquals(1, checkout.getShelfBook().getId());
	}

}
