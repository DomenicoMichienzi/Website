package com.example.website.jdbc;

import com.example.website.dao.BookDao;
import com.example.website.model.Book;
import com.example.website.model.LazyBook;
import com.example.website.utility.ReviewRating;
import org.springframework.data.util.Pair;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.*;
import java.util.ArrayList;
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
    public boolean check(String book_id) {
        try {
            String query = "select 1 from books where volume_id = ?";

            PreparedStatement pst = conn.prepareStatement(query);

            pst.setString(1, book_id);

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
                    "where volume_id = '" + book.getVolume_id() + "' AND " +
                    "username_id = '" + book.getUsername_id() + "'";

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

    @Override
    public List<ReviewRating> getReviewsAndRatings(String book_id) {

        ArrayList<ReviewRating> items = new ArrayList<ReviewRating>();

        try {
            String query = "select review, rating from books " +
                    "where volume_id = ?";

            PreparedStatement pst = conn.prepareStatement(query);

            pst.setString(1, book_id);

            ResultSet rs = pst.executeQuery();


            while (rs.next()) {
                String review = rs.getString("review");
                float rating = rs.getFloat("rating");
                    
                ReviewRating tmp = new ReviewRating(review, rating);
                items.add(tmp);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return items;
    }

    @Override
    public float avgRating(String book_id) {
        try {
            String query = "select avg(rating) from books where volume_id = ?";

            PreparedStatement pst = conn.prepareStatement(query);

            pst.setString(1, book_id);

            ResultSet rs = pst.executeQuery();

            if(rs.next()) {

                BigDecimal bigDecimalDouble = new BigDecimal(rs.getFloat("avg"));
                BigDecimal bigDecimalWithScale = bigDecimalDouble.setScale(1, RoundingMode.HALF_UP);
                return bigDecimalWithScale.floatValue();
                //return rs.getFloat("avg");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0F;
    }

    @Override
    // Return a List of book_id sorted by avg rating
    public List<LazyBook> sortedByAvg() {
        ArrayList<LazyBook> list = new ArrayList<>();
        try {
            String query = "select distinct volume_id, title from books";

            PreparedStatement pst = conn.prepareStatement(query);

            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                float avg_rating = avgRating(rs.getString("volume_id"));

                if(avg_rating != 0.0F) {
                    LazyBook tmp = new LazyBook();
                    tmp.setBook_id(rs.getString("volume_id"));
                    tmp.setTitle(rs.getString("title"));
                    tmp.setAvgRating(avg_rating);

                    list.add(tmp);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
}
