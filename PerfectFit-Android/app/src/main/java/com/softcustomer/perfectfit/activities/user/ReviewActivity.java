package com.softcustomer.perfectfit.activities.user;

import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.view.View;
import android.widget.EditText;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.activities.base.HomeButtonBase;

import cn.pedant.SweetAlert.SweetAlertDialog;
import me.zhanghai.android.materialratingbar.MaterialRatingBar;

public class ReviewActivity extends HomeButtonBase {

    public static final String IS_EDITABLE = "islocal";
    private boolean isEditable = true;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        FloatingActionButton fab = findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                showDialog(SweetAlertDialog.SUCCESS_TYPE, getString(R.string.trainr),
                        getString(R.string.thank_for_feedback));
            }
        });

        isEditable = getIntent().getBooleanExtra(IS_EDITABLE, true);

        disableViews();
    }

    private void disableViews() {
        if (!isEditable) {
            findViewById(R.id.textview_placeholder).setVisibility(View.GONE);
            MaterialRatingBar courteosness = findViewById(R.id.ratingBar_courteosness);
            courteosness.setIsIndicator(true);
            MaterialRatingBar overall = findViewById(R.id.ratingBar_overall);
            overall.setIsIndicator(true);
            MaterialRatingBar performance = findViewById(R.id.ratingBar_performance);
            performance.setIsIndicator(true);
            MaterialRatingBar punctuality = findViewById(R.id.ratingBar_punctuality);
            punctuality.setIsIndicator(true);

            EditText feedback = findViewById(R.id.edittext_trainer_feedback);
            EditText publicReview = findViewById(R.id.edittext_public_review);
            findViewById(R.id.fab).setVisibility(View.INVISIBLE);
            disableEt(feedback);
            disableEt(publicReview);
        }
    }

    private void disableEt(EditText editText) {
        editText.setCursorVisible(false);
        editText.setLongClickable(false);
        editText.setClickable(false);
        editText.setFocusable(false);
        editText.setSelected(false);
        editText.setHint("");
        editText.setKeyListener(null);
        editText.setBackgroundResource(android.R.color.transparent);
    }

    @Override
    protected boolean hasCustomToolbar() {
        return true;
    }

    @Override
    protected int getContentView() {
        return R.layout.activity_review;
    }
}
