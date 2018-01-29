package com.softcustomer.perfectfit.activities;

import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.view.KeyEvent;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.activities.base.BaseActivity;
import com.softcustomer.perfectfit.adapters.MessagesAdapter;
import com.softcustomer.perfectfit.models.Message;
import com.softcustomer.perfectfit.models.Trainer;
import com.softcustomer.perfectfit.utils.DummyData;
import com.squareup.picasso.Picasso;

import java.util.Date;

public class ChatActivity extends BaseActivity implements View.OnClickListener {

    private RecyclerView recyclerView;
    private MessagesAdapter adapter;
    private Trainer trainer;
    private EditText editText;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(getContentView());
        trainer = getModel(Trainer.class);
        setupUi();
    }

    private void setupUi() {
        setupRecycler();

        setupToolbar();

        editText = (EditText) findViewById(R.id.editText);
        editText.setOnEditorActionListener(new TextView.OnEditorActionListener() {
            @Override
            public boolean onEditorAction(TextView v, int actionId, KeyEvent event) {
                sendMessage();
                return true;
            }
        });
        ImageView sendButton = (ImageView) findViewById(R.id.imageview_send);
        sendButton.setOnClickListener(this);
    }

    private void setupToolbar() {
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);

        setSupportActionBar(toolbar);
        removeToolbarText();
        findViewById(R.id.imageview_back).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });
        TextView toolbarText = (TextView) findViewById(R.id.textview_toolbar);
        ImageView profilePic = (ImageView) findViewById(R.id.imageview_profile);
        Picasso.with(this).load(trainer.getProfileRes()).into(profilePic);
        toolbarText.setText(trainer.getName());
    }

    private void sendMessage() {
        if (editText == null || adapter == null)
            return;
        String messageText = editText.getText().toString();
        Date date = new Date(System.currentTimeMillis());
        Message message = new Message(messageText, date, true);
        adapter.addMessage(message);
        editText.getText().clear();
        recyclerView.scrollToPosition(adapter.getItemCount() - 1);
    }


    private void setupRecycler() {
        recyclerView = (RecyclerView) findViewById(R.id.recyclerView);
        adapter = new MessagesAdapter(DummyData.getMessages(), this, trainer);
        recyclerView.setLayoutManager(getChatLayoutManager());
        recyclerView.setAdapter(adapter);
    }

    private LinearLayoutManager getChatLayoutManager() {
        LinearLayoutManager layoutManager = new LinearLayoutManager(this);
        layoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        layoutManager.setStackFromEnd(true);
        layoutManager.setSmoothScrollbarEnabled(false);
        return layoutManager;
    }

    @Override
    public void onClick(View v) {
        if (v.getId() == R.id.imageview_send)
            sendMessage();
    }

    @Override
    protected int getContentView() {
        return R.layout.activity_chat;
    }
}
