package dk.cs.aau.redirector;

import org.junit.Assert;
import org.junit.Test;

/**
 * Created with IntelliJ IDEA.
 * User: Esben
 * Date: 05-03-13
 * Time: 15:12
 * To change this template use File | Settings | File Templates.
 */
public class ContactsTest {

    //true
    public Contacts a = new Contacts(1, "EsbenPM", 1, "88888888", "PM");
    //false
    public Contacts b = new Contacts(1, null, 1, "88888888", "PM");
    public Contacts c = new Contacts(1, "EsbenPM", 1, null, "PM");
    public Contacts d = new Contacts(1, "EsbenPM", 1, "88888888", null);
    public Contacts e = new Contacts(1, "EsbenPM", 1, "8888834343434fdffd888", "PM");
    public Contacts f = new Contacts(1, "EsbenPM", 1, "fdffd", "PM");
    public Contacts g = new Contacts(1, "EsbenPM", -1, "fdffd", "PM");
    public Contacts h = new Contacts(-1, "EsbenPM", 1, "fdffd", "PM");

    @Test
    public void testCreate() throws Exception {

         Assert.assertTrue(a.create());
        Assert.assertFalse(b.create());
        Assert.assertFalse(c.create());
        Assert.assertFalse(d.create());
        Assert.assertFalse(e.create());
        Assert.assertFalse(f.create());
        Assert.assertFalse(g.create());
        Assert.assertFalse(h.create());


    }

    @Test
    public void testUpdate() throws Exception {
        Assert.assertTrue(a.update());
        Assert.assertFalse(b.update());
        Assert.assertFalse(c.update());
        Assert.assertFalse(d.update());
        Assert.assertFalse(e.update());
        Assert.assertFalse(f.update());
        Assert.assertFalse(g.update());
        Assert.assertFalse(h.update());



    }


    @Test
    public void testDelete() throws Exception {
        //a must exist for the method to succeed
        Assert.assertTrue(a.delete());
    }
}
