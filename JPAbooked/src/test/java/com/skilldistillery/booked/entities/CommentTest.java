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

class CommentTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Comment comment;
	
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
		comment = em.find(Comment.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		comment = null;
	}

	@Test
	void test_Comment_basic_mappings() {
		assertNotNull(comment);
		assertNotNull(comment.getComment());
	}
	
	@Test
	void test_Comment_user() {
		assertNotNull(comment);
		assertNotNull(comment.getUser());
		assertEquals("admin", comment.getUser().getUsername());
	}
	
	@Test
	void test_Comment_book() {
		assertNotNull(comment);
		assertNotNull(comment.getBook());
		assertEquals("Fundamentals of Wavelets", comment.getBook().getTitle());
	}
	
	@Test
	void test_Comment_self_join() {
		assertNotNull(comment);
		assertNotNull(comment.getReplies());
		
	}

}
