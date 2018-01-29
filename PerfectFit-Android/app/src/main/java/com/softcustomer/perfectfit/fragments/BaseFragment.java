package com.softcustomer.perfectfit.fragments;

import android.content.Context;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.softcustomer.perfectfit.App;


public class BaseFragment extends Fragment {


    protected OnFragmentInteractionListener mListener;
    protected static final String ARG_LAYOUT_RES_ID = "layoutResId";
    protected int layoutResId;
    protected Context context;

    protected RecyclerView recyclerView;
    protected View rootView;
    protected ProgressBar progressBar;
    protected TextView messageTextView;

    public BaseFragment() {
    }


    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null && getArguments().containsKey(ARG_LAYOUT_RES_ID)) {
            layoutResId = getArguments().getInt(ARG_LAYOUT_RES_ID);
        }
    }

    public BaseFragment withView(int resId) {
        Bundle args = new Bundle();
        args.putInt(ARG_LAYOUT_RES_ID, resId);
        setArguments(args);
        return this;
    }


    public View getRootView() {
        return rootView;
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        return inflater.inflate(layoutResId, container, false);
    }

    @Override
    public void onAttach(Context activity) {
        super.onAttach(activity);
        this.context = activity;
        if (context instanceof OnFragmentInteractionListener) {
            mListener = (OnFragmentInteractionListener) context;
        }
    }


    @Override
    public void onDetach() {
        super.onDetach();
        mListener = null;
    }


    interface OnFragmentInteractionListener {
        void onFragmentInteraction();
    }

    @Nullable
    protected App getApplication() {
        if (getActivity() == null)
            return null;

        return ((App) getActivity().getApplication());
    }

    protected void setLoading(boolean isLoading) {
        setLoading(isLoading, progressBar, recyclerView);
    }

    protected void showErrorMessage(String message) {
        if (messageTextView == null || recyclerView == null || progressBar == null)
            return;
        recyclerView.setVisibility(View.INVISIBLE);
        progressBar.setVisibility(View.INVISIBLE);
        messageTextView.setText(message);
        messageTextView.setVisibility(View.VISIBLE);
    }


    protected void hideErrorMessage() {
        if (messageTextView == null)
            return;
        messageTextView.setVisibility(View.INVISIBLE);
    }


    protected void setLoading(boolean isLoading, View progress, View recycler) {
        if (progress == null || recycler == null)
            return;

        if (isLoading) {
            hideErrorMessage();
            progress.setVisibility(View.VISIBLE);
            recycler.setVisibility(View.GONE);
        } else {
            progress.setVisibility(View.GONE);
            recycler.setVisibility(View.VISIBLE);
        }

    }


    public void onActivityRestart() {

    }


}
