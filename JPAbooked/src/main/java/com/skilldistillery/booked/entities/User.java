package com.skilldistillery.booked.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

@Entity
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@ManyToMany
	@JoinTable(name = "favorite_book", 
	joinColumns = @JoinColumn(name = "user_id"), 
	inverseJoinColumns = @JoinColumn(name = "book_id"))
	private List<Book> favBooks;

	@ManyToMany
	@JoinTable(name = "currently_reading", 
	joinColumns = @JoinColumn(name = "user_id"), 
	inverseJoinColumns = @JoinColumn(name = "book_id"))
	private List<Book> reading;

	@ManyToMany
	@JoinTable(name = "user_has_author", 
	joinColumns = @JoinColumn(name = "user_id"), 
	inverseJoinColumns = @JoinColumn(name = "author_id"))
	private List<Author> authors;

	@ManyToMany
	@JoinTable(name = "genre_has_user", 
	joinColumns = @JoinColumn(name = "user_id"), 
	inverseJoinColumns = @JoinColumn(name = "genre_id"))
	private List<Genre> genres;

	@OneToMany(mappedBy = "user")
	private List<Rating> ratings;

	@OneToMany(mappedBy = "user")
	private List<Checkout> checkouts;

	@OneToMany(mappedBy = "user")
	private List<ShelfBook> shelfBooks;

	@OneToMany(mappedBy = "user")
	private List<Comment> comments;

	private String username;

	private String password;

	private String email;

	private Boolean enabled;

	private String role;
	
	@OneToOne
	@JoinColumn(name = "address_id")
	private Address address;

	@Column(name = "first_name")
	private String firstName;

	@Column(name = "last_name")
	private String lastName;

	@Column(name = "about_me")
	private String aboutMe;

	@Column(name = "profile_img")
	private String profileImg;

	public User() {}

	public User(int id, List<Book> favBooks, List<Book> reading, List<Author> authors, List<Genre> genres,
			List<Rating> ratings, List<Checkout> checkouts, List<ShelfBook> shelfBooks, List<Comment> comments,
			String username, String password, String email, Boolean enabled, String role, Address address,
			String firstName, String lastName, String aboutMe, String profileImg) {
		super();
		this.id = id;
		this.favBooks = favBooks;
		this.reading = reading;
		this.authors = authors;
		this.genres = genres;
		this.ratings = ratings;
		this.checkouts = checkouts;
		this.shelfBooks = shelfBooks;
		this.comments = comments;
		this.username = username;
		this.password = password;
		this.email = email;
		this.enabled = enabled;
		this.role = role;
		this.address = address;
		this.firstName = firstName;
		this.lastName = lastName;
		this.aboutMe = aboutMe;
		this.profileImg = profileImg;
	}

	public List<Book> getFavBooks() {
		for (Book book : favBooks) {
			book.getGenres().size();
		}
		return favBooks;
	}

	public void setFavBooks(List<Book> favBooks) {
		this.favBooks = favBooks;
	}

	public List<Book> getReading() {
		return reading;
	}

	public void setReading(List<Book> reading) {
		this.reading = reading;
	}

	public List<Author> getAuthors() {
		return authors;
	}

	public void setAuthors(List<Author> authors) {
		this.authors = authors;
	}

	public List<Genre> getGenres() {
		return genres;
	}

	public void setGenres(List<Genre> genres) {
		this.genres = genres;
	}

	public List<Checkout> getCheckouts() {
		return checkouts;
	}

	public void setCheckouts(List<Checkout> checkouts) {
		this.checkouts = checkouts;
	}

	public List<ShelfBook> getShelfBooks() {
		return shelfBooks;
	}

	public void setShelfBooks(List<ShelfBook> shelfBooks) {
		this.shelfBooks = shelfBooks;
	}

	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	public List<Rating> getRatings() {
		return ratings;
	}

	public void setRatings(List<Rating> ratings) {
		this.ratings = ratings;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Boolean getEnabled() {
		return enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getAboutMe() {
		return aboutMe;
	}

	public void setAboutMe(String aboutMe) {
		this.aboutMe = aboutMe;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
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
		User other = (User) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", email=" + email
				+ ", enabled=" + enabled + ", role=" + role + ", firstName=" + firstName
				+ ", lastName=" + lastName + ", aboutMe=" + aboutMe + ", profileImg=" + profileImg + "]";
	}

	public void addComment(Comment comment) {
		if(comments == null) {comments = new ArrayList<>();}
		if(!comments.contains(comment)) {
			comments.add(comment);
			comment.setUser(this);
		}
	}
	public void removeComment(Comment comment) {
		if(comments != null && comments.contains(comment)) {
			comments.remove(comment);
			comment.setUser(null);
		}
	}
	public void addShelfBook(ShelfBook sb) {
		if(shelfBooks == null) {shelfBooks = new ArrayList<>();}
		if(!shelfBooks.contains(sb)) {
			shelfBooks.add(sb);
			sb.setUser(this);;
		}
	}
	public void removeShelfBook(ShelfBook sb) {
		if(shelfBooks != null && shelfBooks.contains(sb)) {
			shelfBooks.remove(sb);
			sb.setUser(null);
		}
	}
	public void addCheckout(Checkout check) {
		if(checkouts == null) {checkouts = new ArrayList<>();}
		if(!checkouts.contains(check)) {
			checkouts.add(check);
			check.setUser(this);
		}
	}
	public void removeComment(Checkout check) {
		if(checkouts != null && checkouts.contains(check)) {
			checkouts.remove(check);
			check.setUser(null);
		}
	}
	public void addRating(Rating rating) {
		if(ratings == null) {ratings = new ArrayList<>();}
		if(!ratings.contains(rating)) {
			ratings.add(rating);
			rating.setUser(this);
		}
	}
	public void removeRating(Rating rating) {
		if(ratings != null && ratings.contains(rating)) {
			ratings.remove(rating);
			rating.setUser(null);
		}
	}
	public void addGenre(Genre genre) {
		if(genres == null) {genres = new ArrayList<>();}
		if(!genres.contains(genre)) {
			genres.add(genre);
			genre.addUser(this);
		}
	}
	public void removeGenre(Genre genre) {
		if(genres != null && genres.contains(genre)) {
			genres.remove(genre);
			genre.removeUser(this);
		}
	}
	public void addAuthor(Author auth) {
		if(authors == null) {authors = new ArrayList<>();}
		if(!authors.contains(auth)) {
			authors.add(auth);
			auth.addUser(this);
		}
	}
	public void removeAuthor(Author auth) {
		if(authors != null && authors.contains(auth)) {
			authors.remove(auth);
			auth.removeUser(this);
		}
	}
	public void addCurrReading(Book book) {
		if(reading == null) {reading = new ArrayList<>();}
		if(!reading.contains(book)) {
			reading.add(book);
			book.addUser(this);
		}
	}
	public void removeCurrReading(Book book) {
		if(reading != null && reading.contains(book)) {
			reading.remove(book);
			book.removeUser(this);
		}
	}
}

