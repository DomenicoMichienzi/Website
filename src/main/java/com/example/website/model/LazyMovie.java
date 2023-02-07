package com.example.website.model;

public class LazyMovie implements Comparable<LazyMovie> {
    private String movie_id;
    private String title;
    private float avgRating;

    public String getMovie_id() {
        return movie_id;
    }

    public void setMovie_id(String movie_id) {
        this.movie_id = movie_id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public float getAvgRating() {
        return avgRating;
    }

    public void setAvgRating(float avgRating) {
        this.avgRating = avgRating;
    }

    @Override
    public int compareTo(LazyMovie u) {
        if (getAvgRating() == 0.0F || u.getAvgRating() == 0.0F) {
            return 0;
        }
        return Float.compare(getAvgRating(), u.getAvgRating());
    }
}
