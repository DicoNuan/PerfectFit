package com.softcustomer.perfectfit.adapters;

import android.content.Context;
import android.support.annotation.IdRes;
import android.support.annotation.LayoutRes;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.softcustomer.perfectfit.R;

import java.util.List;


class CheckBoxAdapter extends ArrayAdapter<String> {


    CheckBoxAdapter(@NonNull Context context, @LayoutRes int resource, int id, @NonNull String[] objects) {
        super(context, resource, id, objects);
    }


    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
        LinearLayout linearLayout = (LinearLayout) super.getView(position, convertView, parent);
        CheckBox checkBox = linearLayout.findViewById(R.id.checkbox);
        TextView textView = linearLayout.findViewById(R.id.text);


        if (onCheckedChangeListener != null)
            checkBox.setOnCheckedChangeListener(onCheckedChangeListener);
        if (onCheckBoxClickListener != null)
            textView.setOnClickListener(onCheckBoxClickListener);

        return linearLayout;
    }

    private CompoundButton.OnCheckedChangeListener onCheckedChangeListener;
    private View.OnClickListener onCheckBoxClickListener;


    public void setOnCheckedChangeListener(CompoundButton.OnCheckedChangeListener onCheckedChangeListener) {
        this.onCheckedChangeListener = onCheckedChangeListener;
    }

    public void setOnCheckBoxClickListener(View.OnClickListener onCheckBoxClickListener) {
        this.onCheckBoxClickListener = onCheckBoxClickListener;
    }
}
