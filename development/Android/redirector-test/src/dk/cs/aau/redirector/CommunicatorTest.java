package dk.cs.aau.redirector;

import org.junit.Test;
import org.junit.Assert;

/**
 * Created with IntelliJ IDEA.
 * User: Esben
 * Date: 05-03-13
 * Time: 09:48
 * To change this template use File | Settings | File Templates.
 */
public class CommunicatorTest {
    @Test
    public void testRedirectCall() throws Exception {
        Assert.assertTrue(Communicator.redirectCall("607"));
        Assert.assertFalse(Communicator.redirectCall(null));
        Assert.assertFalse(Communicator.redirectCall(""));
        Assert.assertFalse(Communicator.redirectCall("999999999999999999"));
        Assert.assertTrue(Communicator.redirectCall("+4528705550"));

    }

    @Test
    public void testGetContactStatus() throws Exception {
        Assert.assertTrue(Communicator.getContactStatus());
    }

    @Test
    public void testUpdateStatus() throws Exception {
        Assert.assertTrue(Communicator.updateStatus(1));
        Assert.assertFalse(Communicator.updateStatus(12133412));

    }

    @Test
    public void testGenAuthorization() throws Exception {

    }

    @Test
    public void testSendRequest() throws Exception {

    }

    @Test
    public void testGenJSON() throws Exception {

    }

    @Test
    public void testUpdateContactStatus() throws Exception {

    }
}
