package com.softcustomer.perfectfit.activities;

import android.os.Bundle;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.vendor.Factory;

public class SplashScreen extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_splash_screen);
        Handler handler = new Handler();
        handler.postDelayed(new Runnable() {
            @Override
            public void run() {
                startActivity(Factory.getIntent(SplashScreen.this, MainActivity.class));
                finish();
            }
        }, 1000);
    }
}
