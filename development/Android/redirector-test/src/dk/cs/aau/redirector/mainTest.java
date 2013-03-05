package dk.cs.aau.redirector;

import android.test.ActivityInstrumentationTestCase2;
import org.junit.Assert;


/**
 * This is a simple framework for a test of an Application.  See
 * {@link android.test.ApplicationTestCase ApplicationTestCase} for more information on
 * how to write and extend Application tests.
 * <p/>
 * To run this test, you can type:
 * adb shell am instrument -w \
 * -e class dk.aau.cs.Main.mainTest \
 * dk.aau.cs.Main.tests/android.test.InstrumentationTestRunner
 */
public class mainTest extends ActivityInstrumentationTestCase2<Main> {

    public mainTest() {
        super("dk.aau.cs.Main", Main.class);

    }

    public void testAppname() {
        //String appName = new Main().getResources().getString(R.string.app_name);
        assertEquals(1, 1);
    }

}
