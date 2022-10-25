package com.skilldistillery.booked.entities;

import java.time.LocalDate;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import org.hibernate.annotations.CreationTimestamp;

@Entity
public class Checkout {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	@CreationTimestamp
	@Column(name="request_date")
	private LocalDate requestDate;
	
	@Column(name="return_date")
	private LocalDate returnDate;
	
	@Column(name="request_message")
	private String requestMessage;
	
	@Column(name="checkout_date")
	private LocalDate checkoutDate;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
	@ManyToOne
	@JoinColumn(name="shelf_book_id")
	private ShelfBook shelfBook;
	
	public Checkout() {}
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public LocalDate getRequestDate() {
		return requestDate;
	}
	
	public void setRequestDate(LocalDate requestDate) {
		this.requestDate = requestDate;
	}
	
	public LocalDate getReturnDate() {
		return returnDate;
	}
	
	public void setReturnDate(LocalDate returnDate) {
		this.returnDate = returnDate;
	}
	
	public String getRequestMessage() {
		return requestMessage;
	}
	
	public void setRequestMessage(String requestMessage) {
		this.requestMessage = requestMessage;
	}
	
	public LocalDate getCheckoutDate() {
		return checkoutDate;
	}
	
	public void setCheckoutDate(LocalDate checkoutDate) {
		this.checkoutDate = checkoutDate;
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public ShelfBook getShelfBook() {
		return shelfBook;
	}

	public void setShelfBook(ShelfBook shelfBook) {
		this.shelfBook = shelfBook;
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
		Checkout other = (Checkout) obj;
		return id == other.id;
	}
	
	@Override
	public String toString() {
		return "Checkout [id=" + id + ", requestDate=" + requestDate + ", returnDate=" + returnDate
				+ ", requestMessage=" + requestMessage + ", checkoutDate=" + checkoutDate + "]";
	}
	
}
