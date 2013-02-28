package dk.aau.cs.redirector;

/**
 * Created with IntelliJ IDEA.
 * User: Computer
 * Date: 25-02-13
 * Time: 10:36
 * To change this template use File | Settings | File Templates.
 */
import dk.aau.cs.redirector.redirector;
import dk.aau.cs.redirector.R;
import com.xtremelabs.robolectric.RobolectricTestRunner;
import org.junit.Test;
import org.junit.runner.RunWith;

import static org.hamcrest.CoreMatchers.equalTo;
import static org.junit.Assert.assertThat;

@RunWith(RobolectricTestRunner.class)
public class redirectorTest {

    @Test
    public void shouldHaveProperAppName() throws Exception{
        String appName = new redirector().getResources().getString(R.string.app_name);
        assertThat(appName, equalTo("redirect"));
    }
}