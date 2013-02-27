package dk.aau.cs.redirect_test;

/**
 * Created with IntelliJ IDEA.
 * User: Computer
 * Date: 25-02-13
 * Time: 10:36
 * To change this template use File | Settings | File Templates.
 */
import dk.aau.cs.redirect.redirect;
import dk.aau.cs.redirect.R;
import com.xtremelabs.robolectric.RobolectricTestRunner;
import org.junit.Test;
import org.junit.runner.RunWith;

import static org.hamcrest.CoreMatchers.equalTo;
import static org.junit.Assert.assertThat;

@RunWith(RobolectricTestRunner.class)
public class redirectTest {

    @Test
    public void shouldHaveProperAppName() throws Exception{
        String appName = new redirect().getResources().getString(R.string.app_name);
        assertThat(appName, equalTo("redirect"));
    }
}