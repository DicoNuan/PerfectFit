package com.softcustomer.perfectfit.activities.user;

import android.os.Bundle;
import android.support.v7.widget.DividerItemDecoration;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.activities.base.HomeButtonBase;
import com.softcustomer.perfectfit.adapters.ReviewAdapter;
import com.softcustomer.perfectfit.utils.DummyData;

public class ReviewRatingActivity extends HomeButtonBase {

    public static final String IS_LOCAL = "isLocal";
    protected RecyclerView recyclerView;
    protected ProgressBar progressBar;
    protected TextView messageTextView;
    protected boolean isLocal = false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        isLocal = getIntent().getBooleanExtra(IS_LOCAL, true);
        setToolbarText(getString(isLocal ? R.string.title_activity_rating_review : R.string.title_activity_history_reviews));
        recyclerView = findViewById(R.id.recyclerView);
        progressBar = findViewById(R.id.progressBar);
        messageTextView = findViewById(R.id.textview_message);

        setupRecycler();
    }

    private void setupRecycler() {
        recyclerView.setLayoutManager(new LinearLayoutManager(this));
        recyclerView.addItemDecoration(new DividerItemDecoration(this, DividerItemDecoration.VERTICAL));
        ReviewAdapter adapter = new ReviewAdapter(this, DummyData.getReviews(), R.layout.item_review);
        adapter.setLocal(isLocal);
        recyclerView.setAdapter(adapter);
    }


    @Override
    protected boolean hasCustomToolbar() {
        return false;
    }

    @Override
    protected int getContentView() {
        return R.layout.activity_review_rating;
    }
}
