package com.softcustomer.perfectfit.adapters;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.activities.ProfileActivity;
import com.softcustomer.perfectfit.activities.authentication.AuthenticationActivity;
import com.softcustomer.perfectfit.activities.authentication.LoginActivity;
import com.softcustomer.perfectfit.models.Trainer;
import com.softcustomer.perfectfit.vendor.Factory;
import com.softcustomer.perfectfit.vendor.UserSession;
import com.squareup.picasso.Picasso;

import java.util.ArrayList;


public class TrainersAdapter extends BaseAdapter<Trainer> {

    public TrainersAdapter(Context context, ArrayList<Trainer> models, int resourceId) {
        super(context, models, resourceId);
    }

    @Override
    protected ModelViewHolder getViewHolder(View view) {
        return new TrainerViewHolder(view);
    }

    @Override
    public void onBindViewHolder(RecyclerView.ViewHolder holder, int position) {
        Trainer trainer = models.get(position);
        bindToHolder((TrainerViewHolder) holder, trainer);
    }

    private void bindToHolder(TrainerViewHolder holder, Trainer trainer) {
        //TODO: Update this to Glide;
        Picasso.with(context).load(trainer.getProfileRes()).into(holder.profilePic);
        Picasso.with(context).load(R.raw.flag_italy).into(holder.flag);
        holder.hourRateTextView.setText(trainer.getHourRate());
        holder.professionTextView.setText(trainer.getProfession());
        holder.nameTextView.setText(trainer.getName());
        holder.itemView.setOnClickListener(new OnTrainerClickListener(trainer));
        holder.ratingTextView.setText(trainer.getRatingText());
    }

    private class OnTrainerClickListener implements View.OnClickListener {
        private Trainer trainer;

        private OnTrainerClickListener(Trainer trainer) {
            this.trainer = trainer;
        }

        @Override
        public void onClick(View v) {
            if (UserSession.isLoggedIn(context))
                context.startActivity(Factory.getIntent()
                        .from(context).to(ProfileActivity.class)
                        .with(trainer)
                        .create());
            else
                context.startActivity(Factory.getIntent(context, AuthenticationActivity.class));
        }
    }


    private class TrainerViewHolder extends ModelViewHolder {
        private TextView nameTextView;
        private TextView professionTextView;
        private TextView hourRateTextView;
        private ImageView flag;
        private ImageView profilePic;
        private TextView ratingTextView;

        public TrainerViewHolder(View itemView) {
            super(itemView);
            nameTextView = (TextView) itemView.findViewById(R.id.textview_name);
            professionTextView = (TextView) itemView.findViewById(R.id.textview_profession);
            hourRateTextView = (TextView) itemView.findViewById(R.id.textview_hour_rate);
            flag = (ImageView) itemView.findViewById(R.id.imageview_flag);
            profilePic = (ImageView) itemView.findViewById(R.id.imageview_profile_pic);
            ratingTextView = (TextView) itemView.findViewById(R.id.textview_rating);
        }
    }

}
