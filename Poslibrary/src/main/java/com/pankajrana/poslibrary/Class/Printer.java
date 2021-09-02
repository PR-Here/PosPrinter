package com.pankajrana.poslibrary.Class;

public interface Printer {

    void send(Ticket ticket);

    boolean isAvailable();

    boolean isEnabled();

    boolean isConnected();

    void setDeviceCallbacks(DeviceCallbacks callbacks);

}