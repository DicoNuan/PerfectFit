package com.softcustomer.perfectfit.activities;


import android.content.Context;
import android.content.Intent;
import android.content.res.Configuration;
import android.os.Bundle;
import android.preference.Preference;
import android.preference.PreferenceActivity;
import android.preference.PreferenceFragment;
import android.support.v7.app.ActionBar;
import android.view.MenuItem;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.activities.base.AppCompatPreferenceActivity;
import com.softcustomer.perfectfit.fragments.settings.BasePreference;
import com.softcustomer.perfectfit.fragments.settings.BookingPreference;
import com.softcustomer.perfectfit.fragments.settings.SearchPreference;
import com.softcustomer.perfectfit.vendor.PreferenceSummaryBinder;

/**
 * A {@link PreferenceActivity} that presents a set of application settings. On
 * handset devices, settings are presented as a single list. On tablets,
 * settings are split by category, with category headers shown to the left of
 * the list of settings.
 * <p>
 * See <a href="http://developer.android.com/design/patterns/settings.html">
 * Android Design: Settings</a> for design guidelines and the <a
 * href="http://developer.android.com/guide/topics/ui/settings.html">Settings
 * API Guide</a> for more information on developing a Settings UI.
 */
public class SettingsActivity extends AppCompatPreferenceActivity implements BasePreference.OnFragmentInteractionListener {

    public static final String TAG = "settings";
    public static final String SEARCH_SETTINGS = "Search";
    private static PreferenceSummaryBinder summaryBinder = new PreferenceSummaryBinder();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setupActionBar();
        Intent intent = getIntent();
        String settings = intent.getStringExtra(TAG);

        switch (settings) {
            case SEARCH_SETTINGS:
                setFragment(new SearchPreference());
                setTitle(settings + " " + TAG);
                break;
        }
    }

    private void setTitle(String title) {
        if (getSupportActionBar() == null)
            return;
        getSupportActionBar().setTitle(title);
    }


    private void setFragment(PreferenceFragment fragment) {

        getFragmentManager().beginTransaction()
                .replace(android.R.id.content, fragment)
                .commit();
    }

    /**
     * Helper method to determine if the device has an extra-large screen. For
     * example, 10" tablets are extra-large.
     */
    private static boolean isXLargeTablet(Context context) {
        return (context.getResources().getConfiguration().screenLayout
                & Configuration.SCREENLAYOUT_SIZE_MASK) >= Configuration.SCREENLAYOUT_SIZE_XLARGE;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        if (item.getItemId() == android.R.id.home)
            finish();
        return true;
    }


    /**
     * Set up the {@link android.app.ActionBar}, if the API is available.
     */
    private void setupActionBar() {
        ActionBar actionBar = getSupportActionBar();
        if (actionBar != null) {
            // Show the Up button in the action bar.
            actionBar.setDisplayHomeAsUpEnabled(true);
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean onIsMultiPane() {
        return isXLargeTablet(this);
    }


    /**
     * This method stops fragment injection in malicious applications.
     * Make sure to deny any unknown fragments here.
     */
    protected boolean isValidFragment(String fragmentName) {
        return PreferenceFragment.class.getName().equals(fragmentName)
                || SearchPreference.class.getName().equals(fragmentName)
                || BookingPreference.class.getName().equals(fragmentName);
    }

    /**
     * Binds a preference's summary to its value. More specifically, when the
     * preference's value is changed, its summary (line of text below the
     * preference title) is updated to reflect the value. The summary is also
     * immediately updated upon calling this method. The exact display format is
     * dependent on the type of preference.
     *
     * @see #summaryBinder
     */
    @Override
    public void bindSummary(Preference preference) {
        summaryBinder.bindSummary(preference);
    }
}
