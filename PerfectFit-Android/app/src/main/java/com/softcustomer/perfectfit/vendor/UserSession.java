package com.softcustomer.perfectfit.vendor;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;
import android.support.annotation.Nullable;

import com.softcustomer.perfectfit.activities.authentication.AuthenticationActivity;
import com.softcustomer.perfectfit.activities.base.BaseActivity;

import java.io.File;

/**
 * Created by rahim on 27/08/17.
 */

public class UserSession {

    private static final String LOGGED_IN = "Logged_In";
    private static final String LOGGED_OUT = "Logged_Out";
    private static final String WALL_PIC = "wall_pic";

    public static void start(Context context) {
        SharedPreferences sp = PreferenceManager.getDefaultSharedPreferences(context);
        sp.edit().putBoolean(LOGGED_IN, true).commit();
    }

    public static boolean isLoggedIn(Context context) {
        return PreferenceManager.getDefaultSharedPreferences(context).getBoolean(LOGGED_IN, false);
    }

    public static boolean isLoggedOut(Context context) {
        return PreferenceManager.getDefaultSharedPreferences(context).getBoolean(LOGGED_OUT, false);
    }

    public static void finish(BaseActivity context) {
        SharedPreferences sp = PreferenceManager.getDefaultSharedPreferences(context);
        sp.edit().putBoolean(LOGGED_IN, false)
                .putBoolean(LOGGED_OUT, true).commit();
        context.startActivity(new Intent(context, AuthenticationActivity.class));
        context.finish();
    }

    public static void saveWallPicture(Context context, String filepath) {
        SharedPreferences sp = PreferenceManager.getDefaultSharedPreferences(context);
        sp.edit().putString(WALL_PIC, filepath).commit();
    }

    @Nullable
    public static File getWallPic(Context context) {
        SharedPreferences sp = PreferenceManager.getDefaultSharedPreferences(context);
        String path = sp.getString(WALL_PIC, null);
        return path == null ? null : new File(path);
    }

}
