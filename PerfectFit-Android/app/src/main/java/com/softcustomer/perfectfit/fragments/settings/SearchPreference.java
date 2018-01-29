package com.softcustomer.perfectfit.fragments.settings;

import android.os.Bundle;

import com.softcustomer.perfectfit.R;



public class SearchPreference extends BasePreference {
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        addPreferencesFromResource(R.xml.pref_search);
        setHasOptionsMenu(true);
        mListener.bindSummary(findPreference("pref_activity"));
        mListener.bindSummary(findPreference("pref_cities"));
        mListener.bindSummary(findPreference("pref_gender"));
        mListener.bindSummary(findPreference("pref_type"));
        mListener.bindSummary(findPreference("pref_trainers"));
        mListener.bindSummary(findPreference("pref_affiliated"));
    }
}
