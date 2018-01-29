package com.softcustomer.perfectfit.activities;

import android.content.res.ColorStateList;
import android.os.Bundle;
import android.preference.Preference;
import android.support.design.widget.FloatingActionButton;
import android.support.v4.content.ContextCompat;
import android.view.MenuItem;
import android.view.View;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.activities.base.FragmentedActivity;
import com.softcustomer.perfectfit.fragments.settings.NestedPaymentPreference;
import com.softcustomer.perfectfit.fragments.settings.PaymentPreference;

import cn.pedant.SweetAlert.SweetAlertDialog;

public class PaymentActivity extends FragmentedActivity implements PaymentPreference.Callback {

    private static final String TAG_NESTED = "nested";
    private FloatingActionButton fab;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setPreferenceFragment(R.id.content, new PaymentPreference());
        fab = findViewById(R.id.fab);
        fab.setBackgroundTintList(ColorStateList.valueOf(ContextCompat.getColor(this, R.color.colorAlternative)));
        fab.setOnClickListener(showDialog);

    }

    @Override
    public void onBackPressed() {
        // this if statement is necessary to navigate through nested and main fragments
        if (getFragmentManager().getBackStackEntryCount() == 0) {
            super.onBackPressed();
        } else {
            changeFab(false);
            getFragmentManager().popBackStack();
        }
    }


    @Override
    protected boolean hasCustomToolbar() {
        return true;
    }

    @Override
    protected int getContentView() {
        return R.layout.activity_fab;
    }

    @Override
    public void onNestedPreferenceSelected(Preference preference) {
        changeFab(true);
        getFragmentManager().beginTransaction().replace(R.id.content,
                NestedPaymentPreference.newInstance(preference.getKey()),
                TAG_NESTED).addToBackStack(TAG_NESTED).commit();
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {

        if (getFragmentManager().getBackStackEntryCount() == 0) {
            return super.onOptionsItemSelected(item);
        } else {
            changeFab(false);
            getFragmentManager().popBackStack();
        }
        return false;
    }

    private void changeFab(boolean isNested) {
        fab.setBackgroundTintList(ColorStateList.valueOf(ContextCompat.getColor(this,
                isNested ? R.color.colorAlternative2 : R.color.colorAlternative)));
        fab.setImageDrawable(ContextCompat.getDrawable(this, isNested ? R.drawable.ic_done : R.drawable.ic_money));
        fab.setOnClickListener(isNested ? finishPaymentSelection : showDialog);
    }

    private View.OnClickListener showDialog = new View.OnClickListener() {
        @Override
        public void onClick(View view) {
            showDialog(SweetAlertDialog.SUCCESS_TYPE, R.string.thank_you,
                    R.string.message_set_for_session);
        }
    };


    private View.OnClickListener finishPaymentSelection = new View.OnClickListener() {
        @Override
        public void onClick(View view) {
            changeFab(false);
            getFragmentManager().popBackStack();
        }
    };
}
