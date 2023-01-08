package com.example.website.model;

public class Movie {
    private String movie_id;
    private String username_id;
    private String title;
    private String comment;
    private String description;
    private boolean viewed;
    private short stars;

    public String getMovie_id() {
        return movie_id;
    }

    public void setMovie_id(String movie_id) {
        this.movie_id = movie_id;
    }

    public String getUsername_id() {
        return username_id;
    }

    public void setUsername_id(String username_id) {
        this.username_id = username_id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isViewed() {
        return viewed;
    }

    public void setViewed(boolean viewed) {
        this.viewed = viewed;
    }

    public short getStars() {
        return stars;
    }

    public void setStars(short stars) {
        this.stars = stars;
    }

    public Movie() {
    }
}
