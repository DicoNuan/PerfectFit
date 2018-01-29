package com.softcustomer.perfectfit.models;

/**
 * Created by rahim on 28/08/17.
 */

public class Review extends Model {
    private String trainer;
    private String trainerImage;
    private String review;
    private float overall;
    private float punctuality;
    private float courteousness;
    private float performance;

    public Review(String trainer, String trainerImage, String review, float overall) {
        this.trainer = trainer;
        this.trainerImage = trainerImage;
        this.review = review;
        this.overall = overall;
    }

    public Review(String trainer, String trainerImage, String review, float overall, float punctuality, float courteousness, float performance) {
        this.trainer = trainer;
        this.trainerImage = trainerImage;
        this.review = review;
        this.overall = overall;
        this.punctuality = punctuality;
        this.courteousness = courteousness;
        this.performance = performance;
    }

    public String getTrainer() {
        return trainer;
    }

    public void setTrainer(String trainer) {
        this.trainer = trainer;
    }

    public String getTrainerImage() {
        return trainerImage;
    }

    public void setTrainerImage(String trainerImage) {
        this.trainerImage = trainerImage;
    }

    public String getReview() {
        return review;
    }

    public void setReview(String review) {
        this.review = review;
    }

    public float getOverall() {
        return overall;
    }

    public void setOverall(float overall) {
        this.overall = overall;
    }

    public float getPunctuality() {
        return punctuality;
    }

    public void setPunctuality(float punctuality) {
        this.punctuality = punctuality;
    }

    public float getCourteousness() {
        return courteousness;
    }

    public void setCourteousness(float courteousness) {
        this.courteousness = courteousness;
    }

    public float getPerformance() {
        return performance;
    }

    public void setPerformance(float performance) {
        this.performance = performance;
    }
}
