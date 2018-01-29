package com.softcustomer.perfectfit.vendor;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Parcelable;

import com.softcustomer.perfectfit.fragments.BaseFragment;
import com.softcustomer.perfectfit.models.Model;

import java.io.Serializable;

/**
 * Created by rahim on 31/07/17.
 */

public class Factory {

    protected static final String ARG_LAYOUT_RES_ID = "layoutResId";
    protected static final String ARG_TYPE = "type";

    public static <T extends BaseFragment> T newInstanceOf(Class<T> fragmentClass, int resId) {
        T t;
        try {
            t = fragmentClass.newInstance();
            Bundle args = new Bundle();
            args.putInt(ARG_LAYOUT_RES_ID, resId);
            t.setArguments(args);
            return t;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (T) new BaseFragment().withView(resId);
    }

    public static Intent getIntent(Context context, Class<?> className) {
        return new Intent(context, className);
    }

    public static IntentBuilder getIntent() {
        IntentBuilder intentBuilder = new IntentBuilder();
        return intentBuilder;
    }

    public static class IntentBuilder {
        private Intent intent;
        private Context from;

        public IntentBuilder() {
            this.intent = new Intent();
        }

        public IntentBuilder from(Context context) {
            this.from = context;
            return this;
        }

        public IntentBuilder to(Class<?> className) {
            this.intent.setClass(from, className);
            return this;
        }

        public IntentBuilder with(String tag, int data) {
            intent.putExtra(tag, data);
            return this;
        }

        public IntentBuilder with(String tag, String data) {
            intent.putExtra(tag, data);
            return this;
        }


        public IntentBuilder with(String tag, boolean data) {
            intent.putExtra(tag, data);
            return this;
        }

        public IntentBuilder with(String tag, float data) {
            intent.putExtra(tag, data);
            return this;
        }

        public IntentBuilder with(String tag, double data) {
            intent.putExtra(tag, data);
            return this;
        }

        public IntentBuilder with(String tag, short data) {
            intent.putExtra(tag, data);
            return this;
        }


        public IntentBuilder with(Model data) {
            intent.putExtra(data.getClass().getName(), data.toGson());
            return this;
        }

        public IntentBuilder with(String tag, Model data) {
            intent.putExtra(tag, data.toGson());
            return this;
        }


        public IntentBuilder with(String tag, Serializable serializable) {
            intent.putExtra(tag, serializable);
            return this;
        }


        public IntentBuilder with(String tag, Parcelable parcelable) {
            intent.putExtra(tag, parcelable);
            return this;
        }

        public Intent create() {
            return this.intent;
        }
    }


}
