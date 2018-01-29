package com.softcustomer.perfectfit.fragments;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.widget.DividerItemDecoration;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.adapters.ChatsAdapter;
import com.softcustomer.perfectfit.utils.DummyData;


public class MessagesFragment extends BaseFragment {

    private ChatsAdapter adapter;

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        recyclerView = (RecyclerView) view.findViewById(R.id.recyclerView);
        progressBar = (ProgressBar) view.findViewById(R.id.progressBar);
        messageTextView = (TextView) view.findViewById(R.id.textview_message);
        setupRecycler();
    }

    private void setupRecycler() {
        if (getActivity() == null)
            return;
        adapter = new ChatsAdapter(getActivity(),
                DummyData.getChats(getString(R.string.dummy_text)),
                R.layout.item_chat);
        recyclerView.setLayoutManager(new LinearLayoutManager(getActivity()));
        recyclerView.addItemDecoration(new DividerItemDecoration(getActivity(), DividerItemDecoration.VERTICAL));
        recyclerView.setAdapter(adapter);
    }


}
