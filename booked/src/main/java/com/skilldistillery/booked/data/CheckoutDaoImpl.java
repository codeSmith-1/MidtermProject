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
	public boolean reviewCheckout(int cid, boolean approved) {
		Checkout checkout = em.find(Checkout.class, cid);
		boolean bool;
		if (approved) {
			checkout.setCheckoutDate(LocalDate.now());
			checkout.getShelfBook().setForBorrow(false);
			em.persist(checkout);
			bool = true;
		} else {
			checkout.getShelfBook().setForBorrow(true);
			em.remove(checkout);
			bool = false;
		}
		return bool;
	}

	@Override
	public Checkout receiveCheckout(int cid) {
		Checkout checkout = em.find(Checkout.class, cid);
		checkout.setReturnDate(LocalDate.now());
		checkout.getShelfBook().setForBorrow(true);
		return checkout;
	}

//	@Override
//	public boolean setForBorrow(int cid, boolean bool) {
//		Checkout checkout = em.find(Checkout.class, cid);
//		ShelfBook sb = checkout.getShelfBook();
//		sb.setForBorrow(bool);
//		em.persist(sb);
//		// remove checkout requestDate
//		return true;
//	}

	@Override
	public boolean checkoutHasCheckoutRequestFromUserId(int uid, int sbid) {
//		String sql = "SELECT c FROM Checkout c WHERE c.user.id = :uid AND c.shelfBook.id = :sbid AND c.returnDate IS NULL";
		String sql = "SELECT c FROM Checkout c WHERE c.user.id = :uid AND c.shelfBook.id = :sbid "
				+ "AND c.requestDate IS NOT NULL AND c.checkoutDate IS NULL";
		List<Checkout> checkouts = em.createQuery(sql, Checkout.class).setParameter("sbid", sbid)
				.setParameter("uid", uid).getResultList();
		return checkouts.size() > 0;
	}

	@Override
	public boolean checkoutApprovedForUserByOwner(int uid, int sbid) {
		String sql = "SELECT c FROM Checkout c WHERE c.user.id = :uid AND c.shelfBook.id = :sbid "
				+ "AND c.requestDate IS NOT NULL AND c.checkoutDate IS NOT NULL AND c.returnDate IS NULL";
		List<Checkout> checkouts = em.createQuery(sql, Checkout.class).setParameter("sbid", sbid)
				.setParameter("uid", uid).getResultList();
		return checkouts.size() > 0;
	}
	
	@Override
	public List<Checkout> userHasApprovedCheckouts(int uid) {
		String sql = "SELECT c FROM Checkout c WHERE c.user.id = :uid AND c.requestDate IS NOT NULL "
				+ "AND c.checkoutDate IS NOT NULL AND c.returnDate IS NULL";
		List<Checkout> checkouts = em.createQuery(sql, Checkout.class)
				.setParameter("uid", uid).getResultList();
		return checkouts;
	}
	
}
