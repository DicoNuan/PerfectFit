package com.softcustomer.perfectfit.utils;

import android.content.DialogInterface;
import android.content.Intent;
import android.support.v7.app.AlertDialog;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.activities.user.CameraActivity;
import com.softcustomer.perfectfit.activities.user.UserProfileActivity;

/**
 * Created by rahim on 01/09/17.
 */

public class DialogBuilder {

    public static void showSelectDialog(final UserProfileActivity context) {
        final AlertDialog.Builder adb = new AlertDialog.Builder(context);
        CharSequence items[] = new CharSequence[]{context.getString(R.string.camera), context.getString(R.string.gallery)};
        adb.setSingleChoiceItems(items, 0, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface d, int n) {
                d.dismiss();
                if (n == 0) {
                    Intent intent = new Intent(context, CameraActivity.class);
                    context.startActivityForResult(intent, UserProfileActivity.REQUEST_PHOTO);
                } else {
                    Intent intent = new Intent();
                    intent.setType("image/*");
                    intent.setAction(Intent.ACTION_GET_CONTENT);
                    context.startActivityForResult(Intent.createChooser(intent,
                            "Select Picture"), context.REQUEST_GALLERY);
                }
            }

        });
        adb.setNegativeButton("Cancel", null);
        adb.setTitle("Which one?");
        adb.show();
    }
}
