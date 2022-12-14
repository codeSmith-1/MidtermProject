package com.skilldistillery.booked.controllers;


import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.booked.data.BookDAO;
import com.skilldistillery.booked.data.CommentDAO;
import com.skilldistillery.booked.data.RatingDAO;
import com.skilldistillery.booked.data.ShelfBookDAO;
import com.skilldistillery.booked.data.UserDAO;
import com.skilldistillery.booked.entities.Author;
import com.skilldistillery.booked.entities.Book;
import com.skilldistillery.booked.entities.Comment;
import com.skilldistillery.booked.entities.Genre;
import com.skilldistillery.booked.entities.Rating;
import com.skilldistillery.booked.entities.ShelfBook;
import com.skilldistillery.booked.entities.User;

@Controller
public class BookController {

	@Autowired
	private BookDAO bookdao;
	@Autowired
	private ShelfBookDAO sbdao;
	@Autowired
	private CommentDAO cdao;
	@Autowired
	private RatingDAO rdao;
	@Autowired
	private UserDAO udao;

	@RequestMapping(path = "viewBook.do", method = RequestMethod.GET)
	public String viewBook(int id, HttpSession session, Model model) {
		Book book = bookdao.findBookById(id);
		User user = (User) session.getAttribute("user");
		if (user != null && rdao.getUserRating(user, book) != null) {
			System.out.println(book);
			System.out.println(user);
			Rating userRating = rdao.getUserRating(user, book);
			System.out.println(rdao.getUserRating(user, book));
			model.addAttribute("userRating", userRating);
		}
		
//		Double avgRating = rdao.getAverageRating(id);
//		if (avgRating != null) {
//		avgRating = ((int)(avgRating * 10))/10.0;
//		}
		
		List<Comment> comments = cdao.findCommentsByBookId(id);
		book.setComments(comments);
//		model.addAttribute("avgRating", avgRating);
		model.addAttribute("book", book);
		model.addAttribute("books", sbdao.findShelfBooksByBookId(id));
		return "bookView";
	}

	@RequestMapping(path = "rateBook.do", method = RequestMethod.POST)
	public String rateBook(int id, int ratingValue, HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if (ratingValue >= 0 && ratingValue <= 5) {
			boolean bool = rdao.createRating(id, ratingValue, user.getId());			
		}
		return "redirect:viewBook.do?id=" + id;
	}

	@RequestMapping(path = "updateRating.do", method = RequestMethod.POST)
	public String updateRating(int id, int ratingValue, HttpSession session, Model model) {
		if (ratingValue >= 0 && ratingValue <= 5) {
		User user = (User) session.getAttribute("user");
		Book book = bookdao.findBookById(id);
		Rating rating = rdao.getUserRating(user, book);
		rating.setRating(ratingValue);
		rdao.updateRating(rating);
		}
		return "redirect:viewBook.do?id=" + id;
	}

	@RequestMapping(path = "viewShelfBook.do", method = RequestMethod.GET)
	public String viewShelfBook(int id, HttpSession session, Model model) {
		ShelfBook sb = sbdao.findShelfBookById(id);
		model.addAttribute("sb", sb);
		return "viewShelfBook";
	}

	@RequestMapping(path = "myBookshelf.do", method = RequestMethod.GET)
	public String viewBookshelf(HttpSession session, Model model) {
		if (session.getAttribute("user") != null) {
			User user = (User) session.getAttribute("user");
			List<ShelfBook> sBooks = sbdao.findShelfBooksByOwnerId(user.getId());
			model.addAttribute("books", sBooks);
			model.addAttribute("favs", user.getFavBooks());
			return "bookshelf";
		}
		return "login";
	}

	@RequestMapping(path = "library.do", method = RequestMethod.GET)
	public String viewLibrary(HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		model.addAttribute("allBooks", bookdao.findAllBooks());
		if (user != null) {
			model.addAttribute("favs", user.getFavBooks());
		}
		return "library";
	}

	@RequestMapping(path = "search.do", method = RequestMethod.GET)
	public String searchLibrary(String search, HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "login";
		}
		model.addAttribute("allBooks", bookdao.findBooksByKeyword(search));
		model.addAttribute("favs", user.getFavBooks());
		return "library";
	}

	@RequestMapping(path = "deleteShelfBook.do", method = RequestMethod.GET)
	public String deleteShelfBook(Integer id, HttpSession session, Model model) {
		sbdao.removeShelfBook(id);
		if (session.getAttribute("user") != null) {
			User user = (User) session.getAttribute("user");
			model.addAttribute("books", sbdao.findShelfBooksByOwnerId(user.getId()));
			model.addAttribute("favs", user.getFavBooks());
		}
		return "bookshelf";
	}

	@RequestMapping(path = "addShelfBook.do", method = RequestMethod.GET)
	public String addShelfBook(int id, HttpSession session, Model model) {
		if (session.getAttribute("user") == null) {
			return "login";
		}
		model.addAttribute("book", bookdao.findBookById(id));

		model.addAttribute("genres", bookdao.findBookById(id).getGenres());
		model.addAttribute("conditions", bookdao.findAllConditions());
		return "shelfBookCreate";
	}

	@RequestMapping(path = "addShelfBook.do", method = RequestMethod.POST)
	public String addShelfBook(int conditionId, int bookId, ShelfBook sBook, HttpSession session, Model model) {
		if (session.getAttribute("user") == null) {
			return "login";
		}
		sBook.setBook(bookdao.findBookById(bookId));
		sBook.setUser((User) session.getAttribute("user"));
		sBook.setCondition(sbdao.findConditionById(conditionId));

		sbdao.createShelfBook(sBook);
		if (session.getAttribute("user") != null) {
			User user = (User) session.getAttribute("user");
			model.addAttribute("books", sbdao.findShelfBooksByOwnerId(user.getId()));
			model.addAttribute("favs", user.getFavBooks());
		}
		return "bookshelf";
	}

	@RequestMapping(path = "addBook.do", method = RequestMethod.GET)
	public String addBook(HttpSession session, Model model) {
		model.addAttribute("genres", bookdao.findAllGenres());
		return "bookCreate";
	}

	@RequestMapping(path = "addBook.do", method = RequestMethod.POST)
	public String addBook(int genreId, String firstName, String lastName, Book book, HttpSession session, Model model) {
		if (session.getAttribute("user") == null) {
			return "login";
		}
		List<Genre> genres = new ArrayList<>();
		Genre g = new Genre();
		g.setId(genreId);
		book.addGenre(g);
		Author author = new Author();
		author.setFirstName(firstName);
		author.setLastName(lastName);
		bookdao.addAuthor(author);
		book.setAuthor(author);
		Book newBook = bookdao.createBook(book);
		model.addAttribute("book", newBook);
		model.addAttribute("genres", newBook.getGenres());
		System.out.println(book.getGenres());
		model.addAttribute("conditions", bookdao.findAllConditions());
		return "shelfBookCreate";
	}

	@RequestMapping(path = "addFavBook.do", method = RequestMethod.GET)
	public String addFavBook(Integer id, HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "login";
		}
		Book newFavBook = bookdao.findBookById(id);
		List<Book> favBooks = user.getFavBooks();
		if (!favBooks.contains(newFavBook)) {
			favBooks.add(newFavBook);
			user.setFavBooks(favBooks);
			user = udao.updateFavList(user.getId(), user);
		}
		model.addAttribute("favs", user.getFavBooks());
		model.addAttribute("allBooks", bookdao.findAllBooks());
		return "library";
	}

}
