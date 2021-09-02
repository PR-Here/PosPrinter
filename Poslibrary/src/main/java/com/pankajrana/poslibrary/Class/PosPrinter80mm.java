package com.pankajrana.poslibrary.Class;

import android.app.Activity;

public class PosPrinter80mm extends PosPrinter {

    public PosPrinter80mm(Activity activity) {
        super(activity);
    }

    @Override
    int getCharsOnLine() {
        return 48;
    }
}