package com.skilldistillery.booked.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;

@Entity
public class Genre {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	private String description;
	
	private String image;

	@ManyToMany(mappedBy = "genres")
	private List<User> users;

	@ManyToMany
	@JoinTable(name="book_has_genre",
	joinColumns=@JoinColumn(name = "genre_id"),
	inverseJoinColumns=@JoinColumn(name="book_id"))
	private List<Book> books;

	public Genre() {}

	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

	public List<Book> getBooks() {
		return books;
	}

	public void setBooks(List<Book> books) {
		this.books = books;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
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
		Genre other = (Genre) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Genre [id=" + id + ", name=" + name + ", description=" + description + ", image=" + image + "]";
	}
	public void addUser(User user) {
		if(users == null) {users = new ArrayList<>();}
		if(users.contains(user)) {
			users.add(user);
			user.addGenre(this);
		}
	}
	public void removeUser(User user) {
		if(users != null && users.contains(user)) {
			users.remove(user);
			user.removeGenre(this);
		}
	}
	public void addBook(Book book) {
		if(books == null) {books = new ArrayList<>();}
		if(!books.contains(book)) {
			books.add(book);
			book.addGenre(this);
		}
	}
	public void removeBook(Book book) {
		if(books != null && books.contains(book)) {
			books.remove(book);
			book.removeGenre(this);
		}
	}

}
