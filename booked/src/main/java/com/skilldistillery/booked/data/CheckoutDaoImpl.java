package com.skilldistillery.booked.data;

import java.time.LocalDate;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.booked.entities.Checkout;
import com.skilldistillery.booked.entities.ShelfBook;
@Transactional
@Service
public class CheckoutDaoImpl implements CheckoutDAO {
	
	@PersistenceContext
	private EntityManager em;
	
	@Override
	public Checkout findCheckoutById(int id) {
		return em.find(Checkout.class, id);
	}
	@Override
	public List<Checkout> findCheckOutsByUserId(int id) {
		String sql = "SELECT c FROM Checkout c WHERE checkout.user.id = :uid";
		return em.createQuery(sql, Checkout.class).setParameter("uid", id).getResultList();
	}
	
	@Override
	public Checkout createCheckout(Checkout checkout) {
		if (checkout != null) {
			em.persist(checkout);
		}
		return checkout;
	}
	
	@Override
	public Checkout reviewCheckout(int cid, boolean approved) {
		Checkout checkout = em.find(Checkout.class, cid);
		if (approved) {
		checkout.setCheckoutDate(LocalDate.now());
		em.persist(checkout);
		} else {
			em.remove(checkout);
		}
		return checkout;
	}
	
	@Override
	public Checkout receiveCheckout(int cid) {
		Checkout checkout = em.find(Checkout.class, cid);
		checkout.setReturnDate(LocalDate.now());
		setForBorrow(cid, true);
		return checkout;
	}
	
	@Override
	public boolean setForBorrow(int cid, boolean bool) {
		Checkout checkout = em.find(Checkout.class, cid);
		ShelfBook sb = checkout.getShelfBook();
		sb.setForBorrow(bool);
		em.persist(sb);
		return true;
	}
}
