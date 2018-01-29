package com.softcustomer.perfectfit.fragments;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.widget.LinearLayoutManager;
import android.view.View;
import android.widget.ScrollView;
import android.widget.TextView;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.adapters.CategoriesAdapter;
import com.softcustomer.perfectfit.adapters.PlansAdapter;
import com.softcustomer.perfectfit.models.Category;
import com.softcustomer.perfectfit.models.Plan;

import java.util.ArrayList;

public class PlansFragment extends BaseFragment {

    private ArrayList<Plan> plans;
    private ScrollView planReview;
    private boolean isExpanded = false;

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        recyclerView = view.findViewById(R.id.recycler);
        planReview = view.findViewById(R.id.plans_review);
        planReview.setOnClickListener(onCheckBoxClickListener);
        plans = new ArrayList<>();
        plans.add(createCategory(R.array.pref_plans, R.string.pref_plans));
        setupRecycler();
    }


    private Plan createCategory(int arr, int title) {
        String[] a = getResources().getStringArray(arr);
        String t = getString(title);
        return new Plan(a, t);
    }

    private void setupRecycler() {
        recyclerView.setLayoutManager(new LinearLayoutManager(getActivity()));
        recyclerView.setAdapter(new PlansAdapter(getActivity(), plans, R.layout.item_plan)
                .setOnCheckBoxClickListener(onCheckBoxClickListener));
    }

    public void expandCollapseText() {
        if (recyclerView == null || planReview == null)
            return;

        if (isExpanded) {
            planReview.setVisibility(View.GONE);
            recyclerView.setVisibility(View.VISIBLE);
        } else {
            planReview.setVisibility(View.VISIBLE);
            recyclerView.setVisibility(View.GONE);
        }

        isExpanded = !isExpanded;
    }

    public boolean isExpanded() {
        return isExpanded;
    }

    private View.OnClickListener onCheckBoxClickListener = new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            expandCollapseText();
        }
    };
}
