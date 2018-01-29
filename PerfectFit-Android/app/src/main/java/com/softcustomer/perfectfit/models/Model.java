package com.softcustomer.perfectfit.models;


import com.google.gson.Gson;

/**
 * Created by rahim on 23/08/17.
 */

public class Model {

    public String toGson() {
        Gson gson = new Gson();
        return gson.toJson(this);
    }
}
