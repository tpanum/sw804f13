package dk.cs.aau.redirector;

import android.content.Context;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;

/**
 * Created with IntelliJ IDEA.
 * User: Esben
 * Date: 05-03-13
 * Time: 13:08
 * To change this template use File | Settings | File Templates.
 */
public class Account extends Person {

    private String username;
    private String password;
    //private Context context;
    //public static SharedPreferences preferences;

    public Account(String username, String password) {
        this.username = username;
        this.password = password;
        //this.context = context;
        //this.preferences = PreferenceManager.getDefaultSharedPreferences(context);
    }

    public boolean authenticate() {
        //uses sendRequest

        return true;
    }

}
