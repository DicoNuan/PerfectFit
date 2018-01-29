package com.softcustomer.perfectfit.models;

/**
 * Created by rahim on 25/08/17.
 */

public class Session extends Model {

    private String trainer;
    private String activity;
    private String date;
    private String startTime;
    private String endTime;

    public Session(String trainer, String activity, String date, String startTime, String endTime) {
        this.trainer = trainer;
        this.activity = activity;
        this.date = date;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public String getTrainer() {
        return trainer;
    }

    public void setTrainer(String trainer) {
        this.trainer = trainer;
    }

    public String getActivity() {
        return activity;
    }

    public void setActivity(String activity) {
        this.activity = activity;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }
}
