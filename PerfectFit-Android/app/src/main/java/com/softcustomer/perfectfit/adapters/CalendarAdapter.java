package com.softcustomer.perfectfit.adapters;

import android.content.Context;
import android.content.res.ColorStateList;
import android.graphics.Typeface;
import android.support.v4.content.ContextCompat;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.activities.BookingActivity;
import com.softcustomer.perfectfit.activities.PlanActivity;
import com.softcustomer.perfectfit.models.Day;
import com.softcustomer.perfectfit.vendor.Factory;

import java.util.ArrayList;
import java.util.Random;

/**
 * Created by rahim on 28/08/17.
 */

public class CalendarAdapter extends BaseAdapter<Day> {

    private int textColor;
    private int textColorToday;

    public CalendarAdapter(Context context, ArrayList<Day> models, int resourceId) {
        super(context, models, resourceId);
        textColor = ContextCompat.getColor(context, R.color.black);
        textColorToday = ContextCompat.getColor(context, R.color.colorAccent);
    }

    @Override
    protected ModelViewHolder getViewHolder(View view) {
        return new DayViewHolder(view);
    }

    @Override
    public void onBindViewHolder(RecyclerView.ViewHolder holder, int position) {
        Day day = models.get(position);
        bindData((DayViewHolder) holder, day);
    }

    private void bindData(DayViewHolder holder, final Day day) {
        holder.dateText.setText(day.getDate());
        holder.dayText.setText(day.getDay());
        holder.dateText.setTextColor(ColorStateList.valueOf(day.isToday() ? textColorToday : textColor));
        holder.dayText.setTextColor(ColorStateList.valueOf(day.isToday() ? textColorToday : textColor));
        holder.dateText.setTypeface(null, day.isToday() ? Typeface.BOLD : Typeface.NORMAL);
        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                context.startActivity(Factory.getIntent()
                        .from(context)
                        .to(BookingActivity.class)
                        .with(day)
                        .create());
            }
        });


        /*
        * Factory.getIntent()
                        .from(context)
                        .to(PlanActivity.class)
                        .with(day)
                        .create()
        * */

        if (holder.dotsContainer.getChildCount() < day.getBusyness()) {
            appendDots(holder, day);
        }
        //else
        //  deleteDots(holder, day);
    }

    private void deleteDots(DayViewHolder holder, Day day) {
        int diff = holder.dotsContainer.getChildCount() - day.getBusyness();
        if (diff > 0)
            holder.dotsContainer.removeViews(0, diff);
    }

    //13-3 14-2 15-1 16-3
    private void appendDots(DayViewHolder holder, Day day) {
        if (holder.filled)
            return;

        for (int i = 0; i < day.getBusyness(); i++)
            holder.dotsContainer.addView(createDot(holder));
        holder.filled = true;
    }

    private View createDot(DayViewHolder holder) {
        return LayoutInflater.from(context).inflate(R.layout.item_dot, holder.dotsContainer, false);
    }

    public int getTodayPosition() {
        if (models == null)
            return -1;

        for (int i = 0; i < models.size(); i++) {
            if (models.get(i).isToday())
                return i;
        }
        return -1;
    }


    private class DayViewHolder extends ModelViewHolder {

        private TextView dayText;
        private TextView dateText;
        private LinearLayout dotsContainer;
        private boolean filled = false;

        public DayViewHolder(View itemView) {
            super(itemView);
            dateText = itemView.findViewById(R.id.textview_date);
            dayText = itemView.findViewById(R.id.textview_day_name);
            dotsContainer = itemView.findViewById(R.id.layout_dots_container);
        }
    }
}
