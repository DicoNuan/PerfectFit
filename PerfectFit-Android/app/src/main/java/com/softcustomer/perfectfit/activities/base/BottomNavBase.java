package com.softcustomer.perfectfit.activities.base;


import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.design.widget.BottomNavigationView;
import android.support.v4.app.FragmentManager;
import android.view.MenuItem;

import com.crashlytics.android.Crashlytics;
import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.fragments.BaseFragment;

import java.util.HashMap;

import io.fabric.sdk.android.Fabric;


public abstract class BottomNavBase extends BaseActivity {


    protected FragmentManager fragmentManager;
    protected HashMap<String, BaseFragment> fragments = new HashMap<>();

    private BottomNavigationView.OnNavigationItemSelectedListener mOnNavigationItemSelectedListener
            = new BottomNavigationView.OnNavigationItemSelectedListener() {
        @Override
        public boolean onNavigationItemSelected(@NonNull MenuItem item) {
            onBottomNavSelected(item.getItemId());
            return true;
        }
    };


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Fabric.with(this, new Crashlytics());
        setContentView(getContentView());
        fragmentManager = getSupportFragmentManager();
        BottomNavigationView navigation = (BottomNavigationView) findViewById(R.id.navigation);
        navigation.setOnNavigationItemSelectedListener(mOnNavigationItemSelectedListener);
    }


    protected void changeFragment(BaseFragment newFragment) {
        if (fragmentManager == null || newFragment == null)
            return;
        fragmentManager.beginTransaction().replace(R.id.main_content, newFragment).commit();
    }


    protected abstract void onBottomNavSelected(int id);


}
