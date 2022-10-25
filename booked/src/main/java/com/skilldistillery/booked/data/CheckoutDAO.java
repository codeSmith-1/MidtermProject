package com.skilldistillery.booked.data;

import java.util.List;

import com.skilldistillery.booked.entities.Checkout;
import com.skilldistillery.booked.entities.ShelfBook;
import com.skilldistillery.booked.entities.User;

public interface CheckoutDAO {
	Checkout findCheckoutById(int id);
	List<Checkout> findCheckOutsByUserId(int uid);
	Checkout createCheckout(Checkout checkout);
	Checkout reviewCheckout(int cid, boolean approved);
	Checkout receiveCheckout(int cid);
	boolean setForBorrow(int cid, boolean bool);
}
