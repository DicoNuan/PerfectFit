package com.softcustomer.perfectfit.activities;

import android.os.Bundle;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.activities.authentication.AuthenticationActivity;
import com.softcustomer.perfectfit.activities.base.FragmentedActivity;
import com.softcustomer.perfectfit.fragments.CategoriesFragment;

public class CategoriesActivity extends FragmentedActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setFragment(R.id.categories_content, CategoriesFragment.class, R.layout.fragment_categories);
        bindActivityStarter(R.id.button_categories, AuthenticationActivity.class);
    }

    @Override
    protected boolean hasCustomToolbar() {
        return false;
    }

    @Override
    protected int getContentView() {
        return R.layout.activity_categories;
    }
}
