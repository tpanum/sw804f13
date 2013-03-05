package com.example.network;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import java.io.*;
import java.net.*;

public class MyActivity extends Activity {
    /**
     * Called when the activity is first created.
     */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        Button b = (Button) findViewById(R.id.button);

        b.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                //To change body of implemented methods use File | Settings | File Templates.
                try{
                    //1. creating a socket to connect to the server
                    Socket requestSocket = new Socket("localhost", 53768);
                    //2. get Input and Output streams
                    ObjectOutputStream out = new ObjectOutputStream(requestSocket.getOutputStream());
                    out.writeObject("hej");
                    out.flush();
                    ObjectInputStream in = new ObjectInputStream(requestSocket.getInputStream());

                } catch (Exception e){

                }
            }
        });
    }


}
