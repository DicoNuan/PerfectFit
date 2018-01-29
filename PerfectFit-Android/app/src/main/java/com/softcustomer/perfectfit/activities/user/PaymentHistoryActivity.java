package com.softcustomer.perfectfit.activities.user;

import android.os.Bundle;
import android.support.v7.widget.DividerItemDecoration;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.activities.base.HomeButtonBase;
import com.softcustomer.perfectfit.adapters.TransactionsAdapter;
import com.softcustomer.perfectfit.utils.DummyData;

public class PaymentHistoryActivity extends HomeButtonBase {

    private RecyclerView recyclerView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        recyclerView = findViewById(R.id.recyclerView);
        recyclerView.setLayoutManager(new LinearLayoutManager(this));
        recyclerView.addItemDecoration(new DividerItemDecoration(this, RecyclerView.VERTICAL));
        TransactionsAdapter adapter = new TransactionsAdapter(DummyData.getTransactions(),
                R.layout.item_transaction);
        recyclerView.setAdapter(adapter);
    }

    @Override
    protected boolean hasCustomToolbar() {
        return false;
    }

    @Override
    protected int getContentView() {
        return R.layout.activity_payment_history;
    }
}
