package dk.cs.aau.redirector;

import org.junit.Assert;

/**
 * Created with IntelliJ IDEA.
 * User: Esben
 * Date: 05-03-13
 * Time: 09:22
 * To change this template use File | Settings | File Templates.
 */
public class Communicator {

    public static boolean redirectCall(String num){

        return true;
    }

    public static boolean getContactStatus(){

        return true;
    }

    public static boolean updateStatus(int i){

        return true;
    }

    public static String genAuthorization(){

        return "hej";
    }

    /*
    *
    *
    *
    *
    * @type - accepted input: login, redirect, status. contactstatus. addcontact. updatecontact. deletecontact
     */
    public static boolean sendRequest(String auth, String type){

        return true;
    }

    public static String genJSON(String auth, String cmd){

        return "";
    }

    public static boolean updateContactStatus(String JSON){

        return true;
    }

}
