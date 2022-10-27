package com.skilldistillery.booked.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "shelf_book")
public class ShelfBook {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	
	@OneToMany(mappedBy = "shelfBook", cascade = CascadeType.REMOVE)
	private List<Checkout> checkouts;

	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;

	@ManyToOne
	@JoinColumn(name = "book_id")
	private Book book;
	
	@ManyToOne
	@JoinColumn(name="book_condition_id")
	private BookCondition condition;
	
	@Column(name = "for_borrow")
	private boolean forBorrow;
	
	@Column(name = "for_sale")
	private boolean forSale;
	
	@Column(name = "sale_price")
	private Double salePrice;

	public ShelfBook() {}
	
	public List<Checkout> getActiveRequests(){
		List<Checkout> requests = new ArrayList<>();
		if (checkouts != null) {
			for (Checkout checkout : checkouts) {
				if (checkout.getReturnDate() == null && checkout.getCheckoutDate()== null) {
					requests.add(checkout);
				}
			}
		}
		return requests;
		
	}

	public List<Checkout> getCheckouts() {
		return checkouts;
	}

	public void setCheckouts(List<Checkout> checkouts) {
		this.checkouts = checkouts;
	}

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

	public BookCondition getCondition() {
		return condition;
	}

	public void setCondition(BookCondition condition) {
		this.condition = condition;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public boolean isForBorrow() {
		return forBorrow;
	}

	public void setForBorrow(boolean forBorrow) {
		this.forBorrow = forBorrow;
	}

	public boolean isForSale() {
		return forSale;
	}

	public void setForSale(boolean forSale) {
		this.forSale = forSale;
	}

	public double getSalePrice() {
		return salePrice;
	}

	public void setSalePrice(double salePrice) {
		this.salePrice = salePrice;
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
		ShelfBook other = (ShelfBook) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "ShelfBook [id=" + id + ", forBorrow=" + forBorrow + ", forSale=" + forSale + ", salePrice=" + salePrice
				+ "]";
	}

}
