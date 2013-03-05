package dk.cs.aau.redirector;

import android.content.SharedPreferences;

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
    public static SharedPreferences login;

    public boolean authenticate() {


        return true;
    }

}
