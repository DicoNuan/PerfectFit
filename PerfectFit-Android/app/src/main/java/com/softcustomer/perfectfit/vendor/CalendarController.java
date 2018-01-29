package com.softcustomer.perfectfit.vendor;

import com.softcustomer.perfectfit.models.Day;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;


public class CalendarController {
    private Calendar startDate;
    private Calendar endDate;

    public CalendarController(Calendar startDate, Calendar endDate) {
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public ArrayList<Day> calculate() {
        ArrayList<Day> days = new ArrayList<>();
        GregorianCalendar calendar = new GregorianCalendar();

        calendar.setTime(startDate.getTime());
        Date dateStartBefore = calendar.getTime();
        calendar.setTime(endDate.getTime());
        Date dateEndAfter = calendar.getTime();

        Date date = dateStartBefore;
        while (!date.after(dateEndAfter)) {
            SimpleDateFormat sdf = new SimpleDateFormat("EEE");
            SimpleDateFormat sdf2 = new SimpleDateFormat("dd");
            Day day = new Day(sdf.format(date), sdf2.format(date));
            day.setFullDate(date);
            days.add(day);
            day.setToday(day.equals(Calendar.getInstance().getTime()));
            calendar.setTime(date);
            calendar.add(Calendar.DATE, 1);
            date = calendar.getTime();
        }

        return days;
    }
}
