package dk.cs.aau.redirector;

import org.junit.Assert;
import org.junit.Test;

/**
 * Created with IntelliJ IDEA.
 * User: Esben
 * Date: 05-03-13
 * Time: 14:33
 * To change this template use File | Settings | File Templates.
 */
public class AccountTest {
    @Test
    public void testAuthenticate() throws Exception {
        Account a = new Account("EsbenPM", "12345");
        Account b = new Account("EsbenPM", null);
        Account c = new Account(null, "12345");
        Account d = new Account(null, null);
        Account e = new Account("", "");

        Assert.assertTrue(a.authenticate());
        Assert.assertFalse(b.authenticate());
        Assert.assertFalse(c.authenticate());
        Assert.assertFalse(d.authenticate());
        Assert.assertFalse(e.authenticate());



    }
}
