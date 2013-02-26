package dk.aau.cs.redirect;

import android.test.ActivityInstrumentationTestCase2;

/**
 * This is a simple framework for a test of an Application.  See
 * {@link android.test.ApplicationTestCase ApplicationTestCase} for more information on
 * how to write and extend Application tests.
 * <p/>
 * To run this test, you can type:
 * adb shell am instrument -w \
 * -e class dk.aau.cs.redirect.redirectTest \
 * dk.aau.cs.redirect.tests/android.test.InstrumentationTestRunner
 */
public class redirectTest extends ActivityInstrumentationTestCase2<redirect> {

    public redirectTest() {
        super("dk.aau.cs.redirect", redirect.class);
    }

}
