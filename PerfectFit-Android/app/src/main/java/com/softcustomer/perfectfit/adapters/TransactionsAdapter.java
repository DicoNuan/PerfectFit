package com.softcustomer.perfectfit.adapters;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.TextView;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.models.Transaction;

import java.util.ArrayList;


public class TransactionsAdapter extends BaseAdapter<Transaction> {

    public TransactionsAdapter(Context context, ArrayList<Transaction> models, int resourceId) {
        super(context, models, resourceId);
    }

    public TransactionsAdapter(ArrayList<Transaction> models, int resourceId) {
        super(null, models, resourceId);
    }


    @Override
    protected ModelViewHolder getViewHolder(View view) {
        return new TransactionViewHolder(view);
    }

    @Override
    public void onBindViewHolder(RecyclerView.ViewHolder holder, int position) {
        Transaction transaction = models.get(position);
        if (transaction == null)
            return;
        bindData((TransactionViewHolder) holder, transaction);
    }

    private void bindData(TransactionViewHolder holder, Transaction transaction) {
        holder.transactionTitle.setText(transaction.getTrainer());
        holder.transactionPrice.setText(transaction.getPrice());
        holder.transactionDate.setText(transaction.getDate());
    }

    private class TransactionViewHolder extends ModelViewHolder {
        private TextView transactionTitle;
        private TextView transactionPrice;
        private TextView transactionDate;

        public TransactionViewHolder(View itemView) {
            super(itemView);
            transactionDate = itemView.findViewById(R.id.textview_transaction_date);
            transactionPrice = itemView.findViewById(R.id.textview_transaction_price);
            transactionTitle = itemView.findViewById(R.id.textview_transaction_title);
        }
    }


}
