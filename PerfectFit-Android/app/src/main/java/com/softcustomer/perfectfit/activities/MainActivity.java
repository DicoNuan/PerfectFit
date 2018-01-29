package com.softcustomer.perfectfit.activities;

import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Spinner;

import com.crashlytics.android.Crashlytics;
import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.activities.base.BottomNavBase;
import com.softcustomer.perfectfit.fragments.HomeFragment;
import com.softcustomer.perfectfit.fragments.MessagesFragment;
import com.softcustomer.perfectfit.fragments.ProfileFragment;
import com.softcustomer.perfectfit.vendor.Factory;

import io.fabric.sdk.android.Fabric;

public class MainActivity extends BottomNavBase {

    private static final String HOME = "home";
    private static final String MESSAGES = "messages";
    private static final String PROFILE = "profile";
    private Spinner spinner;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setSupportActionBar((Toolbar) findViewById(R.id.toolbar));
        setupSpinner();
        addFragments();
        removeToolbarText();
    }

    private void setupSpinner() {
        spinner = findViewById(R.id.spinner);
        ArrayAdapter<?> adapter = ArrayAdapter.createFromResource(this, R.array.countries,
                R.layout.item_spinner);
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spinner.setAdapter(adapter);
    }

    private void addFragments() {
        fragments.put(PROFILE, Factory.newInstanceOf(ProfileFragment.class, R.layout.fragment_profile));
        fragments.put(MESSAGES, Factory.newInstanceOf(MessagesFragment.class, R.layout.fragment_with_recycler));
        fragments.put(HOME, Factory.newInstanceOf(HomeFragment.class, R.layout.fragment_home));
        changeFragment(fragments.get(HOME));
    }

    @Override
    protected void onBottomNavSelected(int id) {
        switch (id) {
            case R.id.navigation_home:
                spinner.setVisibility(View.VISIBLE);
                changeFragment(fragments.get(HOME));
                break;

            case R.id.navigation_messages:
                spinner.setVisibility(View.INVISIBLE);
                changeFragment(fragments.get(MESSAGES));
                break;

            case R.id.navigation_profile:
                spinner.setVisibility(View.INVISIBLE);
                changeFragment(fragments.get(PROFILE));
                break;
        }
    }


    @Override
    protected int getContentView() {
        return R.layout.activity_main;
    }
}
