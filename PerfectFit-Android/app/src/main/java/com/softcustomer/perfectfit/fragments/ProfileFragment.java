package com.softcustomer.perfectfit.fragments;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.activities.base.BaseActivity;
import com.softcustomer.perfectfit.activities.user.BecomeTrainerActivity;
import com.softcustomer.perfectfit.activities.user.PaymentHistoryActivity;
import com.softcustomer.perfectfit.activities.user.ReviewRatingActivity;
import com.softcustomer.perfectfit.activities.user.SessionTrackingActivity;
import com.softcustomer.perfectfit.activities.user.UserProfileActivity;
import com.softcustomer.perfectfit.vendor.Factory;
import com.softcustomer.perfectfit.vendor.UserSession;


public class ProfileFragment extends BaseFragment {

    public ProfileFragment() {
        setHasOptionsMenu(true);
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        view.findViewById(R.id.layout_user_profile)
                .setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        startActivity(Factory.getIntent(getActivity(), UserProfileActivity.class));
                    }
                });

        view.findViewById(R.id.textview_payment_history)
                .setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        startActivity(Factory.getIntent(getActivity(), PaymentHistoryActivity.class));
                    }
                });

        view.findViewById(R.id.textview_session_tracking)
                .setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        startActivity(Factory.getIntent(getActivity(), SessionTrackingActivity.class));
                    }
                });

        view.findViewById(R.id.textview_become_trainer)
                .setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        startActivity(Factory.getIntent(getActivity(), BecomeTrainerActivity.class));
                    }
                });

        view.findViewById(R.id.textview_rating_reviews)
                .setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        startActivity(Factory.getIntent(getActivity(), ReviewRatingActivity.class));
                    }
                });
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        inflater.inflate(R.menu.menu_main_profile, menu);
        super.onCreateOptionsMenu(menu, inflater);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        if (item.getItemId() == R.id.action_log_out) {
            UserSession.finish((BaseActivity) getActivity());
        }
        return super.onOptionsItemSelected(item);
    }
}
