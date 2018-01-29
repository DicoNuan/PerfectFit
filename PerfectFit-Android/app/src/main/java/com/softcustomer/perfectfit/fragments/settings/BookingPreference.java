package com.softcustomer.perfectfit.fragments.settings;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.preference.ListPreference;
import android.preference.MultiSelectListPreference;
import android.preference.Preference;
import android.preference.PreferenceManager;
import android.util.Log;
import android.widget.Toast;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.models.Day;
import com.softcustomer.perfectfit.utils.DialogBuilder;
import com.softcustomer.perfectfit.widget.support.DateTimePreference;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashSet;
import java.util.Set;

public class BookingPreference extends BasePreference implements Preference.OnPreferenceChangeListener {
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        addPreferencesFromResource(R.xml.pref_booking);
        setHasOptionsMenu(true);

        if (mListener == null)
            return;

        //  bindDateAndTime();
        bindDate();

        mListener.bindSummary(findPreference("pref_booking_location"));
        mListener.bindSummary(findPreference("pref_booking_time_range"));
        mListener.bindSummary(findPreference("pref_booking_trainers"));
        mListener.bindSummary(findPreference("pref_booking_medical_history"));
        mListener.bindSummary(findPreference("pref_booking_promotion_code"));
        mListener.bindSummary(findPreference("pref_booking_total_price"));

        try {
            validateTimeSelection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void validateTimeSelection() {
        MultiSelectListPreference timeSelectionPreference = (MultiSelectListPreference) findPreference("pref_booking_time_range");
        final Preference.OnPreferenceChangeListener listener =
                timeSelectionPreference.getOnPreferenceChangeListener();
        timeSelectionPreference.setOnPreferenceChangeListener(new Preference.OnPreferenceChangeListener() {
            @Override
            public boolean onPreferenceChange(Preference preference, Object newValue) {
                onTimeSelectionChange(listener, (MultiSelectListPreference) preference, newValue);
                return true;
            }
        });
    }

    private void onTimeSelectionChange(Preference.OnPreferenceChangeListener listener, MultiSelectListPreference preference, Object newValue) {
        if (listener != null)
            listener.onPreferenceChange(preference, newValue);
        if (validate((Set<String>) newValue, preference))
            showConfirmDialog(listener, preference);
    }

    private void showConfirmDialog(final Preference.OnPreferenceChangeListener listener, final MultiSelectListPreference preference) {
        if (getActivity() == null)
            return;
        String desc = getString(R.string.message_not_continious_time_range);
        String title = getString(R.string.title_confirm_selection);

        AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
        builder.setTitle(title)
                .setMessage(desc)
                .setCancelable(false)
                .setPositiveButton("Okay", null)
                .setNegativeButton(getString(R.string.dialog_cancel), new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        if (preference != null)
                            preference.setValues(new HashSet<String>());

                        if (listener != null)
                            listener.onPreferenceChange(preference, new HashSet<String>());
                    }
                });
        builder.show();
    }

    private boolean validate(Set<String> newValue, MultiSelectListPreference preference) {
        ArrayList<Integer> indexes = new ArrayList<>();
        for (String v : newValue) {
            int index = preference.findIndexOfValue(v);
            indexes.add(index);
        }
        if (indexes.size() <= 1)
            return false;

        for (int i = 0; i < indexes.size(); i++) {
            if (!indexes.contains(indexes.get(i) + 1) && !indexes.contains(indexes.get(i) - 1))
                return true;
        }

        return false;
    }

    private void bindDate() {
        DateTimePreference date = (DateTimePreference) findPreference("pref_booking_date");

        if (getArguments() != null && getArguments().containsKey(Day.class.getName())) {
            Day day = (Day) getArguments().getSerializable(Day.class.getName());
            if (day == null) {
                Log.e("BookingPreference", "Calendar is null");
                return;
            }
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
            setPreferenceValue(date, dateFormat.format(day.getFullDate()));

            Calendar cl = Calendar.getInstance();
            cl.setTime(day.getFullDate());
            date.setDefaultDate(cl);
            date.setEnabled(false);
        }
        mListener.bindSummary(date);
    }

    private void bindDateAndTime() {
        DateTimePreference date = (DateTimePreference) findPreference("pref_booking_date");
        DateTimePreference startTime = (DateTimePreference) findPreference("pref_booking_start_time");
        DateTimePreference endTime = (DateTimePreference) findPreference("pref_booking_end_time");

        if (getArguments() != null && getArguments().containsKey(Day.class.getName())) {
            bindTimeFromArguments(date, startTime, endTime);
        }
        mListener.bindSummary(date);
        mListener.bindSummary(startTime);
        mListener.bindSummary(endTime);
    }

    private void bindTimeFromArguments(DateTimePreference date, DateTimePreference startTime, DateTimePreference endTime) {
        //Calendar calendar = (Calendar) getArguments().getSerializable(Calendar.class.getName());
        Day day = (Day) getArguments().getSerializable(Day.class.getName());
        if (day == null) {
            Log.e("BookingPreference", "Calendar is null");
            return;
        }

        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
        setPreferenceValue(date, dateFormat.format(day.getFullDate()));
        Calendar cl = Calendar.getInstance();
        cl.setTime(day.getFullDate());
        date.setDefaultDate(cl);
        date.setEnabled(false);
        Log.e("BookingPreference", cl.toString());
        setPreferenceValue(startTime, timeFormat.format(cl.getTime()));
        startTime.setDefaultTime(cl);
        // calendar.add(Calendar.HOUR, 2);
        // endTime.setDefaultTime(calendar);
        //  setPreferenceValue(endTime, timeFormat.format(calendar.getTime()));
    }

    private void setPreferenceValue(Preference preference, String value) {
        if (getActivity() == null)
            return;

        PreferenceManager.getDefaultSharedPreferences(getActivity())
                .edit()
                .putString(preference.getKey(), value)
                .commit();
    }

    @Override
    public boolean onPreferenceChange(Preference preference, Object newValue) {

        return false;
    }
}
