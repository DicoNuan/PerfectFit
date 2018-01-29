package com.softcustomer.perfectfit.vendor;

import android.preference.ListPreference;
import android.preference.MultiSelectListPreference;
import android.preference.Preference;
import android.preference.PreferenceManager;
import android.preference.SwitchPreference;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.widget.support.EditTextDialog;
import com.softcustomer.perfectfit.widget.support.RangePreference;

import java.util.HashSet;
import java.util.Set;


public class PreferenceSummaryBinder implements Preference.OnPreferenceChangeListener {
    private String[] groupCountPrefs = {"pref_booking_trainers", "pref_trainers"};

    @Override
    public boolean onPreferenceChange(Preference preference, Object newValue) {
        String stringValue = newValue.toString();
        if (preference instanceof ListPreference) {
            // For list preferences, look up the correct display value in
            // the preference's 'entries' list.
            ListPreference listPreference = (ListPreference) preference;
            int index = listPreference.findIndexOfValue(stringValue);
            // Set the summary to reflect the new value.
            preference.setSummary(index >= 0 ? listPreference.getEntries()[index] : null);
            if (index == 0 && !((ListPreference) preference).getValue().equals(stringValue))
                showInputGroup((ListPreference) preference);
        } else if (preference instanceof MultiSelectListPreference) {
            Set<String> values = (Set<String>) newValue;
            String res = "";
            for (String v : values) {
                res += v + ", ";
            }
            preference.setSummary(res);
        } else if (preference instanceof SwitchPreference) {
            Boolean checked = (Boolean) newValue;
            if (checked)
                preference.setSummary(R.string.message_yes);
            else
                preference.setSummary(R.string.message_no);
        } else {
            // For all other preferences, set the summary to the value's
            // simple string representation.
            preference.setSummary(stringValue);
        }
        return true;
    }

    private void showInputGroup(final ListPreference preference) {
        for (int i = 0; i < groupCountPrefs.length; i++)
            if (groupCountPrefs[i].equals(preference.getKey())) {
                EditTextDialog dialog = new EditTextDialog(preference.getContext());
                dialog.show(R.string.title_group_size, R.string.message_enter_group_size, new EditTextDialog.OnDialogSubmitListener() {
                    @Override
                    public void onDialogSubmit(String text) {
                        preference.setSummary(preference.getSummary() + " " + text);
                    }
                });
                break;
            }
    }

    public void bindSummary(Preference preference) {
        // Set the listener to watch for value changes.
        if (preference == null)
            return;

        preference.setOnPreferenceChangeListener(this);

        // Trigger the listener immediately with the preference's
        // current value.
        if (preference instanceof SwitchPreference) {

            this.onPreferenceChange(preference,
                    PreferenceManager
                            .getDefaultSharedPreferences(preference.getContext())
                            .getBoolean(preference.getKey(), true));

        } else if (preference instanceof MultiSelectListPreference) {
            this.onPreferenceChange(preference, PreferenceManager
                    .getDefaultSharedPreferences(preference.getContext())
                    .getStringSet(preference.getKey(), new HashSet<String>()));

        } else this.onPreferenceChange(preference,
                PreferenceManager
                        .getDefaultSharedPreferences(preference.getContext())
                        .getString(preference.getKey(), ""));
    }
}
