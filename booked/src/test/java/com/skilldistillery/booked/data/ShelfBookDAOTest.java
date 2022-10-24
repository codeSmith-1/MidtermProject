package com.skilldistillery.booked.data;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class ShelfBookDAOTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private ShelfBookDaoImpl shelfDao;
	
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
		shelfDao = em.find(ShelfBookDaoImpl.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		shelfDao = null;
	}

	@Test
	void test_ShelfBook_DAO_Impl_findAllShelfBooks() {
		assertNotNull(shelfDao);
		assertNotNull(shelfDao.findAllShelfBooks());
		assertTrue(shelfDao.findAllShelfBooks().size() > 0);
	}
	
	@Test
	void test_ShelfBook_DAO_Impl_findShelfBooksByKeyword() {
		assertNotNull(shelfDao);
		assertNotNull(shelfDao.findShelfBooksByKeyword("England"));
		assertTrue(shelfDao.findShelfBooksByKeyword("England").size() > 0);
	}
	
	@Test
	void test_ShelfBook_DAO_Impl_findShelfBooksByOwnerId() {
		assertNotNull(shelfDao);
		assertNotNull(shelfDao.findShelfBooksByOwnerId(1));
		assertTrue(shelfDao.findShelfBooksByOwnerId(1).size() > 0);
	}
	
	@Test
	void test_ShelfBook_DAO_Impl_findShelfBookById() {
		assertNotNull(shelfDao);
		assertNotNull(shelfDao.findShelfBookById(4));
	}

}