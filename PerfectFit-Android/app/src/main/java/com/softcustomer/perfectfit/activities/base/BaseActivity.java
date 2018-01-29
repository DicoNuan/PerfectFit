package com.softcustomer.perfectfit.activities.base;

import android.content.Context;
import android.content.Intent;
import android.graphics.PorterDuff;
import android.graphics.drawable.Drawable;
import android.support.annotation.AnyRes;
import android.support.annotation.ColorRes;
import android.support.annotation.DrawableRes;
import android.support.annotation.IdRes;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.annotation.StringRes;
import android.support.v4.content.ContextCompat;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.widget.ImageView;
import android.widget.TextView;

import com.softcustomer.perfectfit.App;
import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.models.Model;
import com.softcustomer.perfectfit.vendor.Factory;
import com.softcustomer.perfectfit.vendor.JsonParser;
import com.squareup.picasso.Picasso;

import java.io.Serializable;

import cn.pedant.SweetAlert.SweetAlertDialog;
import uk.co.chrisjenx.calligraphy.CalligraphyContextWrapper;


public abstract class BaseActivity extends AppCompatActivity {

/*
    @Override
    protected void attachBaseContext(Context newBase) {
        try {
            super.attachBaseContext(CalligraphyContextWrapper.wrap(newBase));
        } catch (Exception e) {
            super.attachBaseContext(newBase);
            e.printStackTrace();
        }
    }*/

    public App getApp() {
        return (App) getApplication();
    }


    protected void onConnectionError(SweetAlertDialog dialog, SweetAlertDialog.OnSweetClickListener listener) {
        showErrorDialog(dialog, R.string.connection_error, R.string.try_again, listener);
    }

    protected void showErrorDialog(SweetAlertDialog dialog, int errorContent, int confirmtext, SweetAlertDialog.OnSweetClickListener listener) {
        if (dialog == null)
            return;
        dialog.setTitleText(getString(R.string.error))
                .setContentText(getString(errorContent))
                .setConfirmClickListener(listener)
                .setConfirmText(getString(confirmtext))
                .changeAlertType(SweetAlertDialog.ERROR_TYPE);
        if (!dialog.isShowing())
            dialog.show();
    }

    protected void showDialog(int type, String title, String message) {
        final SweetAlertDialog dialog = new SweetAlertDialog(this, type);
        dialog.setTitleText(title);
        dialog.setContentText(message);
        dialog.setConfirmClickListener(new SweetAlertDialog.OnSweetClickListener() {
            @Override
            public void onClick(SweetAlertDialog sweetAlertDialog) {
                if (dialog != null && dialog.isShowing())
                    dialog.dismissWithAnimation();
            }
        });
        dialog.show();
    }

    protected void showDialog(int type, @StringRes int title, @StringRes int message) {
        showDialog(type, getString(title), getString(message));
    }

    protected void showLoadingDialog(SweetAlertDialog dialog) {
        dialog.setContentText(getString(R.string.please_wait));
        dialog.setTitleText(getString(R.string.loading));
        dialog.show();
    }


    protected void bindOnClickListener(View view, View.OnClickListener listener) {
        if (view == null)
            return;

        view.setOnClickListener(listener);
    }

    protected void bindOnClickListener(@IdRes int resId, View.OnClickListener listener, Model... model) {
        bindOnClickListener(findViewById(resId), listener);
    }

    protected void bindActivityStarter(View view, final Class<?> activityName, final Model... models) {
        bindOnClickListener(view, new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (models.length == 0)
                    startActivity(Factory.getIntent(BaseActivity.this, activityName));
                else {
                    startActivity(Factory.getIntent()
                            .from(BaseActivity.this)
                            .to(activityName)
                            .with(models[0])
                            .create()
                    );
                }
            }
        });
    }


    protected void bindActivityStarter(@IdRes int resId, final Class<?> activityName, Model... models) {
        bindActivityStarter(findViewById(resId), activityName, models);
    }


    protected void bindText(TextView textView, @Nullable String text) {
        if (textView == null)
            return;
        if (text == null)
            text = getString(R.string.not_specified);

        textView.setText(text);
    }


    protected void bindText(@IdRes int textViewId, @Nullable String text) {
        bindText((TextView) findViewById(textViewId), text);
    }

    protected void bindImage(ImageView imageView, @NonNull String url) {
        if (imageView == null)
            return;
        Picasso.with(this).load(url).into(imageView);

    }

    protected void bindImage(ImageView imageView, @AnyRes int contentResource) {
        if (imageView == null || contentResource == 0)
            return;
        Picasso.with(this).load(contentResource).into(imageView);
    }

    protected void bindImage(@IdRes int imageResource, @AnyRes int contentResource) {
        bindImage((ImageView) findViewById(imageResource), contentResource);
    }


    protected void bindImage(@IdRes int imageResource, @NonNull String contentResource) {
        bindImage((ImageView) findViewById(imageResource), contentResource);
    }


    protected void showHomeButton() {
        if (getSupportActionBar() != null)
            getSupportActionBar().setDisplayHomeAsUpEnabled(true);
    }

    protected void setHomeButton(@ColorRes int color, @DrawableRes int drawable) {
        final Drawable upArrow = ContextCompat.getDrawable(this, drawable);
        upArrow.setColorFilter(getColour(color), PorterDuff.Mode.SRC_ATOP);

        if (getSupportActionBar() != null)
            getSupportActionBar().setHomeAsUpIndicator(upArrow);
    }

    protected void removeToolbarText() {
        if (getSupportActionBar() != null)
            getSupportActionBar().setDisplayShowTitleEnabled(false);
    }

    protected void setToolbarText(String text) {
        if (getSupportActionBar() != null)
            getSupportActionBar().setTitle(text);
    }

    @Nullable
    public <T extends Model> T getModel(Class<? extends Model> className) {
        Intent intent = getIntent();
        if (!intent.hasExtra(className.getName()))
            return null;

        String modelJson = intent.getStringExtra(className.getName());
        return (T) JsonParser.parse(modelJson, className);
    }


    public <T extends Serializable> T getModel(String className) {
        Intent intent = getIntent();
        return (T) intent.getSerializableExtra(className);
    }

    public int getColour(int resid) {
        return ContextCompat.getColor(this, resid);
    }

    protected void hideKeyboard() {
        View view = this.getCurrentFocus();
        if (view != null) {
            InputMethodManager imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
            imm.hideSoftInputFromWindow(view.getWindowToken(), 0);
        }
    }

    protected abstract int getContentView();
}
