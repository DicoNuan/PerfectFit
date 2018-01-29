package com.softcustomer.perfectfit.activities.base;

import android.preference.Preference;
import android.preference.PreferenceFragment;
import android.support.annotation.IdRes;
import android.support.annotation.LayoutRes;
import android.support.v4.app.Fragment;

import com.softcustomer.perfectfit.fragments.BaseFragment;
import com.softcustomer.perfectfit.fragments.settings.BasePreference;
import com.softcustomer.perfectfit.vendor.Factory;
import com.softcustomer.perfectfit.vendor.PreferenceSummaryBinder;


public abstract class FragmentedActivity extends HomeButtonBase implements
        BasePreference.OnFragmentInteractionListener {


    protected static PreferenceSummaryBinder binder = new PreferenceSummaryBinder();

    protected void setFragment(@IdRes int container, Fragment fragment) {
        getSupportFragmentManager().beginTransaction()
                .replace(container, fragment)
                .commit();
    }

    protected void setPreferenceFragment(int resId, PreferenceFragment fragment) {
        getFragmentManager().beginTransaction()
                .replace(resId, fragment)
                .commit();
    }

    protected void setFragment(@IdRes int container, Class<? extends BaseFragment> fragment, @LayoutRes int layout) {
        setFragment(container, Factory.newInstanceOf(fragment,layout));
    }


    @Override
    public void bindSummary(Preference preference) {
        binder.bindSummary(preference);
    }
}
