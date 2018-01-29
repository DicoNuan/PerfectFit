package com.softcustomer.perfectfit.adapters;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.View;
import android.widget.CompoundButton;
import android.widget.TextView;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.models.Category;
import com.softcustomer.perfectfit.models.Plan;
import com.softcustomer.perfectfit.widget.support.ResponsiveGrid;

import java.util.ArrayList;


public class PlansAdapter extends BaseAdapter<Plan> {

    public PlansAdapter(Context context, ArrayList<Plan> models, int resourceId) {
        super(context, models, resourceId);
    }

    @Override
    protected ModelViewHolder getViewHolder(View view) {
        return new CategoriesViewHolder(view);
    }

    @Override
    public void onBindViewHolder(RecyclerView.ViewHolder holder, int position) {
        Plan category = models.get(position);
        if (category != null)
            bindData((CategoriesViewHolder) holder, category);
    }

    private void bindData(CategoriesViewHolder holder, Plan category) {
        holder.gridView.setAdapter(getAdapter(category));
        holder.textView.setText(category.getTitle());
    }

    private CheckBoxAdapter getAdapter(Plan plan) {
        CheckBoxAdapter adapter = new CheckBoxAdapter(context, R.layout.item_checkbox_large, R.id.text, plan.getItems());
        adapter.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                Log.e("PlansAdapter", buttonView.getText() + " " + isChecked);
            }
        });

        if (onCheckBoxClickListener != null)
            adapter.setOnCheckBoxClickListener(onCheckBoxClickListener);

        return adapter;
    }

    private View.OnClickListener onCheckBoxClickListener;

    public PlansAdapter setOnCheckBoxClickListener(View.OnClickListener onCheckBoxClickListener) {
        this.onCheckBoxClickListener = onCheckBoxClickListener;
        return this;
    }


    private class CategoriesViewHolder extends ModelViewHolder {
        ResponsiveGrid gridView;
        TextView textView;

        CategoriesViewHolder(View itemView) {
            super(itemView);
            gridView = itemView.findViewById(R.id.gridview_items);
            textView = itemView.findViewById(R.id.textview_plan);
        }
    }


}
