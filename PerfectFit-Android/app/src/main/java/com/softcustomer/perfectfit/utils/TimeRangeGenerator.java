package com.softcustomer.perfectfit.utils;

import android.util.Log;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashSet;
import java.util.Set;


public class TimeRangeGenerator {


    private String[] createTimeEntries() {
        String[] entries = new String[24];
        for (int i = 0; i < 24; i++) {
            entries[i] = createTime(i);
        }
        return entries;
    }

    private Set<String> createTimeValues() {
        Set<String> set = new HashSet<>();
        for (int i = 0; i < 24; i++) {
            set.add(createTime(i));
        }
        return set;
    }

    private String createTime(int i) {
        SimpleDateFormat sdf = new SimpleDateFormat("hh:mm a");
        Calendar startHour = Calendar.getInstance();
        startHour.set(Calendar.MINUTE, 0);
        Calendar endHour = Calendar.getInstance();
        endHour.set(Calendar.MINUTE, 0);
        startHour.set(Calendar.HOUR_OF_DAY, i);
        endHour.set(Calendar.HOUR_OF_DAY, i + 1);
        return sdf.format(startHour.getTime()) + " - " + sdf.format(endHour.getTime());
    }

}
