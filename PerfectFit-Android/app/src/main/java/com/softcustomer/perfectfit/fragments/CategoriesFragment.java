package com.softcustomer.perfectfit.fragments;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.widget.LinearLayoutManager;
import android.view.View;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.adapters.CategoriesAdapter;
import com.softcustomer.perfectfit.models.Category;

import java.util.ArrayList;

public class CategoriesFragment extends BaseFragment {

    private ArrayList<Category> categories;

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        recyclerView = view.findViewById(R.id.recycler);
        categories = new ArrayList<>();
        categories.add(createCategory(R.array.pref_aerobics_values, R.string.pref_aerobics));
        categories.add(createCategory(R.array.pref_aerobics_values_wersling, R.string.pref_title_affiliated));
        setupRecycler();
    }

    private Category createCategory(int arr, int title) {
        String[] a = getResources().getStringArray(arr);
        String t = getString(title);
        return new Category(a, t);
    }

    private void setupRecycler() {
        recyclerView.setLayoutManager(new LinearLayoutManager(getActivity()));
        recyclerView.setAdapter(new CategoriesAdapter(getActivity(),categories,R.layout.item_category));
    }
}
