package com.example.website.jdbc;

import com.example.website.dao.TvDao;
import com.example.website.model.Tv;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class TvDaoJDBC implements TvDao {
    private final Connection conn;

    public TvDaoJDBC(Connection conn) {
        this.conn = conn;
    }


    @Override
    public List<Tv> getAll() {
        return null;
    }

    @Override
    public boolean check(Tv tv) {
        try {
            String query = "select 1 from tvs where username_id = ? AND tv_id = ?";

            PreparedStatement pst = conn.prepareStatement(query);

            pst.setString(1, tv.getUsername_id());
            pst.setString(2, tv.getTv_id());

            ResultSet rs = pst.executeQuery();

            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean check(String tv_id) {
        try {
            String query = "select 1 from tvs where tv_id = ?";

            PreparedStatement pst = conn.prepareStatement(query);

            pst.setString(1, tv_id);

            ResultSet rs = pst.executeQuery();

            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean save(Tv tv) {
        try {
            String query = "insert into tvs (tv_id, " +
                    "username_id, " +
                    "title, " +
                    "description, " +
                    "review, " +
                    "rating, " +
                    "comment) values (?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement pst = conn.prepareStatement(query);

            pst.setString(1, tv.getTv_id());
            pst.setString(2, tv.getUsername_id());
            pst.setString(3, tv.getTitle());
            pst.setString(4, tv.getDescription());
            pst.setString(5, tv.getReview());
            pst.setFloat(6, tv.getRating());
            pst.setString(7, tv.getComment());

            pst.executeQuery();

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    @Override
    public boolean update(Tv tv) {
        try {
            String query = "update tvs " +
                    "set review = ?, " +
                    "rating = ?, " +
                    "comment = ? " +
                    "where tv_id = ? AND " +
                    "username_id = ?";

            PreparedStatement pst = conn.prepareStatement(query);

            pst.setString(1, tv.getReview());
            pst.setFloat(2, tv.getRating());
            pst.setString(3, tv.getComment());

            pst.setString(4, tv.getTv_id());
            pst.setString(5, tv.getUsername_id());

            // Execute query
            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    @Override
    public boolean delete(String tv_id, String username_id) {
        try {
            String query = "delete from tvs " +
                    "where tv_id = ? AND " +
                    "username_id = ?";

            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, tv_id);
            pst.setString(2, username_id);

            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
}
