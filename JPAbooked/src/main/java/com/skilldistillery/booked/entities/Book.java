package com.skilldistillery.booked.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.hibernate.annotations.Formula;

@Entity
public class Book {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;

	private String title;

	private String description;

	private String cover;
	
	@Formula("(SELECT ROUND(AVG(r.rating),1) FROM Rating r WHERE r.book_id = id)")
	private Double rating;
	
	@ManyToOne
	@JoinColumn(name="author_id")
	private Author author;
	
	@ManyToMany(mappedBy="reading")
	private List<User> users;
	
	@ManyToMany(mappedBy="favBooks")
	private List<User> reading;
	
	@OneToMany(mappedBy="book")
	private List<Rating> ratings;
	
	@OneToMany(mappedBy="book")
	private List<Comment> comments;
	
	@OneToMany(mappedBy="book")
	private List<ShelfBook> shelfBooks;
	
	@ManyToMany(mappedBy="books")
	private List<Genre> genres;
	
	public Book() {}
	
	public Double getRating() {
		return rating;
	}

	public void setRating(Double rating) {
		this.rating = rating;
	}

	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
		
	public Author getAuthor() {
		return author;
	}

	public void setAuthor(Author author) {
		this.author = author;
	}

	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

	public List<User> getReading() {
		return reading;
	}

	public void setReading(List<User> reading) {
		this.reading = reading;
	}

	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	public List<ShelfBook> getShelfBooks() {
		return shelfBooks;
	}

	public void setShelfBooks(List<ShelfBook> shelfBooks) {
		this.shelfBooks = shelfBooks;
	}

	public List<Genre> getGenres() {
		return genres;
	}

	public void setGenres(List<Genre> genres) {
		this.genres = genres;
	}

	public List<Rating> getRatings() {
		return ratings;
	}

	public void setRatings(List<Rating> ratings) {
		this.ratings = ratings;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getCover() {
		return cover;
	}

	public void setCover(String cover) {
		this.cover = cover;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Book other = (Book) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Book [id=" + id + ", title=" + title + ", description=" + description + ", cover=" + cover + "]";
	}
	public void addGenre(Genre gen) {
		if(genres == null) {genres = new ArrayList<>();}
		if(!genres.contains(gen)) {
			genres.add(gen);
			gen.addBook(this);
		}
	}
	public void removeGenre(Genre gen) {
		if(genres != null && genres.contains(gen)) {
			genres.remove(gen);
			gen.removeBook(this);
		}
	}
	public void addShelfBook(ShelfBook sb) {
		if(shelfBooks == null) {shelfBooks = new ArrayList<>();}
		if(!shelfBooks.contains(sb)) {
			shelfBooks.add(sb);
			sb.setBook(this);
		}
	}
	public void removeShelfBook(ShelfBook sb) {
		if(shelfBooks != null && shelfBooks.contains(sb)) {
			shelfBooks.remove(sb);
			sb.setBook(null);
		}
	}
	public void addUser(User user) {
		if(users == null) {users = new ArrayList<>();}
		if(!users.contains(user)) {
			users.add(user);
			user.addCurrReading(this);
		}
	}
	public void removeUser(User user) {
		if(users != null && users.contains(user)) {
			users.remove(user);
			user.removeCurrReading(this);
		}
	}
}
