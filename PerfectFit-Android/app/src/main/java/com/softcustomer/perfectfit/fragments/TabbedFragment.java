package com.softcustomer.perfectfit.fragments;


import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.design.widget.TabLayout;
import android.support.v4.view.ViewPager;
import android.view.View;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.adapters.SectionsPagerAdapter;
import com.softcustomer.perfectfit.vendor.Factory;

import java.util.ArrayList;
import java.util.List;

public class TabbedFragment extends BaseFragment {
    protected ViewPager mViewPager;
    protected final List<BaseFragment> fragments = new ArrayList<>();
    protected final List<String> titles = new ArrayList<>();
    protected TabLayout tabLayout;
    protected SectionsPagerAdapter mSectionsPagerAdapter;

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        mSectionsPagerAdapter = new SectionsPagerAdapter(getChildFragmentManager(), fragments, titles);
        mViewPager = (ViewPager) view.findViewById(R.id.view_pager);
        mViewPager.setOffscreenPageLimit(2);
        mViewPager.setAdapter(mSectionsPagerAdapter);
        tabLayout = (TabLayout) view.findViewById(R.id.tabs);
        tabLayout.setupWithViewPager(mViewPager);
        mSectionsPagerAdapter.notifyDataSetChanged();
    }

    public void withFragment(@NonNull BaseFragment fragment, String title) {
        fragments.add(fragment);
        titles.add(title);
    }

    private void addFragments() {
        if (fragments.size() > 1)
            return;
        addFragment(Factory.newInstanceOf(HomeFragment.class, R.layout.fragment_with_recycler), getString(R.string.title_trainers));
        addFragment(Factory.newInstanceOf(HomeFragment.class, R.layout.fragment_with_recycler), getString(R.string.title_nutritionists));
    }


    public void addFragment(@NonNull BaseFragment fragment, String title) {
        fragments.add(fragment);
        titles.add(title);
        mSectionsPagerAdapter.notifyDataSetChanged();
    }

}
