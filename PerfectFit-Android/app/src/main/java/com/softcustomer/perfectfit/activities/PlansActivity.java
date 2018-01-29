package com.softcustomer.perfectfit.activities;

import android.os.Bundle;
import android.view.MenuItem;
import android.view.View;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.activities.base.FragmentedActivity;
import com.softcustomer.perfectfit.fragments.PlansFragment;
import com.softcustomer.perfectfit.fragments.settings.BasePreference;
import com.softcustomer.perfectfit.vendor.Factory;

import cn.pedant.SweetAlert.SweetAlertDialog;

public class PlansActivity extends FragmentedActivity implements BasePreference.OnFragmentInteractionListener {
    private SweetAlertDialog alertDialog;
    private PlansFragment plansFragment;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        plansFragment = Factory.newInstanceOf(PlansFragment.class, R.layout.fragment_plans);

        setFragment(R.id.plans_content, plansFragment);

        bindOnClickListener(R.id.button_plans, new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onSubmitButtonClick();
            }
        });
    }

    private void onSubmitButtonClick() {
        alertDialog = new SweetAlertDialog(this, SweetAlertDialog.SUCCESS_TYPE);
        alertDialog.setContentText(getString(R.string.message_trainer_contact));
        alertDialog.setTitleText(getString(R.string.message_success_order));
        alertDialog.setConfirmText(getString(R.string.okay));
        alertDialog.setConfirmClickListener(new SweetAlertDialog.OnSweetClickListener() {
            @Override
            public void onClick(SweetAlertDialog sweetAlertDialog) {
                if (alertDialog != null && alertDialog.isShowing())
                    alertDialog.dismissWithAnimation();
                startActivity(Factory.getIntent(PlansActivity.this, PaymentActivity.class));
            }
        });
        alertDialog.show();

    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        if (item.getItemId() == android.R.id.home)
            if (plansFragment != null && plansFragment.isExpanded()) {
                plansFragment.expandCollapseText();
                return false;
            }

        return super.onOptionsItemSelected(item);
    }

    @Override
    public void onBackPressed() {
        if (plansFragment != null && plansFragment.isExpanded()) {
            plansFragment.expandCollapseText();
            return;
        }
        super.onBackPressed();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (alertDialog != null && alertDialog.isShowing())
            alertDialog.dismissWithAnimation();
    }

    @Override
    protected boolean hasCustomToolbar() {
        return false;
    }

    @Override
    protected int getContentView() {
        return R.layout.activity_plans;
    }

}
