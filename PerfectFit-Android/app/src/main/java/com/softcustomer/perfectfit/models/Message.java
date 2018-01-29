package com.softcustomer.perfectfit.models;

import android.text.format.DateUtils;

import org.ocpsoft.prettytime.PrettyTime;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;


public class Message extends Model {

    private String message;
    private Date date;
    private boolean isLocal = true;

    public Message(String message, Date date) {
        super();
        this.message = message;
        this.date = date;
    }

    public Message(String message, Date date, boolean isLocal) {
        super();
        this.message = message;
        this.date = date;
        this.isLocal = isLocal;
    }

    public String getFormatedTimeStamp() {

        SimpleDateFormat simpleDateFormat;
        if (DateUtils.isToday(date.getTime()))
            simpleDateFormat = new SimpleDateFormat("HH:mm");
        else
            simpleDateFormat = new SimpleDateFormat("dd/MM HH:mm");

        return simpleDateFormat.format(date);
    }

    public String getFormattedDate() {
        PrettyTime formatter = new PrettyTime(new Locale("en"));
        return formatter.format(this.date);
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public boolean isLocal() {
        return isLocal;
    }

    public void setLocal(boolean local) {
        isLocal = local;
    }
}
