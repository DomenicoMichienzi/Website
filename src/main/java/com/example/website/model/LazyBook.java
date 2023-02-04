package com.example.website.model;

public class LazyBook implements Comparable<LazyBook> {
    private String book_id;
    private String title;
    private float avgRating;

    public String getBook_id() {
        return book_id;
    }

    public void setBook_id(String book_id) {
        this.book_id = book_id;
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
    public int compareTo(LazyBook u) {
        if (getAvgRating() == 0.0F || u.getAvgRating() == 0.0F) {
            return 0;
        }
        return Float.compare(getAvgRating(), u.getAvgRating());
    }
}
