package com.softcustomer.perfectfit.activities;

import android.os.Bundle;
import android.support.v4.content.ContextCompat;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;

import com.alamkanak.weekview.MonthLoader;

import com.alamkanak.weekview.WeekViewEvent;
import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.activities.base.HomeButtonBase;
import com.softcustomer.perfectfit.models.Day;
import com.softcustomer.perfectfit.vendor.Factory;
import com.softcustomer.perfectfit.widget.support.WeekView;

//import com.softcustomer.perfectfit.widget.support.WeekView;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Random;

public class PlanActivity extends HomeButtonBase {
    private ArrayList<WeekViewEvent> events;
    private Day customDay;
    private WeekView mWeekView;
    private WeekViewEvent touchedEvent;
    private MenuItem bookingButton;
    private Calendar selectedTime;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        removeToolbarText();

        createEvents();

        customDay = getModel(Day.class);
        setWeekView();

        if (customDay == null)
            scrollToToday();
        else
            showCustomDay();
    }

    private void showCustomDay() {
        mWeekView.setNumberOfVisibleDays(1);
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(customDay.getFullDate());
        mWeekView.goToDate(calendar);
    }


    private void setWeekView() {

        mWeekView = findViewById(R.id.weekView);
        mWeekView.goToHour(7);
        mWeekView.setDefaultEventColor(getColour(R.color.colorAccent));
        mWeekView.setEmptyViewClickListener(new WeekView.EmptyViewClickListener() {
            @Override
            public void onEmptyViewClicked(Calendar time) {
                addSelection(time);
            }
        });

        mWeekView.setMonthChangeListener(new MonthLoader.MonthChangeListener() {

            @Override
            public List<? extends WeekViewEvent> onMonthChange(int newYear, int newMonth) {
                return getEvents(newYear, newMonth);
            }
        });
    }

    private void addSelection(Calendar time) {
        selectedTime = time;
        roundTime(time);
        Calendar endTime = Calendar.getInstance();
        endTime.setTime(time.getTime());
        endTime.add(Calendar.HOUR_OF_DAY, 2);
        if (events.contains(touchedEvent))
            events.remove(touchedEvent);

        touchedEvent = new WeekViewEvent(-1, "selection", time, endTime);
        touchedEvent.setColor(ContextCompat.getColor(PlanActivity.this, R.color.colorAlternative));
        events.add(touchedEvent);
        mWeekView.notifyDatasetChanged();
        showBookingButton();
    }

    private void roundTime(Calendar time) {
        int minute = time.get(Calendar.MINUTE);
        if (minute <= 15)
            time.set(Calendar.MINUTE, 1);
        else if (minute > 15 && minute <= 30)
            time.set(Calendar.MINUTE, 30);
        else if (minute > 30 && minute <= 45)
            time.set(Calendar.MINUTE, 45);
        else {
            time.set(Calendar.HOUR_OF_DAY, time.get(Calendar.HOUR_OF_DAY) + 1);
            time.set(Calendar.MINUTE, 1);
        }
    }

    private void showBookingButton() {
        if (bookingButton == null)
            return;
        bookingButton.setVisible(true);
    }

    private void scrollToToday() {
        Calendar today = Calendar.getInstance();
        mWeekView.goToDate(today);
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_plans, menu);

        bookingButton = menu.getItem(0);
        bookingButton.setVisible(false);
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        if (item == bookingButton) {
            startActivity(Factory.getIntent()
                    .from(PlanActivity.this)
                    .to(BookingActivity.class)
                    .with(Calendar.class.getName(), selectedTime)
                    .create());
        }
        return super.onOptionsItemSelected(item);
    }

    @Override
    protected boolean hasCustomToolbar() {
        return true;
    }


    private void createEvents() {
        events = new ArrayList<>();

        for (int i = 0; i < 120; i++) {
            Calendar startTime = Calendar.getInstance();
            Calendar endTime = Calendar.getInstance();
            startTime.add(Calendar.DATE, i);
            endTime.add(Calendar.DATE, i);
            int randomTime = new Random().nextInt(12) + 6;
            startTime.set(Calendar.HOUR_OF_DAY, randomTime);
            endTime.set(Calendar.HOUR_OF_DAY, randomTime + new Random().nextInt(2) + 1);
            Log.e("PlanAct", startTime.getTime().toString() + " end: " + endTime.getTime());
            startTime.set(Calendar.MINUTE, 0);
            endTime.set(Calendar.MINUTE, 0);
            events.add(new WeekViewEvent(i, "", startTime, endTime));
        }
    }

    private ArrayList<WeekViewEvent> getEvents(int newYear, int newMonth) {
        ArrayList<WeekViewEvent> shownEvents = new ArrayList<>();
        for (WeekViewEvent event : events) {
            int eventYear = event.getStartTime().get(Calendar.YEAR);
            int eventMonth = event.getStartTime().get(Calendar.MONTH) + 1;
            if (eventYear == newYear)
                if (eventMonth == newMonth)
                    shownEvents.add(event);
        }
        return shownEvents;
    }


    @Override
    protected int getContentView() {
        return R.layout.activity_plan;
    }
}
