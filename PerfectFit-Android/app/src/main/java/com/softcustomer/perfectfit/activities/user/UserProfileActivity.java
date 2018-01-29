package com.softcustomer.perfectfit.activities.user;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.util.Log;
import android.view.View;
import android.widget.ImageView;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.activities.base.FragmentedActivity;
import com.softcustomer.perfectfit.fragments.settings.UserPreference;
import com.softcustomer.perfectfit.utils.DialogBuilder;
import com.softcustomer.perfectfit.utils.PathExtractor;
import com.softcustomer.perfectfit.vendor.UserSession;
import com.squareup.picasso.Picasso;

import java.io.File;
import java.net.URI;
import java.net.URISyntaxException;

public class UserProfileActivity extends FragmentedActivity {


    public static final int REQUEST_PHOTO = 1;
    public static final int REQUEST_GALLERY = 2;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        if (UserSession.getWallPic(this) != null)
            Picasso.with(this).load(UserSession.getWallPic(this)).into((ImageView) findViewById(R.id.imageview_wall));

        FloatingActionButton fab = findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                DialogBuilder.showSelectDialog(UserProfileActivity.this);
            }
        });

        setPreferenceFragment(R.id.user_profile_content, new UserPreference().setListener(this));

    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        try {
            if (resultCode == RESULT_OK && requestCode == REQUEST_PHOTO) {
                onPhotoShoot(data);
            } else if (resultCode == RESULT_OK && requestCode == REQUEST_GALLERY) {
                onGallerySelect(data);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void onGallerySelect(Intent data) {
        Uri selectedImageUri = data.getData();
        String filepath = PathExtractor.getFilePath(this, selectedImageUri);
        if (filepath == null)
            return;
        File file = new File(filepath);
        UserSession.saveWallPicture(this, file.getAbsolutePath());
        Picasso.with(this).load(file).into((ImageView) findViewById(R.id.imageview_wall));
    }

    private void onPhotoShoot(Intent data) {
        int orientation = data.getIntExtra(CameraActivity.ORIENTATION, 0);
        String filepath = data.getStringExtra(CameraActivity.BITMAP);
        UserSession.saveWallPicture(this, filepath);
        Picasso.with(UserProfileActivity.this)
                .load(new File(filepath))
                .rotate(orientation)
                .into((ImageView) findViewById(R.id.imageview_wall));
    }


    @Override
    protected boolean hasCustomToolbar() {
        return true;
    }

    @Override
    protected int getContentView() {
        return R.layout.activity_user_profile;
    }


}
