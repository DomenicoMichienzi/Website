package com.example.website.jdbc;

import com.example.website.dao.MovieDao;
import com.example.website.model.Book;
import com.example.website.model.LazyBook;
import com.example.website.model.LazyMovie;
import com.example.website.model.Movie;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MovieDaoJDBC implements MovieDao {
    private final Connection conn;
    public MovieDaoJDBC(Connection conn) { this.conn = conn; }
    @Override
    public List<Movie> getAll() {
        return null;
    }

    @Override
    public boolean check(Movie movie) {
        try {
            String query = "select 1 from movies where username_id = ? AND movie_id = ?";

            PreparedStatement pst = conn.prepareStatement(query);

            pst.setString(1, movie.getUsername_id());
            pst.setString(2, movie.getMovie_id());

            ResultSet rs = pst.executeQuery();

            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean check(String movie_id) {
        try {
            String query = "select 1 from movies where movie_id = ?";

            PreparedStatement pst = conn.prepareStatement(query);

            pst.setString(1, movie_id);

            ResultSet rs = pst.executeQuery();

            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean save(Movie movie) {
        try {
            String query = "insert into movies (movie_id, " +
                    "username_id, " +
                    "title, " +
                    "description, " +
                    "review, " +
                    "rating, " +
                    "comment) values (?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement pst = conn.prepareStatement(query);

            pst.setString(1, movie.getMovie_id());
            pst.setString(2, movie.getUsername_id());
            pst.setString(3, movie.getTitle());
            pst.setString(4, movie.getDescription());
            pst.setString(5, movie.getReview());
            pst.setFloat(6, movie.getRating());
            pst.setString(7, movie.getComment());

            // Execute query
            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    @Override
    public boolean update(Movie movie) {
        try {
            String query = "update movies " +
                    "set review = ?, " +
                    "rating = ?, " +
                    "comment = ? " +
                    "where movie_id = '" + movie.getMovie_id() + "' AND " +
                    "username_id = '" + movie.getUsername_id() + "'";

            PreparedStatement pst = conn.prepareStatement(query);

            pst.setString(1, movie.getReview());
            pst.setFloat(2, movie.getRating());
            pst.setString(3, movie.getComment());

            // Execute query
            pst.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    @Override
    public boolean delete(String movie_id, String username_id) {
        try {
            String query = "delete from movies " +
                    "where movie_id = ? AND " +
                    "username_id = ?";

            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, movie_id);
            pst.setString(2, username_id);

            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    @Override
    public float avgRating(String movie_id) {
        try {
            String query = "select avg(rating) from movies where movie_id = ?";

            PreparedStatement pst = conn.prepareStatement(query);

            pst.setString(1, movie_id);

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
    public List<LazyMovie> sortedByAvg() {
        ArrayList<LazyMovie> list = new ArrayList<>();
        try {
            String query = "select distinct movie_id, title from movies";

            PreparedStatement pst = conn.prepareStatement(query);

            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                float avg_rating = avgRating(rs.getString("movie_id"));

                if(avg_rating != 0.0F) {
                    LazyMovie tmp = new LazyMovie();
                    tmp.setMovie_id(rs.getString("movie_id"));
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

    @Override
    public List<Movie> getReviewsAndRatings(String movie_id) {
        ArrayList<Movie> items = new ArrayList<>();

        try {
            String query = "select review, rating, title, description, username_id from movies " +
                    "where movie_id = ?";

            PreparedStatement pst = conn.prepareStatement(query);

            pst.setString(1, movie_id);

            ResultSet rs = pst.executeQuery();


            while (rs.next()) {
                String review = rs.getString("review");
                float rating = rs.getFloat("rating");

                Movie tmp = new Movie();

                tmp.setTitle(rs.getString("title"));
                tmp.setDescription(rs.getString("description"));
                tmp.setReview(rs.getString("review"));
                tmp.setRating(rs.getFloat("rating"));
                tmp.setUsername_id(rs.getString("username_id"));

                // add to the ArrayList
                items.add(tmp);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return items;
    }
}
