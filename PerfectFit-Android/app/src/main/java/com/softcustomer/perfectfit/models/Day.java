package com.softcustomer.perfectfit.models;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;


public class Day extends Model implements Serializable {
    private String day, date;
    private Date fullDate;
    private boolean isToday = false;
    private int busyness;

    public Day(String day, String date) {
        this.day = day;
        this.date = date;
        this.busyness = new Random().nextInt(6);
    }

    public int getBusyness() {
        return busyness;
    }

    public void setBusyness(int busyness) {
        this.busyness = busyness;
    }

    public boolean isToday() {
        return isToday;
    }

    public void setToday(boolean today) {
        isToday = today;
    }

    public String getDay() {
        return day;
    }

    public void setDay(String day) {
        this.day = day;
    }

    public String getDate() {
        return date;
    }

    public String getFormattedDate() {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        return sdf.format(fullDate);
    }

    @Override
    public boolean equals(Object obj) {
        Calendar cal1 = Calendar.getInstance();
        Calendar cal2 = Calendar.getInstance();
        cal1.setTime(fullDate);
        cal2.setTime((Date) obj);
        return cal1.get(Calendar.YEAR) == cal2.get(Calendar.YEAR) &&
                cal1.get(Calendar.DAY_OF_YEAR) == cal2.get(Calendar.DAY_OF_YEAR);
    }

    public void setFullDate(Date fullDate) {
        this.fullDate = fullDate;
    }

    public Date getFullDate() {
        return fullDate;
    }

    public void setDate(String date) {
        this.date = date;
    }

}
