package com.softcustomer.perfectfit.adapters;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import java.util.ArrayList;


public abstract class BaseAdapter<T> extends RecyclerView.Adapter {

    protected Context context;
    protected ArrayList<T> models;
    protected int resourceId;


    public BaseAdapter(Context context, ArrayList<T> models, int resourceId) {
        this.context = context;
        this.models = models;
        this.resourceId = resourceId;
    }


    @Override
    public ModelViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext())
                .inflate(resourceId, parent, false);
        return getViewHolder(view);
    }


    protected abstract ModelViewHolder getViewHolder(View view);


    @Override
    public int getItemCount() {
        if (models == null)
            return 0;

        return models.size();
    }

    protected class ModelViewHolder extends RecyclerView.ViewHolder {

        public ModelViewHolder(View itemView) {
            super(itemView);
        }
    }

}
