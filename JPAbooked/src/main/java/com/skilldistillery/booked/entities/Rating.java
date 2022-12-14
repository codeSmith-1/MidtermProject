package com.skilldistillery.booked.entities;

import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;

@Entity
public class Rating {
	@EmbeddedId
	private RatingId id;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	@MapsId(value ="userId")
	private User user;
	
	@ManyToOne
	@JoinColumn(name="book_id")
	@MapsId(value ="bookId")
	private Book book;

	private double rating;

	@Column(name = "rating_comment")
	private String ratingComment;
	

	public Rating() {}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Book getBook() {
		return book;
	}

	public void setBook(Book book) {
		this.book = book;
	}

	public RatingId getId() {
		return id;
	}

	public void setId(RatingId id) {
		this.id = id;
	}

	public double getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public String getRatingComment() {
		return ratingComment;
	}

	public void setRatingComment(String ratingComment) {
		this.ratingComment = ratingComment;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id, rating, ratingComment);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Rating other = (Rating) obj;
		return id == other.id && rating == other.rating && Objects.equals(ratingComment, other.ratingComment);
	}

	@Override
	public String toString() {
		return "Rating [id=" + id + ", rating=" + rating + ", ratingComment=" + ratingComment + "]";
	}

}