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

class BookTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Book book;
	
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
		book = em.find(Book.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		book = null;
	}

	@Test
	void test_Book_basic_mappings() {
		assertNotNull(book);
		assertNotNull(book.getTitle());
	}
	
	@Test
	void test_Book_comments() {
		assertNotNull(book);
		assertNotNull(book.getComments());
		assertEquals("Looking for some books", book.getComments().get(0).getComment());
	}
	
	@Test
	void test_Book_genres() {
		assertNotNull(book);
		assertNotNull(book.getGenres());
		assertTrue(book.getGenres().size() > 0);
	}
	
	@Test
	void test_Book_rating() {
		assertNotNull(book);
		assertNotNull(book.getRatings());
		assertTrue(book.getRatings().size() > 0);
	}
	
	@Test
	void test_Book_author() {
		assertNotNull(book);
		assertNotNull(book.getAuthor());
		assertEquals("Jaideva", book.getAuthor().getFirstName());
	}

}
