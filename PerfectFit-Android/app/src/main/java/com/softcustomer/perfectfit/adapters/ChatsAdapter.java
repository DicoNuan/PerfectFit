package com.softcustomer.perfectfit.adapters;

import android.content.Context;
import android.content.Intent;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.TextView;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.activities.ChatActivity;
import com.softcustomer.perfectfit.models.Chat;
import com.softcustomer.perfectfit.vendor.Factory;
import com.squareup.picasso.Picasso;

import java.util.ArrayList;

import de.hdodenhof.circleimageview.CircleImageView;


public class ChatsAdapter extends BaseAdapter<Chat> {

    public ChatsAdapter(Context context, ArrayList<Chat> models, int resourceId) {
        super(context, models, resourceId);
    }

    @Override
    protected ModelViewHolder getViewHolder(View view) {
        return new ChatsViewHolder(view);
    }


    @Override
    public void onBindViewHolder(RecyclerView.ViewHolder holder, int position) {
        Chat chat = models.get(position);
        bindToHolder((ChatsViewHolder) holder, chat);
    }

    private void bindToHolder(ChatsViewHolder holder, final Chat chat) {
        if (holder == null || chat == null)
            return;
        holder.lastMessage.setText(chat.getLastMessage().getMessage());
        holder.lastMessageDate.setText(chat.getLastMessage().getFormatedTimeStamp());
        holder.nameTextView.setText(chat.getTrainer().getName());
        Picasso.with(context).load(chat.getTrainer().getProfileRes()).into(holder.profilePic);
        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = Factory.getIntent()
                        .from(context).to(ChatActivity.class)
                        .with(chat.getTrainer()).create();
                context.startActivity(intent);
            }
        });
    }

    private class ChatsViewHolder extends ModelViewHolder {
        private TextView nameTextView;
        private CircleImageView profilePic;
        private TextView lastMessage;
        private TextView lastMessageDate;

        public ChatsViewHolder(View itemView) {
            super(itemView);
            nameTextView = (TextView) itemView.findViewById(R.id.textview_name);
            profilePic = (CircleImageView) itemView.findViewById(R.id.imageview_profile);
            lastMessage = (TextView) itemView.findViewById(R.id.textview_last_message);
            lastMessageDate = (TextView) itemView.findViewById(R.id.textview_timestamp);
        }
    }


}
