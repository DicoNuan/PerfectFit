package com.softcustomer.perfectfit.activities.user;

import android.content.Intent;
import android.os.Bundle;
import android.os.Environment;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.util.Log;
import android.view.View;
import android.widget.ProgressBar;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.activities.base.HomeButtonBase;

import java.io.File;
import java.util.Collection;

import io.fotoapparat.Fotoapparat;
import io.fotoapparat.parameter.ScaleType;
import io.fotoapparat.parameter.Size;
import io.fotoapparat.parameter.selector.SelectorFunction;
import io.fotoapparat.photo.BitmapPhoto;
import io.fotoapparat.result.PendingResult;
import io.fotoapparat.result.PhotoResult;
import io.fotoapparat.view.CameraRenderer;

import static io.fotoapparat.log.Loggers.logcat;
import static io.fotoapparat.log.Loggers.loggers;

public class CameraActivity extends HomeButtonBase {

    public static final String BITMAP = "bitmap";
    public static final String ORIENTATION = "orientation";
    private Fotoapparat fotoapparat;
    private ProgressBar progressBar;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        fotoapparat = Fotoapparat
                .with(this)
                .into((CameraRenderer) findViewById(R.id.camera_view))
                .previewScaleType(ScaleType.CENTER_CROP)
                .photoSize(new SelectorFunction<Size>() {
                    @Override
                    public Size select(Collection<Size> collection) {
                        return new Size(540, 320);
                    }
                })
                .logger(loggers(logcat()))
                .build();
        progressBar = findViewById(R.id.progressBar);
        findViewById(R.id.imageview_shoot).setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {
                takePicture();
            }
        });
    }

    private void takePicture() {
        final String filepath = createFilePath();
        Log.e("CameraAct", filepath);
        final PhotoResult photoResult = fotoapparat.takePicture();
        progressBar.setVisibility(View.VISIBLE);
        photoResult.saveToFile(new File(filepath)).whenDone(new PendingResult.Callback<Void>() {
            @Override
            public void onResult(Void aVoid) {
                photoResult.toBitmap().whenAvailable(new PendingResult.Callback<BitmapPhoto>() {
                    @Override
                    public void onResult(BitmapPhoto bitmapPhoto) {
                        Intent intent = new Intent();
                        intent.putExtra(BITMAP, filepath);
                        intent.putExtra(ORIENTATION, bitmapPhoto.rotationDegrees);
                        setResult(RESULT_OK, intent);
                        finish();
                    }
                });
            }
        });
    }

    @NonNull
    private String createFilePath() {
        String filepath = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES).getAbsolutePath();
        filepath += "/IMG_" + System.currentTimeMillis() + ".jpeg";
        return filepath;
    }

    @Override
    protected void onStart() {
        super.onStart();
        fotoapparat.start();
    }

    @Override
    protected void onStop() {
        super.onStop();
        fotoapparat.stop();
    }

    @Override
    protected boolean hasCustomToolbar() {
        return false;
    }

    @Override
    protected int getContentView() {
        return R.layout.activity_camera;
    }
}
