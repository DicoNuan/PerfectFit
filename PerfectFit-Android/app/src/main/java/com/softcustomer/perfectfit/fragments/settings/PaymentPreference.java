package com.softcustomer.perfectfit.fragments.settings;

import android.app.Activity;
import android.os.Bundle;
import android.preference.Preference;
import android.support.v4.content.ContextCompat;

import com.softcustomer.perfectfit.R;

/**
 * Created by rahim on 28/08/17.
 */

public class PaymentPreference extends BasePreference implements Preference.OnPreferenceClickListener {

    public static final String VISA = "pref_visa";
    public static final String MASTERCARD = "pref_mastercard";
    public static final String KNET = "pref_knet";
    public static final String PAYPAL = "pref_paypal";
    public static final String CASH = "pref_cash";
    public static final String[] payments = {VISA, MASTERCARD, KNET, PAYPAL, CASH};
    private Callback mCallback;

    @Override
    public void onAttach(Activity activity) {
        super.onAttach(activity);
        if (activity instanceof Callback) {
            mCallback = (Callback) activity;
        } else {
            throw new IllegalStateException("Owner must implement Callback interface");
        }
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        addPreferencesFromResource(R.xml.pref_payment);
        setHasOptionsMenu(true);

        if (mListener == null)
            return;

        for (String pref : payments) {
            findPreference(pref).setOnPreferenceClickListener(this);
        }

        mListener.bindSummary(findPreference("pref_trainer_name"));
        mListener.bindSummary(findPreference("pref_booking_price"));
        mListener.bindSummary(findPreference("pref_duration"));
        mListener.bindSummary(findPreference("pref_add_to_calendar"));
        mListener.bindSummary(findPreference("pref_save_payment"));
    }

    @Override
    public boolean onPreferenceClick(Preference preference) {
        for (String pref : payments)
            findPreference(pref).setIcon(null);

        preference.setIcon(ContextCompat.getDrawable(getActivity(), R.drawable.ic_done_accent));
        if (preference.getKey().equals(CASH))
            return false;
        mCallback.onNestedPreferenceSelected(preference);
        return false;
    }


    public interface Callback {
        void onNestedPreferenceSelected(Preference preference);
    }

}
