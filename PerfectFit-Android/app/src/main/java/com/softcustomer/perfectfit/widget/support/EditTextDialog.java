package com.softcustomer.perfectfit.widget.support;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.widget.EditText;
import android.widget.LinearLayout;

import com.softcustomer.perfectfit.R;


public class EditTextDialog {
    private Context context;

    public EditTextDialog(Context context) {
        this.context = context;
    }

    public void show(int titleRes, int messageRes, final OnDialogSubmitListener listener) {
        if (this.context == null)
            return;
        AlertDialog.Builder alertDialog = new AlertDialog.Builder(context);
        alertDialog.setTitle(context.getString(titleRes));
        alertDialog.setMessage(context.getString(messageRes));
        final EditText input = new EditText(context);

        LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.MATCH_PARENT);
        input.setLayoutParams(lp);
        alertDialog.setView(input);
        alertDialog.setPositiveButton("OK", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                listener.onDialogSubmit(input.getText().toString());
            }
        });
        alertDialog.show();
    }

    public interface OnDialogSubmitListener {
        void onDialogSubmit(String text);
    }
}
