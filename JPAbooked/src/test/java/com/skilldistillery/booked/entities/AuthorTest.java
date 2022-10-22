package com.skilldistillery.booked.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class AuthorTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Author author;
	
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
		author = em.find(Author.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		author = null;
	}

	@Test
	void test_Author_basic_mappings() {
		assertNotNull(author);
		assertNotNull(author.getFirstName());
	}	
	
	@Test
	void test_Author_book_mapping() {
		assertNotNull(author);
		assertNotNull(author.getBooks());
		assertTrue(author.getBooks().size() > 0);
		assertEquals("Fundamentals of Wavelets", author.getBooks().get(0).getTitle());
	}
	
	@Test
	void test_Author_users_mapping() {
		assertNotNull(author);
		assertNotNull(author.getUsers());
		assertTrue(author.getUsers().size() > 0);
		assertEquals(1, author.getUsers().size());
	}
	
}
