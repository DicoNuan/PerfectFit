package com.softcustomer.perfectfit.activities;

import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.v4.content.ContextCompat;
import android.view.View;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.activities.base.FragmentedActivity;
import com.softcustomer.perfectfit.fragments.settings.BookingPreference;
import com.softcustomer.perfectfit.models.Day;
import com.softcustomer.perfectfit.vendor.Factory;

import java.util.Calendar;

public class BookingActivity extends FragmentedActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Day day = getModel(Day.class);

        if (day != null)
            setToolbarText(getString(R.string.title_activity_booking) + " " + day.getFormattedDate());

        setupFragment(day);

        FloatingActionButton fab = findViewById(R.id.fab);
        fab.setImageDrawable(ContextCompat.getDrawable(this, R.drawable.ic_done));
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                startActivity(Factory.getIntent(BookingActivity.this, PaymentActivity.class));
            }
        });

    }

    private void setupFragment(Day day) {
        //  Calendar time = getModel(Calendar.class.getName());
        BookingPreference preference = new BookingPreference();
        Bundle arguments = new Bundle();
        arguments.putSerializable(Day.class.getName(), day);
        preference.setArguments(arguments);
        setPreferenceFragment(R.id.content, preference);
    }

    @Override
    protected boolean hasCustomToolbar() {
        return true;
    }

    @Override
    protected int getContentView() {
        return R.layout.activity_fab;
    }
}
