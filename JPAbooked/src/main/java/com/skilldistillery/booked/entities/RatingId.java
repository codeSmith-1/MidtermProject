package com.skilldistillery.booked.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class RatingId implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Column(name="user_id")
	private int userId;
	
	@Column(name="book_id")
	private int bookId;
	
	public RatingId() {}

	public RatingId(int userId, int bookId) {
		super();
		this.userId = userId;
		this.bookId = bookId;
	}

	@Override
	public int hashCode() {
		return Objects.hash(bookId, userId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		RatingId other = (RatingId) obj;
		return bookId == other.bookId && userId == other.userId;
	}

	@Override
	public String toString() {
		return "RatingId [userId=" + userId + ", bookId=" + bookId + "]";
	}
	
}
