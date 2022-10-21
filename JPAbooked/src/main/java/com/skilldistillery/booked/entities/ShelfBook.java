package com.skilldistillery.booked.entities;

import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class ShelfBook {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	@Column(name="for_borrow")
	private boolean forBorrow;
	@Column(name="for_sale")
	private boolean forSale;
	@Column(name="sale_price")
	private double salePrice;
	
	public ShelfBook() {}

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
