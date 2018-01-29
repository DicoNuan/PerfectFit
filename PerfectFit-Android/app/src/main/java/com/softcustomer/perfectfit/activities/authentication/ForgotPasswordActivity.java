package com.softcustomer.perfectfit.activities.authentication;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.activities.base.HomeButtonBase;

public class ForgotPasswordActivity extends HomeButtonBase {

    private Button actionButton;
    private EditText email;
    private EditText newPaswword;
    private EditText newPaswwordConfirm;
    private TextView prompt;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        prompt = findViewById(R.id.textview_resest_pass_hint);

        actionButton = findViewById(R.id.button_request_new_password);


        email = findViewById(R.id.edittext_email);

        newPaswword = findViewById(R.id.edittext_new_password);
        newPaswwordConfirm = findViewById(R.id.edittext_econfirm_new_password);

        actionButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                prompt.setText(getString(R.string.enter_new_password));
                actionButton.setText(getString(R.string.done));
                email.setVisibility(View.INVISIBLE);
                findViewById(R.id.layout_new_password).setVisibility(View.VISIBLE);
            }
        });
    }

    @Override
    protected boolean hasCustomToolbar() {
        return false;
    }

    @Override
    protected int getContentView() {
        return R.layout.activity_forgot_password;
    }
}
