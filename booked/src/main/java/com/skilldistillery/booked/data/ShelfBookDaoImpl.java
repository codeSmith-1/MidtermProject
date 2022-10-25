package com.skilldistillery.booked.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.booked.entities.Book;
import com.skilldistillery.booked.entities.BookCondition;
import com.skilldistillery.booked.entities.ShelfBook;
import com.skilldistillery.booked.entities.User;

@Service
@Transactional
public class ShelfBookDaoImpl implements ShelfBookDAO {
	
	@PersistenceContext
	private EntityManager em;
	@Autowired
	private BookDAO bookDao;

	@Override
	public ShelfBook createShelfBook(ShelfBook shelfBook) {
		Book book = em.find(Book.class, shelfBook.getBook().getId());
		if (book == null) {
			bookDao.createBook(em.find(Book.class, shelfBook.getBook()));
		}
		shelfBook.setCondition(em.find(BookCondition.class, 1));
		em.persist(shelfBook);
		return shelfBook;
	}
	
	@Override
	public List<ShelfBook> findAllShelfBooks() {
		String query = "SELECT sb FROM ShelfBook sb";
		List<ShelfBook> allBooks = em.createQuery(query, ShelfBook.class).getResultList();
		return allBooks;
	}

	@Override
	public List<ShelfBook> findShelfBooksByKeyword(String keyword) {
		String query = "SELECT sb FROM ShelfBook sb WHERE sb.book.title = :title";
		List<ShelfBook> keywordBooks = em.createQuery(query, ShelfBook.class).setParameter("title", keyword).getResultList();
		return keywordBooks;
	}

	@Override
	public List<ShelfBook> findShelfBooksByOwnerId(int ownerId) {
		User user = em.find(User.class, ownerId);
		String query = "SELECT sb FROM ShelfBook sb WHERE sb.user LIKE :user";
		List<ShelfBook> ownerBooks = em.createQuery(query, ShelfBook.class).setParameter("user", user).getResultList();
		return ownerBooks;
	}

	@Override
	public ShelfBook findShelfBookById(int id) {
		return em.find(ShelfBook.class, id);
	}
	
	@Override
	public ShelfBook updateShelfBook(int id, ShelfBook shelfBook) {
		ShelfBook bookFromDB = em.find(ShelfBook.class, id);
		bookFromDB.setCondition(shelfBook.getCondition());
		bookFromDB.setForBorrow(shelfBook.isForBorrow());
		bookFromDB.setForSale(shelfBook.isForSale());
		bookFromDB.setSalePrice(shelfBook.getSalePrice());
		return bookFromDB;
	}
	
	@Override
	public Boolean removeShelfBook(int id) {
		em.remove(em.find(ShelfBook.class, id));
		if (em.find(ShelfBook.class, id) != null) {
			return false;
		} else {
			return true;
		}
	}
	
	@Override
	public List<ShelfBook> findShelfBooksByBookId(int bid) {
		String sql = "SELECT sb FROM ShelfBook sb WHERE sb.book.id = :bid";
		List<ShelfBook> books = em.createQuery(sql, ShelfBook.class).setParameter("bid", bid).getResultList();
		return books;
	}
	
}
