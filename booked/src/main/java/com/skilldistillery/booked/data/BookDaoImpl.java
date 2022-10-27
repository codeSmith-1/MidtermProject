package com.skilldistillery.booked.data;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.booked.entities.Author;
import com.skilldistillery.booked.entities.Book;
import com.skilldistillery.booked.entities.BookCondition;
import com.skilldistillery.booked.entities.Comment;
import com.skilldistillery.booked.entities.Genre;
import com.skilldistillery.booked.entities.Rating;

@Service
@Transactional
public class BookDaoImpl implements BookDAO {
	
	@PersistenceContext
	private EntityManager em;
	 
	@Override
	public List<Rating> getRatingsByBookId(int bId) {
		String query = "SELECT r FROM Rating r WHERE bookId = :bId";
		List<Rating> ratings = em.createQuery(query, Rating.class).setParameter("bId", bId).getResultList();
		return ratings;
	}

	@Override
	public List<Comment> getCommentsByBookId(int bId) {
		String query = "SELECT c FROM Comment c WHERE bookId = :bId";
		List<Comment> comments = em.createQuery(query, Comment.class).setParameter("bId", bId).getResultList();
		return comments;
	}

	@Override
	public Book findBookById(int id) {
		return em.find(Book.class, id);
	}

	@Override
	public List<Book> findAllBooks() {
		String query = "SELECT b FROM Book b";
		List<Book> books = em.createQuery(query, Book.class).getResultList();
		return books;
	}
	
	@Override
	public List<Book> findBooksByKeyword(String keyword) {
		String query = "SELECT b FROM Book b WHERE b.title LIKE :title OR b.author.firstName LIKE :fname OR b.author.lastName LIKE :lname";
		List<Book> keywordBooks = em.createQuery(query, Book.class).setParameter("title", "%"+keyword+"%").setParameter("fname", "%"+keyword+"%").setParameter("lname", "%"+keyword+"%").getResultList();
		return keywordBooks;
	}
	
	@Override
	public Book createBook(Book book) {
		em.persist(book);
		return book;
	}
	
	@Override
	public List<BookCondition> findAllConditions() {
		String query = "SELECT c FROM BookCondition c";
		return em.createQuery(query, BookCondition.class).getResultList();
	}

	@Override
	public Author addAuthor(Author author) {
		em.persist(author);
		return author;
	}

	@Override
	public List<Genre> findAllGenres() {
		String query = "SELECT g FROM Genre g";
		return em.createQuery(query, Genre.class).getResultList();
	}

	@Override
	public Genre findGenreById(int id) {
		return em.find(Genre.class, id);
	}

	@Override
	public List<Book> booksInGenre(int genreId) {
		int numBooksToGet = 5;
		List<Book> allBooks = findAllBooks();
		List<Book> books = new ArrayList<>();
		for (Book book : allBooks) {
			int bookGenreId = book.getGenres().get(0).getId();
			if (book.getGenres() != null && bookGenreId == genreId) {
				books.add(book);
			}
		}
		List<Book> resultList = new ArrayList<>();
		List<Integer> resultIds = new ArrayList<>();
		int[] bookIds = new int[books.size()];
		for (int i = 0; i < books.size(); i++) {
			bookIds[i] = books.get(i).getId();
			System.err.println(i);
		}
		while (numBooksToGet > resultList.size()) {
			int randomNumGen = (int)(Math.random() * bookIds[bookIds.length-1] + bookIds[0]);
			if (!resultIds.contains(randomNumGen) && this.findBookById(randomNumGen) != null) {
				resultList.add(this.findBookById(randomNumGen));
				resultIds.add(randomNumGen);
//				System.err.println("ids:  "+randomNumGen);
			}
		}
		for (Book book : resultList) {
//			System.err.println(book.getGenres().get(0).getId());
		}
		return resultList;
	}
	
}
