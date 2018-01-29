package com.softcustomer.perfectfit.adapters;

import android.content.Context;
import android.icu.util.ULocale;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.CompoundButton;
import android.widget.GridView;
import android.widget.TextView;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.models.Category;
import com.softcustomer.perfectfit.widget.support.ResponsiveGrid;

import java.util.ArrayList;


public class CategoriesAdapter extends BaseAdapter<Category> {

    public CategoriesAdapter(Context context, ArrayList<Category> models, int resourceId) {
        super(context, models, resourceId);
    }

    @Override
    protected ModelViewHolder getViewHolder(View view) {
        return new CategoriesViewHolder(view);
    }

    @Override
    public void onBindViewHolder(RecyclerView.ViewHolder holder, int position) {
        Category category = models.get(position);
        if (category != null)
            bindData((CategoriesViewHolder) holder, category);
    }

    private void bindData(CategoriesViewHolder holder, Category category) {
        holder.gridView.setAdapter(getAdapter(category));
        holder.textView.setText(category.getTitle());
    }

    private CheckBoxAdapter getAdapter(Category category) {
        CheckBoxAdapter adapter = new CheckBoxAdapter(context, R.layout.item_checkbox, R.id.text, category.getItems());
        adapter.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                Log.e("CategoriesAdapter", buttonView.getText() + " " + isChecked);
            }
        });

        if (onCheckBoxClickListener != null)
            adapter.setOnCheckBoxClickListener(onCheckBoxClickListener);

        return adapter;
    }

    private View.OnClickListener onCheckBoxClickListener;

    public CategoriesAdapter setOnCheckBoxClickListener(View.OnClickListener onCheckBoxClickListener) {
        this.onCheckBoxClickListener = onCheckBoxClickListener;
        return this;
    }


    private class CategoriesViewHolder extends ModelViewHolder {
        ResponsiveGrid gridView;
        TextView textView;

        CategoriesViewHolder(View itemView) {
            super(itemView);
            gridView = itemView.findViewById(R.id.gridview_items);
            textView = itemView.findViewById(R.id.textview_category);
        }
    }


}
