package com.softcustomer.perfectfit.fragments.settings;

import android.app.Activity;
import android.content.Context;
import android.preference.Preference;
import android.preference.PreferenceFragment;

public class BasePreference extends PreferenceFragment {

    protected OnFragmentInteractionListener mListener;


    public interface OnFragmentInteractionListener {
        void bindSummary(Preference preference);
    }

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
        if (context instanceof OnFragmentInteractionListener) {
            mListener = (OnFragmentInteractionListener) context;
        }
    }

    @Override
    public void onAttach(Activity activity) {
        super.onAttach(activity);
        if (activity instanceof OnFragmentInteractionListener) {
            mListener = (OnFragmentInteractionListener) activity;
        }
    }

    public BasePreference setListener(OnFragmentInteractionListener mListener) {
        this.mListener = mListener;
        return this;
    }

    @Override
    public void onDetach() {
        super.onDetach();
        mListener = null;
    }
}
