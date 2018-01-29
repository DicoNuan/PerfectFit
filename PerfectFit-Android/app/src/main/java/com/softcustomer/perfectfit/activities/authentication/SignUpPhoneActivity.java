package com.softcustomer.perfectfit.activities.authentication;

import android.os.AsyncTask;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.KeyEvent;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.inputmethod.EditorInfo;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.activities.base.HomeButtonBase;

/**
 * A login screen that offers login via email/password.
 */
public class SignUpPhoneActivity extends HomeButtonBase {


    /**
     * Keep track of the login task to ensure we can cancel it if requested.
     */
    private UserSignUpTask mSignUpTask = null;

    // UI references.
    private EditText countryCodeEditText;
    private EditText phoneNumberEditText;
    private View mProgressView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // Set up the login form.

        phoneNumberEditText = findViewById(R.id.edittext_phone);
        countryCodeEditText = findViewById(R.id.edittext_phone_country);

        phoneNumberEditText.setOnEditorActionListener(new TextView.OnEditorActionListener() {
            @Override
            public boolean onEditorAction(TextView textView, int id, KeyEvent keyEvent) {
                if (id == R.id.login || id == EditorInfo.IME_NULL) {
                    attemptSignup();
                    return true;
                }
                return false;
            }
        });

        Button mEmailSignInButton = findViewById(R.id.button_signUp);
        mEmailSignInButton.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                attemptSignup();
            }
        });

        mProgressView = findViewById(R.id.progressBar);
    }

    @Override
    protected boolean hasCustomToolbar() {
        return false;
    }


    /**
     * Attempts to sign in or register the account specified by the login form.
     * If there are form errors (invalid email, missing fields, etc.), the
     * errors are presented and no actual login attempt is made.
     */
    private void attemptSignup() {
        if (mSignUpTask != null) {
            return;
        }

        // Reset errors.
        countryCodeEditText.setError(null);
        phoneNumberEditText.setError(null);

        // Store values at the time of the login attempt.
        String countryCode = countryCodeEditText.getText().toString();
        String phoneNumber = phoneNumberEditText.getText().toString();

        boolean cancel = false;
        View focusView = null;

        // Check for a valid password, if the user entered one.
        if (!TextUtils.isEmpty(countryCode) && !isNumberValid(phoneNumber)) {
            phoneNumberEditText.setError(getString(R.string.error_invalid_phone));
            focusView = phoneNumberEditText;
            cancel = true;
        }


        // Check for a valid email address.
        if (TextUtils.isEmpty(phoneNumber)) {
            phoneNumberEditText.setError(getString(R.string.error_field_required));
            focusView = phoneNumberEditText;
            cancel = true;
        } else if (!isNumberValid(phoneNumber)) {
            phoneNumberEditText.setError(getString(R.string.error_invalid_phone));
            focusView = phoneNumberEditText;
            cancel = true;
        }

        if (cancel) {
            // There was an error; don't attempt login and focus the first
            // form field with an error.
            focusView.requestFocus();
        } else {
            // Show a progress spinner, and kick off a background task to
            // perform the user login attempt.
            mSignUpTask = new UserSignUpTask(phoneNumber, countryCode);
            mSignUpTask.execute((Void) null);
        }
    }


    private boolean isNumberValid(String password) {
        //TODO: Replace this with your own logic
        return password.length() > 4;
    }

    @Override
    protected int getContentView() {
        return R.layout.activity_sign_up_phone;
    }


    /**
     * Represents an asynchronous login/registration task used to authenticate
     * the user.
     */
    public class UserSignUpTask extends AsyncTask<Void, Void, Boolean> {

        private final String phone;
        private final String countryCode;

        UserSignUpTask(String phone, String countryCode) {
            this.phone = phone;
            this.countryCode = countryCode;
        }

        @Override
        protected Boolean doInBackground(Void... params) {
            // TODO: attempt authentication against a network service.

            try {
                // Simulate network access.
                Thread.sleep(2000);
            } catch (InterruptedException e) {
                return false;
            }


            // TODO: register the new account here.
            return true;
        }

        @Override
        protected void onPostExecute(final Boolean success) {
            mSignUpTask = null;

            if (success) {
                finish();
            } else {
                phoneNumberEditText.setError(getString(R.string.error_incorrect_password));
                phoneNumberEditText.requestFocus();
            }
        }

        @Override
        protected void onCancelled() {
            mSignUpTask = null;
        }
    }
}

