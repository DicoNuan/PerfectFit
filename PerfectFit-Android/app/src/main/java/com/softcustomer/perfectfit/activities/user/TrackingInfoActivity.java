package com.softcustomer.perfectfit.activities.user;

import android.os.Bundle;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.activities.ProfileActivity;
import com.softcustomer.perfectfit.activities.base.HomeButtonBase;
import com.softcustomer.perfectfit.utils.DummyData;

public class TrackingInfoActivity extends HomeButtonBase {


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        bindActivityStarter(R.id.layout_review, ReviewActivity.class);
        bindActivityStarter(R.id.layout_profile, ProfileActivity.class,
                DummyData.getTrainer());

    }

    @Override
    protected boolean hasCustomToolbar() {
        return false;
    }

    @Override
    protected int getContentView() {
        return R.layout.activity_tracking_info;
    }
}
