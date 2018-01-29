package com.softcustomer.perfectfit.adapters;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.TextView;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.activities.user.ReviewActivity;
import com.softcustomer.perfectfit.models.Review;
import com.softcustomer.perfectfit.vendor.Factory;
import com.squareup.picasso.Picasso;

import java.util.ArrayList;

import de.hdodenhof.circleimageview.CircleImageView;
import me.zhanghai.android.materialratingbar.MaterialRatingBar;

/**
 * Created by rahim on 28/08/17.
 */

public class ReviewAdapter extends BaseAdapter<Review> {

    private boolean isLocal = true;

    public ReviewAdapter(Context context, ArrayList<Review> models, int resourceId) {
        super(context, models, resourceId);
    }

    @Override
    protected ModelViewHolder getViewHolder(View view) {
        return new ReviewViewHolder(view);
    }

    @Override
    public void onBindViewHolder(RecyclerView.ViewHolder holder, int position) {
        Review review = models.get(position);
        if (review == null)
            return;

        bindData((ReviewViewHolder) holder, review);
    }


    private void bindData(ReviewViewHolder holder, Review review) {
        holder.nameTextView.setText(review.getTrainer());
        //TODO: update this
        //Picasso.with(context).load(review.getTrainerImage()).into(holder.profilePic);
        holder.profilePic.setVisibility(isLocal ? View.VISIBLE : View.GONE);
        Picasso.with(context).load(R.raw.profile1).into(holder.profilePic);
        holder.ratingBar.setRating(review.getOverall());
        holder.reviewTextView.setText(review.getReview());
        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                context.startActivity(Factory.getIntent()
                        .from(context)
                        .to(ReviewActivity.class)
                        .with(ReviewActivity.IS_EDITABLE, false)
                        .create());
            }
        });

    }

    public boolean isLocal() {
        return isLocal;
    }

    public void setLocal(boolean local) {
        isLocal = local;
    }

    private class ReviewViewHolder extends ModelViewHolder {
        private TextView nameTextView;
        private CircleImageView profilePic;
        private TextView reviewTextView;
        private MaterialRatingBar ratingBar;

        public ReviewViewHolder(View itemView) {
            super(itemView);
            nameTextView = itemView.findViewById(R.id.textview_name);
            profilePic = itemView.findViewById(R.id.imageview_profile);
            reviewTextView = itemView.findViewById(R.id.textview_review);
            ratingBar = itemView.findViewById(R.id.ratingBar);
        }
    }
}
