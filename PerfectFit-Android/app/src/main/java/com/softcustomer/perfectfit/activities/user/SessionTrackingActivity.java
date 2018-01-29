package com.softcustomer.perfectfit.activities.user;

import android.os.Bundle;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.activities.base.FragmentedActivity;
import com.softcustomer.perfectfit.fragments.SessionsFragment;
import com.softcustomer.perfectfit.fragments.TabbedFragment;
import com.softcustomer.perfectfit.vendor.Factory;

public class SessionTrackingActivity extends FragmentedActivity {


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setFragment(R.id.session_tracking_content, getTabbedFragment());
    }

    @Override
    protected boolean hasCustomToolbar() {
        return false;
    }

    @Override
    protected int getContentView() {
        return R.layout.activity_session_tracking;
    }

    public TabbedFragment getTabbedFragment() {
        TabbedFragment container = Factory.newInstanceOf(TabbedFragment.class, R.layout.fragment_tabbed);
        container.withFragment(Factory.newInstanceOf(SessionsFragment.class, R.layout.fragment_with_recycler), getString(R.string.title_pending));
        container.withFragment(Factory.newInstanceOf(SessionsFragment.class, R.layout.fragment_with_recycler), getString(R.string.title_ended));
        return container;
    }
}
