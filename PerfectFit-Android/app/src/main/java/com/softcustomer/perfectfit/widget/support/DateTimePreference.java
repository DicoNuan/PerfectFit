package com.softcustomer.perfectfit.widget.support;


import android.app.Activity;
import android.app.FragmentManager;
import android.content.Context;
import android.content.res.TypedArray;
import android.os.Bundle;
import android.preference.DialogPreference;
import android.text.TextUtils;
import android.util.AttributeSet;
import android.util.Log;

import com.rahimlis.materialdaterangepicker.date.DatePickerDialog;
import com.rahimlis.materialdaterangepicker.time.RadialPickerLayout;
import com.rahimlis.materialdaterangepicker.time.TimePickerDialog;
import com.softcustomer.perfectfit.R;


import java.sql.Time;
import java.util.Calendar;


public class DateTimePreference extends DialogPreference implements DatePickerDialog.OnDateSetListener, TimePickerDialog.OnTimeSetListener, TimePickerDialog.OnTabChangeListener {

    private DatePickerDialog datePickerDialog;
    private TimePickerDialog timePickerDialog;

    public static final int TYPE_DATE = 1;
    public static final int TYPE_TIME = 2;
    protected String dateTime;
    protected boolean dateTimeSet = false;
    protected int type;
    protected FragmentManager fragmentManager;


    public DateTimePreference(Context context, AttributeSet attrs) {
        super(context, attrs);
        TypedArray a = context.getTheme().obtainStyledAttributes(attrs, R.styleable.DateTimePreference, 0, 0);
        if (a.hasValue(R.styleable.DateTimePreference_type))
            type = a.getInt(R.styleable.DateTimePreference_type, TYPE_DATE);

        Calendar now = Calendar.getInstance();
        datePickerDialog = DatePickerDialog.newInstance(this,
                now.get(Calendar.YEAR),
                now.get(Calendar.MONTH),
                now.get(Calendar.DAY_OF_MONTH));
        datePickerDialog.setOnDismissListener(this);


        timePickerDialog = TimePickerDialog.newInstance(this, 0, 0, true);
        timePickerDialog.setOnTabChangeListener(this);
        fragmentManager = ((Activity) getContext()).getFragmentManager();
    }

    public void setDefaultTime(Calendar time) {
        timePickerDialog.initialize(this,
                time.get(Calendar.HOUR_OF_DAY),
                time.get(Calendar.MINUTE),
                time.get(Calendar.HOUR_OF_DAY) + 1,
                time.get(Calendar.MINUTE),
                true
        );
    }


    public void setDefaultDate(Calendar date) {
        datePickerDialog.initialize(this,
                date.get(Calendar.YEAR),
                date.get(Calendar.MONTH),
                date.get(Calendar.DAY_OF_MONTH));
    }


    public void setDateTime(String dateTime) {
        final boolean changed = !TextUtils.equals(this.dateTime, dateTime);
        if (changed || !dateTimeSet) {
            this.dateTime = dateTime;
            dateTimeSet = true;
            persistString(dateTime);
            if (changed) {
                notifyDependencyChange(shouldDisableDependents());
                notifyChanged();
            }
        }
    }


    @Override
    public void onTabChange(String tab) {
        if (timePickerDialog == null)
            return;

        int endHours = timePickerDialog.getTimePicker().getHours() + 1;
        int endMinutes = timePickerDialog.getTimePicker().getMinutes();

        timePickerDialog.getEndTimePicker().setTime(endHours, endMinutes);
    }


    @Override
    public void onTimeSet(RadialPickerLayout view, int hourOfDay, int minute, int hourOfDayEnd, int minuteEnd) {

        Log.e("DateTimePref", "OnTimeSet: h: " + hourOfDay + " hE: " + hourOfDayEnd);
        Time time = new Time(hourOfDay, minute, 0);
        Time endTime = new Time(hourOfDayEnd, minuteEnd, 0);
        String summary = removeSeconds(time.toString()) + " - " + removeSeconds(endTime.toString());
        setDateTime(summary);
        setSummary(summary);
        callChangeListener(summary);
    }

    private String removeSeconds(String time) {
        return time.substring(0, time.lastIndexOf(":"));
    }

    @Override
    public void onDateSet(DatePickerDialog view, int year, int monthOfYear, int dayOfMonth, int yearEnd, int monthOfYearEnd, int dayOfMonthEnd) {
        String newValue = dayOfMonth + "/" + monthOfYear + "/" + year;
        setDateTime(newValue);
        callChangeListener(newValue);
    }


/*
    @Override
    public void onDateSet(DatePickerDialog view, int year, int monthOfYear, int dayOfMonth) {
        String newValue = dayOfMonth + "/" + monthOfYear + "/" + year;
        setDateTime(newValue);
        callChangeListener(newValue);
    }
*/

    @Override
    protected void showDialog(Bundle state) {
        if (type == TYPE_DATE)
            datePickerDialog.show(fragmentManager, "DATE");
        else if (type == TYPE_TIME)
            timePickerDialog.show(fragmentManager, "TIME");
    }

}
