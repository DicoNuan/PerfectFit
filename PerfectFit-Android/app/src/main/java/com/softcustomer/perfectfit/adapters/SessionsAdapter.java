package com.softcustomer.perfectfit.adapters;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.TextView;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.activities.user.TrackingInfoActivity;
import com.softcustomer.perfectfit.models.Session;
import com.softcustomer.perfectfit.vendor.Factory;

import java.util.ArrayList;

/**
 * Created by rahim on 25/08/17.
 */

public class SessionsAdapter extends BaseAdapter<Session> {

    public SessionsAdapter(Context context, ArrayList<Session> models, int resourceId) {
        super(context, models, resourceId);
    }


    @Override
    protected ModelViewHolder getViewHolder(View view) {
        return new SessionViewHolder(view);
    }

    @Override
    public void onBindViewHolder(RecyclerView.ViewHolder holder, int position) {
        Session session = models.get(position);
        if (session == null)
            return;
        bindData((SessionViewHolder) holder, session);
    }

    private void bindData(SessionViewHolder holder, final Session session) {
        holder.sessionDate.setText(session.getDate());
        holder.sessionTime.setText(session.getStartTime() + " - " + session.getEndTime());
        holder.sessionTitle.setText(session.getTrainer());
        holder.sessionActivity.setText(session.getActivity());
        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                context.startActivity(Factory.getIntent()
                        .from(context)
                        .to(TrackingInfoActivity.class)
                        .with(session)
                        .create());
            }
        });
    }

    private class SessionViewHolder extends ModelViewHolder {
        private TextView sessionTitle;
        private TextView sessionTime;
        private TextView sessionDate;
        private TextView sessionActivity;

        public SessionViewHolder(View itemView) {
            super(itemView);
            sessionActivity = itemView.findViewById(R.id.textview_session_activity);
            sessionDate = itemView.findViewById(R.id.textview_session_date);
            sessionTime = itemView.findViewById(R.id.textview_session_time);
            sessionTitle = itemView.findViewById(R.id.textview_session_trainer);
        }
    }
}
