package com.softcustomer.perfectfit.activities;

import android.os.Bundle;
import android.support.v7.widget.DividerItemDecoration;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.text.TextUtils;
import android.view.MotionEvent;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.activities.base.HomeButtonBase;
import com.softcustomer.perfectfit.activities.user.ReviewRatingActivity;
import com.softcustomer.perfectfit.adapters.CalendarAdapter;
import com.softcustomer.perfectfit.models.Trainer;
import com.softcustomer.perfectfit.vendor.CalendarController;
import com.softcustomer.perfectfit.vendor.Factory;
import com.softcustomer.perfectfit.widget.support.ExpandableTextView;

import java.util.Calendar;

import me.zhanghai.android.materialratingbar.MaterialRatingBar;

public class ProfileActivity extends HomeButtonBase {

    private Trainer trainer;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        trainer = getModel(Trainer.class);
        setupUi();
    }

    @Override
    protected boolean hasCustomToolbar() {
        return true;
    }

    private void setupUi() {
        if (trainer == null)
            return;
        removeToolbarText();
        setupCalendar();

        bindActivityStarter(R.id.fab, ChatActivity.class, trainer);

        MaterialRatingBar ratingBar = findViewById(R.id.ratingBar);
        ratingBar.setRating(trainer.getRating());
        ratingBar.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View view, MotionEvent event) {
                if (event.getAction() == MotionEvent.ACTION_UP)
                    startActivity(Factory.getIntent()
                            .from(ProfileActivity.this)
                            .to(ReviewRatingActivity.class)
                            .with(ReviewRatingActivity.IS_LOCAL, false)
                            .create());
                return true;
            }
        });

        //   findViewById(R.id.textview_bio_content).setOnClickListener(onBioClick);

        bindDataToViews();

        Button bookingButton = findViewById(R.id.button_booking);

        bookingButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(Factory.getIntent()
                        .from(ProfileActivity.this)
                        .to(BookingActivity.class)
                        .create());
            }
        });

        bindActivityStarter(R.id.button_plans, PlansActivity.class);
    }

    private View.OnClickListener onBioClick = new View.OnClickListener() {
        @Override
        public void onClick(View view) {
            startActivity(Factory.getIntent()
                    .from(ProfileActivity.this)
                    .to(BioActivity.class)
                    .with(BioActivity.BIO, trainer.getBio())
                    .create());
        }
    };

    private void bindDataToViews() {
        bindText(R.id.textview_name, trainer.getName());
        bindText(R.id.textview_rating, String.valueOf(trainer.getRating()));
        bindText(R.id.textview_hour_rate, trainer.getHourRate());
        bindText(R.id.textview_specialization, trainer.getSpecialization());
        bindText(R.id.textview_aboutme_content, trainer.getAboutMe());
        bindText(R.id.textview_coaching_content, trainer.getCoaching());
        bindText(R.id.textview_location_content, trainer.getLocation());
        //   bindText(R.id.textview_bio_content, trainer.getBio());
        bindImage(R.id.imageview_wall, trainer.getProfileWall());
        bindImage(R.id.imageview_flag, R.raw.flag_italy);
    }


    private void setupCalendar() {
        RecyclerView calendarView = findViewById(R.id.recyclerView);

        Calendar endDate = Calendar.getInstance();
        endDate.add(Calendar.MONTH, 1);
        endDate.set(Calendar.DAY_OF_MONTH, 1);
        Calendar startDate = Calendar.getInstance();
        CalendarController calendarController = new CalendarController(startDate, endDate);
        CalendarAdapter adapter = new CalendarAdapter(this, calendarController.calculate(), R.layout.item_calendar_day);
        calendarView.setLayoutManager(new LinearLayoutManager(this, LinearLayoutManager.HORIZONTAL, false));
        calendarView.addItemDecoration(new DividerItemDecoration(this, DividerItemDecoration.HORIZONTAL));
        calendarView.setNestedScrollingEnabled(false);
        calendarView.setAdapter(adapter);
        int today = adapter.getTodayPosition();
        if (today != -1)
            calendarView.scrollToPosition(today);

    }


    @Override
    protected int getContentView() {
        return R.layout.activity_profile;
    }

    public void expand(View view) {
        ExpandableTextView textView = (ExpandableTextView) view;
        if (textView.isExpanded())
            textView.truncateText();
        else
            textView.expandText();
    }
}
