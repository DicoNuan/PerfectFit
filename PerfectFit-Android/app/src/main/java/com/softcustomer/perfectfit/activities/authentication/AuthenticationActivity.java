package com.softcustomer.perfectfit.activities.authentication;

import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.BottomSheetBehavior;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.activities.MainActivity;
import com.softcustomer.perfectfit.activities.base.BaseActivity;
import com.softcustomer.perfectfit.vendor.Factory;
import com.softcustomer.perfectfit.vendor.UserSession;
import com.squareup.picasso.Picasso;

public class AuthenticationActivity extends BaseActivity {

    private BottomSheetBehavior bottomSheetBehavior;

    private int REQUEST_LOGIN = 1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_authentification);

        Button signUp = findViewById(R.id.button_signUp);
        View bottomSheet = findViewById(R.id.bottom_sheet);

        //TextView signUpFacebook = findViewById(R.id.textview_signup_facebook);

        bindActivityStarter(R.id.textview_signup_phone, SignUpPhoneActivity.class);
        bindActivityStarter(R.id.textview_signup_email, SignUpActivity.class);
        bindOnClickListener(R.id.button_signin, new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(AuthenticationActivity.this, LoginActivity.class);
                startActivityForResult(intent, REQUEST_LOGIN);
            }
        });

        bottomSheetBehavior = BottomSheetBehavior.from(bottomSheet);
        bottomSheetBehavior.setPeekHeight(0);
        bottomSheetBehavior.setHideable(true);
        bottomSheetBehavior.setState(BottomSheetBehavior.STATE_COLLAPSED);


        signUp.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                bottomSheetBehavior.setState(BottomSheetBehavior.STATE_EXPANDED);
            }
        });

    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == REQUEST_LOGIN && resultCode == LoginActivity.SUCCESS) {
            if (UserSession.isLoggedOut(this))
                startActivity(Factory.getIntent(this, MainActivity.class));
            finish();
        }
    }

    @Override
    protected void onStop() {
        super.onStop();
        if (bottomSheetBehavior != null)
            bottomSheetBehavior.setState(BottomSheetBehavior.STATE_COLLAPSED);
    }

    @Override
    protected int getContentView() {
        return R.layout.activity_authentification;
    }
}
