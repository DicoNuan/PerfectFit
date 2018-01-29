package com.softcustomer.perfectfit.adapters;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.models.Message;
import com.softcustomer.perfectfit.models.Trainer;
import com.squareup.picasso.Picasso;

import java.util.ArrayList;


public class MessagesAdapter extends RecyclerView.Adapter {

    private ArrayList<Message> messages;
    private Context context;
    private Trainer trainer;
    private static final int MESSAGE_LOCAL = R.layout.item_local_message;
    private static final int MESSAGE_FOREIGN = R.layout.item_foreign_message;

    public MessagesAdapter(ArrayList<Message> messages, Context context, @NonNull Trainer trainer) {
        this.messages = messages;
        this.context = context;
        this.trainer = trainer;
    }

    @Override
    public RecyclerView.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext())
                .inflate(viewType, parent, false);
        return viewType == MESSAGE_LOCAL ? new LocalMessage(view) : new ForeignMessage(view);
    }

    @Override
    public int getItemViewType(int position) {
        if (messages == null)
            return 0;
        return messages.get(position).isLocal() ? MESSAGE_LOCAL : MESSAGE_FOREIGN;
    }

    @Override
    public int getItemCount() {
        if (messages == null)
            return 0;
        return messages.size();
    }

    @Override
    public void onBindViewHolder(RecyclerView.ViewHolder holder, int position) {
        Message message = messages.get(position);
        if (message == null || holder == null)
            return;

        if (message.isLocal())
            bindLocalMessage((LocalMessage) holder, message);
        else
            bindForeignMessage((ForeignMessage) holder, message, position);
    }

    private void bindForeignMessage(ForeignMessage holder, Message message, int position) {
        bindMessage(holder, message);
        if (shouldShowAvatar(position)) {
            Picasso.with(context).load(trainer.getProfileRes()).into(holder.profilePic);
            holder.profilePic.setVisibility(View.VISIBLE);
        } else
            holder.profilePic.setVisibility(View.INVISIBLE);
    }

    private void bindLocalMessage(LocalMessage holder, Message message) {
        bindMessage(holder, message);
    }

    private void bindMessage(MessageViewHolder holder, Message message) {
        holder.messageText.setText(message.getMessage());
        holder.timestamp.setText(message.getFormatedTimeStamp());
    }

    private boolean shouldShowAvatar(int position) {
        return position == 0 || messages.get(position - 1).isLocal();
    }

    public void addMessage(Message message) {
        if (messages == null)
            return;
        messages.add(message);
        notifyItemInserted(messages.size() - 1);
    }


    class MessageViewHolder extends RecyclerView.ViewHolder {
        TextView messageText;
        TextView timestamp;

        MessageViewHolder(View itemView) {
            super(itemView);
            timestamp = (TextView) itemView.findViewById(R.id.textview_timestamp);
            messageText = (TextView) itemView.findViewById(R.id.textview_message);
        }
    }

    private class LocalMessage extends MessageViewHolder {
        ImageView statusIcon;

        LocalMessage(View itemView) {
            super(itemView);
            statusIcon = (ImageView) itemView.findViewById(R.id.imageview_status);
        }
    }

    private class ForeignMessage extends MessageViewHolder {
        ImageView profilePic;

        ForeignMessage(View itemView) {
            super(itemView);
            profilePic = (ImageView) itemView.findViewById(R.id.imageview_profile);
        }
    }

}
