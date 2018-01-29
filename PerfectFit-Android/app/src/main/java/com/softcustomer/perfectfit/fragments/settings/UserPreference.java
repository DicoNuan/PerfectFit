package com.softcustomer.perfectfit.fragments.settings;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.view.ViewCompat;
import android.view.View;
import android.widget.ListView;

import com.softcustomer.perfectfit.R;


public class UserPreference extends BasePreference {

    public UserPreference() {

    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        addPreferencesFromResource(R.xml.pref_user_profile);
        setHasOptionsMenu(true);

        if (mListener == null)
            return;

        mListener.bindSummary(findPreference("pref_user_name"));
        mListener.bindSummary(findPreference("pref_user_gender"));
        mListener.bindSummary(findPreference("pref_user_city"));
        mListener.bindSummary(findPreference("pref_user_height"));
        mListener.bindSummary(findPreference("pref_user_weight"));
        mListener.bindSummary(findPreference("pref_user_email"));
        mListener.bindSummary(findPreference("pref_user_phone"));
        mListener.bindSummary(findPreference("pref_user_password"));
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        final ListView lv = (ListView) view.findViewById(android.R.id.list);
        if (lv != null)
            ViewCompat.setNestedScrollingEnabled(lv, true);
    }
}
