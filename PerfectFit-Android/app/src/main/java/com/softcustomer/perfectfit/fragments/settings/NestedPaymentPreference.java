package com.softcustomer.perfectfit.fragments.settings;

import android.os.Bundle;

import com.softcustomer.perfectfit.R;



public class NestedPaymentPreference extends BasePreference {

    private static final String TAG_KEY = "NESTED_KEY";

    public static NestedPaymentPreference newInstance(String key) {
        NestedPaymentPreference fragment = new NestedPaymentPreference();
        // supply arguments to bundle.
        Bundle args = new Bundle();
        args.putString(TAG_KEY, key);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);

        checkPreferenceResource();

        mListener.bindSummary(findPreference("pref_cardholder"));
        mListener.bindSummary(findPreference("pref_card_number"));
        mListener.bindSummary(findPreference("pref_card_expire"));


        mListener.bindSummary(findPreference("pref_mastercard_cardholder"));
        mListener.bindSummary(findPreference("pref_mastercard_card_number"));
        mListener.bindSummary(findPreference("pref_mastercard_card_expire"));

        mListener.bindSummary(findPreference("pref_bank_name"));
        mListener.bindSummary(findPreference("pref_bank_prefix"));
        mListener.bindSummary(findPreference("pref_bank_expire"));
        mListener.bindSummary(findPreference("pref_bank_pin"));

        mListener.bindSummary(findPreference("pref_paypal_email"));
        mListener.bindSummary(findPreference("pref_paypal_password"));




    }

    private void checkPreferenceResource() {
        String key = getArguments().getString(TAG_KEY);
        if (key == null)
            return;

        // Load the preferences from an XML resource
        switch (key) {
            case PaymentPreference.VISA:
                addPreferencesFromResource(R.xml.pref_payment_visa);
                break;

            case PaymentPreference.MASTERCARD:
                addPreferencesFromResource(R.xml.pref_payment_mastercard);
                break;

            case PaymentPreference.KNET:
                addPreferencesFromResource(R.xml.pref_payment_knet);
                break;

            case PaymentPreference.PAYPAL:
                addPreferencesFromResource(R.xml.pref_payment_paypal);
                break;

            default:
                break;
        }
    }
}
