package com.skilldistillery.booked.data;

import java.util.List;

import com.skilldistillery.booked.entities.ShelfBook;

public interface ShelfBookDAO {
	
	List<ShelfBook> findAllShelfBooks();
	List<ShelfBook> findShelfBooksByKeyword(String keyword);
	List<ShelfBook> findShelfBooksByOwnerId(int ownerId);
	ShelfBook findShelfBookById(int id);
	
}
