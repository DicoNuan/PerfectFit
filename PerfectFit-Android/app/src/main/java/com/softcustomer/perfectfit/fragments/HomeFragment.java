package com.softcustomer.perfectfit.fragments;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.widget.GridLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.SearchView;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.activities.CategoriesActivity;
import com.softcustomer.perfectfit.activities.SettingsActivity;
import com.softcustomer.perfectfit.adapters.TrainersAdapter;
import com.softcustomer.perfectfit.utils.DummyData;
import com.softcustomer.perfectfit.vendor.Factory;


public class HomeFragment extends BaseFragment {
    protected TrainersAdapter adapter;
    protected SearchView searchView;

    public HomeFragment() {
        setHasOptionsMenu(true);
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        recyclerView = view.findViewById(R.id.recyclerView);
        progressBar = view.findViewById(R.id.progressBar);
        messageTextView = view.findViewById(R.id.textview_message);
        searchView = view.findViewById(R.id.searchview);
        searchView.setQueryHint(getString(R.string.title_type_to_search));
        searchView.setIconified(false);
        searchView.clearFocus();
        setupRecycler();
    }


    private void setupRecycler() {
        if (getActivity() == null)
            return;
        adapter = new TrainersAdapter(getActivity(), DummyData.getTrainers(getActivity()), R.layout.item_trainer);
        recyclerView.setLayoutManager(new GridLayoutManager(getActivity(), 2));
        recyclerView.setAdapter(adapter);
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        inflater.inflate(R.menu.menu_main, menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.action_settings:
                startActivity(Factory.getIntent()
                        .from(getActivity())
                        .to(SettingsActivity.class)
                        .with(SettingsActivity.TAG, SettingsActivity.SEARCH_SETTINGS)
                        .create());
                break;
            case R.id.action_categories:
                startActivity(Factory.getIntent()
                        .from(getActivity())
                        .to(CategoriesActivity.class)
                        .create());
                break;
        }

        return super.onOptionsItemSelected(item);
    }

}
