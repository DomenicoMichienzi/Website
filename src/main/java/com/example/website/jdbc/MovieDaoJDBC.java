package com.example.website.jdbc;

import com.example.website.dao.MovieDao;
import com.example.website.model.Movie;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class MovieDaoJDBC implements MovieDao {
    private Connection conn;
    public MovieDaoJDBC(Connection conn) { this.conn = conn; }
    @Override
    public List<Movie> getAll() {
        return null;
    }

    @Override
    public Movie getByKey(String movie_id) {
        return null;
    }

    @Override
    public boolean save(Movie movie) {

        try {
            String query = "insert into movies (movie_id, " +
                    "title, " +
                    "viewed, " +
                    "stars, " +
                    "description, " +
                    "comment, " +
                    "username_id) values (?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement pst = conn.prepareStatement(query);

            pst.setString(1, movie.getMovie_id());
            pst.setString(2, movie.getTitle());
            pst.setBoolean(3, movie.isViewed());
            pst.setShort(4, movie.getStars());
            pst.setString(5, movie.getDescription());
            pst.setString(6, movie.getComment());
            pst.setString(7, movie.getUsername_id());

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
                    "set viewed = ?," +
                    "set comment = ?," +
                    "set stars = ? " +
                    "where movie_id = " + movie.getMovie_id();

            PreparedStatement pst = conn.prepareStatement(query);

            pst.setBoolean(1, movie.isViewed());
            pst.setString(2, movie.getComment());
            pst.setShort(3,movie.getStars());

            pst.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    @Override
    public boolean delete(String movie_id) {
        try {
            String query = "delete from movies " +
                    "where movie_id = " + movie_id;

            PreparedStatement pst = conn.prepareStatement(query);
            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
}
