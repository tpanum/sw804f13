package dk.cs.aau.redirector;

import org.junit.Test;
import org.junit.Assert;
import dk.cs.aau.redirector.*;

import static org.hamcrest.CoreMatchers.*;

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
        Assert.assertEquals("ENCRYPTED AUTH INFOR", Communicator.genAuthorization());

    }

    @Test
    public void testSendRequest() throws Exception {
        Assert.assertTrue(Communicator.sendRequest("JSON STRING", "login"));
        Assert.assertTrue(Communicator.sendRequest("JSON STRING", "redirect"));
        Assert.assertTrue(Communicator.sendRequest("JSON STRING", "status"));
        Assert.assertTrue(Communicator.sendRequest("JSON STRING", "contactstatus"));
        Assert.assertTrue(Communicator.sendRequest("JSON STRING", "addcontact"));
        Assert.assertTrue(Communicator.sendRequest("JSON STRING", "updatecontact"));
        Assert.assertTrue(Communicator.sendRequest("JSON STRING", "deletecontact"));

        Assert.assertFalse(Communicator.sendRequest(null, null));
        Assert.assertFalse(Communicator.sendRequest("", ""));
        Assert.assertFalse(Communicator.sendRequest("ewqeqw", "login"));
        Assert.assertFalse(Communicator.sendRequest("ewqeqw", "redirect"));
        Assert.assertFalse(Communicator.sendRequest("ewqeqw", "status"));
        Assert.assertFalse(Communicator.sendRequest("ewqeqw", "contactstatus"));
        Assert.assertFalse(Communicator.sendRequest("ewqeqw", "addcontact"));
        Assert.assertFalse(Communicator.sendRequest("ewqeqw", "updatecontact"));
        Assert.assertFalse(Communicator.sendRequest("ewqeqw", "deletecontact"));


        Assert.assertFalse(Communicator.sendRequest("JSON STRING", "ledfsdfsddfvs"));


    }

    @Test
    public void testGenJSON() throws Exception {

        String auth = Communicator.genAuthorization();

        Assert.assertEquals("JSON STRING", Communicator.genJSON(auth, "login"));
        Assert.assertEquals("JSON STRING", Communicator.genJSON(auth, "redirect"));
        Assert.assertEquals("JSON STRING", Communicator.genJSON(auth, "status"));
        Assert.assertEquals("JSON STRING", Communicator.genJSON(auth, "contactstatus"));
        Assert.assertEquals("JSON STRING", Communicator.genJSON(auth, "addcontact"));
        Assert.assertEquals("JSON STRING", Communicator.genJSON(auth, "updatecontact"));
        Assert.assertEquals("JSON STRING", Communicator.genJSON(auth, "deletecontact"));

        Assert.assertThat("JSON STRING", is(not(Communicator.genJSON(auth, "fgdsdfsd"))));
        Assert.assertThat("JSON STRING", is(not(Communicator.genJSON("edfdfsdfsdfsdWEFWE", "login"))));
        Assert.assertThat("JSON STRING", is(not(Communicator.genJSON(auth, null))));
        Assert.assertThat("JSON STRING", is(not(Communicator.genJSON(null, "login"))));
    }

    @Test
    public void testUpdateContactStatus() throws Exception {
        Assert.assertTrue(Communicator.updateContactStatus("JSON STRING"));
        Assert.assertFalse(Communicator.updateContactStatus("retard string"));
        Assert.assertFalse(Communicator.updateContactStatus(null));
    }
}
