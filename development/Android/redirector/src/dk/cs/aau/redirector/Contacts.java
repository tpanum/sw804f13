package dk.cs.aau.redirector;

/**
 * Created with IntelliJ IDEA.
 * User: Esben
 * Date: 05-03-13
 * Time: 13:21
 * To change this template use File | Settings | File Templates.
 */
public class Contacts extends Person {

    public String nick;

   public Contacts(int id, String name, int status, String num, String nick){
       this.id = id;
       this.name = name;
       this.status = status;
       this.number = num;
       this.nick = nick;
   }

    public boolean create(){

        return true;
    }

    public boolean update(){

        return true;

    }

    public boolean delete(){

        return true;
    }
}