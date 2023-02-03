package com.example.website.dao;

import com.example.website.model.Book;
import com.example.website.utility.ReviewRating;

import java.util.List;

public interface BookDao {
    List<Book> getAll();
    boolean check(Book book);  // check if the book (including username_id) is already in the library
    boolean check(String book_id); // check if a book is in the library
    boolean save(Book book);
    boolean update(Book book);
    //boolean update(Book book);
    boolean delete(String book_id, String username_id);
    List<ReviewRating> getReviewsAndRatings(String book_id);
}
