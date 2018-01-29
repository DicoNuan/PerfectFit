package com.softcustomer.perfectfit.fragments;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.widget.DividerItemDecoration;
import android.support.v7.widget.LinearLayoutManager;
import android.view.View;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.adapters.SessionsAdapter;
import com.softcustomer.perfectfit.utils.DummyData;


public class SessionsFragment extends BaseFragment {

    private SessionsAdapter adapter;

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        recyclerView = view.findViewById(R.id.recyclerView);
        progressBar = view.findViewById(R.id.progressBar);
        messageTextView = view.findViewById(R.id.textview_message);
        setupRecycler();
    }


    private void setupRecycler() {
        if (getActivity() == null)
            return;
        adapter = new SessionsAdapter(getActivity(), DummyData.getSessions(), R.layout.item_session);
        recyclerView.setLayoutManager(new LinearLayoutManager(getActivity()));
        recyclerView.addItemDecoration(new DividerItemDecoration(getActivity(), DividerItemDecoration.VERTICAL));
        recyclerView.setAdapter(adapter);
    }


}
