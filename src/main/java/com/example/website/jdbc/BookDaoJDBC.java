package com.example.website.jdbc;

import com.example.website.dao.BookDao;
import com.example.website.model.Book;

import java.sql.*;
import java.util.List;

public class BookDaoJDBC implements BookDao{

    private final Connection conn;

    public BookDaoJDBC(Connection conn) {
        this.conn = conn;
    }

    @Override
    public List<Book> getAll() {
        return null;
    }

    @Override
    public Book getByKey(String volume_id) {
        return null;
    }

    @Override
    public boolean check(Book book) {
        try {
            String query = "select 1 from books where username_id = ? AND volume_id = ?";

            PreparedStatement pst = conn.prepareStatement(query);

            pst.setString(1, book.getUsername_id());
            pst.setString(2, book.getVolume_id());

            ResultSet rs = pst.executeQuery();

            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean save(Book book) {
        try {
            String query = "insert into books (volume_id, " +
                    "username_id, " +
                    "title, " +
                    "link, " +
                    "description, " +
                    "review, " +
                    "rating, " +
                    "comment) values (?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement pst = conn.prepareStatement(query);

            pst.setString(1, book.getVolume_id());
            pst.setString(2, book.getUsername_id());
            pst.setString(3, book.getTitle());
            pst.setString(4, book.getLink());
            pst.setString(5, book.getDescription());
            pst.setString(6, book.getReview());
            pst.setFloat(7, book.getRating());
            pst.setString(8, book.getComment());

            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
            }
        return true;
    }

    @Override
    public boolean update(Book book) {
        try {
            String query = "update books " +
                    "set review = ?, " +
                    "rating = ?, " +
                    "comment = ? " +
                    "where volume_id = '" + book.getVolume_id() + "'";

            PreparedStatement pst = conn.prepareStatement(query);

            pst.setString(1, book.getReview());
            pst.setFloat(2, book.getRating());
            pst.setString(3, book.getComment());

            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    @Override
    public boolean delete(String book_id, String username_id) {

        try {
            String query = "delete from books " +
                    "where volume_id = ? AND " +
                    "username_id = ?";

            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, book_id);
            pst.setString(2, username_id);

            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }
}
