package com.softcustomer.perfectfit.activities;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.widget.TextView;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.activities.base.HomeButtonBase;

import java.util.Calendar;
import java.util.Date;

public class BioActivity extends HomeButtonBase {

    public static final String BIO = "bio";


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Intent intent = getIntent();
        String bio = intent.getStringExtra(BIO);
        TextView textView = findViewById(R.id.textview_bio);
        textView.setText(bio);
    }

    @Override
    protected boolean hasCustomToolbar() {
        return false;
    }

    @Override
    protected int getContentView() {
        return R.layout.activity_bio;
    }
}
