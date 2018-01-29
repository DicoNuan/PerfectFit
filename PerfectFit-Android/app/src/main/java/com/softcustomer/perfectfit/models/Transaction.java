package com.softcustomer.perfectfit.models;

/**
 * Created by rahim on 25/08/17.
 */

public class Transaction extends Model {
    private String price;
    private String trainer;
    private String date;

    public Transaction(String price, String trainer, String date) {
        this.price = price;
        this.trainer = trainer;
        this.date = date;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getTrainer() {
        return trainer;
    }

    public void setTrainer(String trainer) {
        this.trainer = trainer;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
}
