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

class ShelfBookTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private ShelfBook shelfBook;
	
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
		shelfBook = em.find(ShelfBook.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		shelfBook = null;
	}

	@Test
	void test_ShelfBook_basic_mappings() {
		assertNotNull(shelfBook);
		assertNotNull(shelfBook.isForBorrow());
		System.out.println(shelfBook);
	}	
	
	@Test
	void test_ShelfBook_user() {
		assertNotNull(shelfBook);
		assertNotNull(shelfBook.getUser());
		
	}
	
	@Test
	void test_ShelfBook_condition() {
		assertNotNull(shelfBook);
		assertNotNull(shelfBook.getCondition());
		
	}
	
	@Test
	void test_ShelfBook_book() {
		assertNotNull(shelfBook);
		assertNotNull(shelfBook.getBook());
		
	}
	
	@Test
	void test_ShelfBook_checkouts() {
		assertNotNull(shelfBook);
		assertNotNull(shelfBook.getCheckouts());
		
	}
	
}
