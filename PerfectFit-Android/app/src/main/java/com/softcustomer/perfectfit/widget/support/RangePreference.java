package com.softcustomer.perfectfit.widget.support;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.res.TypedArray;
import android.preference.DialogPreference;
import android.util.AttributeSet;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.NumberPicker;
import android.widget.Spinner;

import com.softcustomer.perfectfit.R;


public class RangePreference extends DialogPreference {

    private NumberPicker numberPicker;
    private Spinner spinner;
    private String summary;
    private String[] units;
    private int value;
    private int type;
    private int maxValue;
    private int minValue;
    private String unit;
    private static final int TYPE_WEIGHT = 1;
    private static final int TYPE_HEIGHT = 2;

    private static final String HEIGHT_FOOT = "foot";
    private static final String HEIGHT_SM = "sm";
    private static final String WEIGHT_LB = "lb";
    private static final String WEIGHT_KG = "kg";

    private static final int HEIGHT_MAX_FOOT = 8;
    private static final int HEIGHT_MIN_FOOT = 1;

    private static final int HEIGHT_MAX_SM = 240;
    private static final int HEIGHT_MIN_SM = 40;


    private static final int WEIGHT_MAX_LB = 600;
    private static final int WEIGHT_MIN_LB = 40;

    private static final int WEIGHT_MAX_KG = 300;
    private static final int WEIGHT_MIN_KG = 20;


    public RangePreference(Context context, AttributeSet attrs) {
        super(context, attrs);
        TypedArray a = context.getTheme().obtainStyledAttributes(attrs, R.styleable.RangePreference, 0, 0);

        if (a.hasValue(R.styleable.RangePreference_unit_type))
            type = a.getInt(R.styleable.RangePreference_unit_type, TYPE_HEIGHT);

        if (a.hasValue(R.styleable.RangePreference_units)) {
            int id = a.getResourceId(R.styleable.RangePreference_units,
                    type == TYPE_WEIGHT ? R.array.pref_weight_units : R.array.pref_height_units);
            units = a.getResources().getStringArray(id);
        }

        if (a.hasValue(R.styleable.RangePreference_max))
            maxValue = a.getInt(R.styleable.RangePreference_max, 240);

        if (a.hasValue(R.styleable.RangePreference_min))
            minValue = a.getInt(R.styleable.RangePreference_unit_type, 40);

        unit = units[0];
    }


    public void setRange(int min, int max) {
        this.minValue = min;
        this.maxValue = max;
        invalidatePicker();
    }

    public void invalidatePicker() {
        if (numberPicker == null)
            return;
        numberPicker.setMaxValue(maxValue);
        numberPicker.setMinValue(minValue);
        numberPicker.setValue(value);
        numberPicker.setOnValueChangedListener(onValueChangeListener);
    }

    private void setSpinner() {
        if (spinner == null)
            return;

        ArrayAdapter<String> adapter = new ArrayAdapter<>(getContext(), android.R.layout.simple_list_item_1, units);
        spinner.setAdapter(adapter);
        spinner.setOnItemSelectedListener(onUnitsChangeListener);
    }


    public void setValue(int number) {
        // Always persist/notify the first time.
        final boolean changed = number != value;
        if (changed) {
            value = number;
            setSummary();
            persistString(summary);
            callChangeListener(summary);
            notifyDependencyChange(shouldDisableDependents());
            notifyChanged();
        }
    }

    /**
     * Gets the text from the {@link SharedPreferences}.
     *
     * @return The current preference value.
     */
    public Number getValue() {
        return value;
    }

    @Override
    protected void onBindDialogView(View view) {
        super.onBindDialogView(view);
        numberPicker = view.findViewById(R.id.range);
        spinner = view.findViewById(R.id.listview);
        setSpinner();
        invalidatePicker();
    }

    @Override
    protected void onDialogClosed(boolean positiveResult) {
        super.onDialogClosed(positiveResult);

        if (positiveResult) {
            if (callChangeListener(value)) {
                setValue(value);
            }
        }
    }

    @Override
    protected Object onGetDefaultValue(TypedArray a, int index) {
        return a.getString(index);
    }


    public Spinner getSpinner() {
        return spinner;
    }

    public void setSpinner(Spinner spinner) {
        this.spinner = spinner;
    }


    private void setSummary() {
        summary = String.valueOf(value) + " " + unit;
        setSummary(summary);
    }

    public String[] getUnits() {
        return units;
    }

    public void setUnits(String[] units) {
        this.units = units;
    }

    protected void onUnitItemClick(AdapterView<?> parent, View view, int position, long id) {
        unit = units[position];
        mapLimitsTo(unit);
    }

    public void mapLimitsTo(String unit) {
        switch (unit) {
            case WEIGHT_KG:
                setRange(WEIGHT_MIN_KG, WEIGHT_MAX_KG);
                break;
            case WEIGHT_LB:
                setRange(WEIGHT_MIN_LB, WEIGHT_MAX_LB);
                break;
            case HEIGHT_FOOT:
                setRange(HEIGHT_MIN_FOOT, HEIGHT_MAX_FOOT);
                break;
            case HEIGHT_SM:
                setRange(HEIGHT_MIN_SM, HEIGHT_MAX_SM);
                break;
        }
    }

    public AdapterView.OnItemSelectedListener getOnUnitsChangeListener() {
        return onUnitsChangeListener;
    }

    public void setOnUnitsChangeListener(AdapterView.OnItemSelectedListener onUnitsChangeListener) {
        this.onUnitsChangeListener = onUnitsChangeListener;
        if (this.spinner != null)
            spinner.setOnItemSelectedListener(onUnitsChangeListener);
    }

    public NumberPicker.OnValueChangeListener getOnValueChangeListener() {
        return onValueChangeListener;
    }

    public void setOnValueChangeListener(NumberPicker.OnValueChangeListener onValueChangeListener) {
        this.onValueChangeListener = onValueChangeListener;
        if (this.numberPicker != null)
            numberPicker.setOnValueChangedListener(onValueChangeListener);
    }

    private NumberPicker.OnValueChangeListener onValueChangeListener = new NumberPicker.OnValueChangeListener() {
        @Override
        public void onValueChange(NumberPicker picker, int oldVal, int newVal) {
            Log.e("RangePreference", "newVal: " + newVal);
            setValue(newVal);
        }
    };

    private AdapterView.OnItemSelectedListener onUnitsChangeListener = new AdapterView.OnItemSelectedListener() {
        @Override
        public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
            onUnitItemClick(parent, view, position, id);
        }

        @Override
        public void onNothingSelected(AdapterView<?> parent) {

        }

    };
}
