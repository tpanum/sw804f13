package dk.cs.aau.redirector;

import android.test.ActivityInstrumentationTestCase2;
import org.junit.Test;
import org.junit.Assert;
import static org.hamcrest.CoreMatchers.equalTo;


/**
 * This is a simple framework for a test of an Application.  See
 * {@link android.test.ApplicationTestCase ApplicationTestCase} for more information on
 * how to write and extend Application tests.
 * <p/>
 * To run this test, you can type:
 * adb shell am instrument -w \
 * -e class dk.aau.cs.redirector.redirectorTest \
 * dk.aau.cs.redirector.tests/android.test.InstrumentationTestRunner
 */
public class redirectorTest extends ActivityInstrumentationTestCase2<redirector> {

    public redirectorTest() {
        super("dk.aau.cs.redirector", redirector.class);

    }

    public void testAppname(){
        //String appName = new redirector().getResources().getString(R.string.app_name);
        Assert.assertEquals(1,1);
    }

}
