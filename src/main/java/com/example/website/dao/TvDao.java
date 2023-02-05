package com.example.website.dao;

import com.example.website.model.Tv;

import java.util.List;

public interface TvDao {
    List<Tv> getAll();
    boolean check(Tv tv);
    boolean check(String tv_id);
    boolean save(Tv tv);
    boolean update(Tv tv);
    boolean delete(String tv_id, String username_id);
}
