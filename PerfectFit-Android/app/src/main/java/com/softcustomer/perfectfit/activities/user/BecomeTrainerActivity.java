package com.softcustomer.perfectfit.activities.user;

import android.os.Bundle;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.activities.base.HomeButtonBase;

public class BecomeTrainerActivity extends HomeButtonBase {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

    }

    @Override
    protected boolean hasCustomToolbar() {
        return false;
    }

    @Override
    protected int getContentView() {
        return R.layout.activity_become_trainer;
    }
}
