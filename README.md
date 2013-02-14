# Name of app goes here #
This is some interresting text, which should describe what our amazing project does.

## Installation for Development ##
This app is being developed with the philosphy of having testing driven development. In short, this means that you write tests for your functionality before coding it, so please keep this in mind if you consider further development.
### iOS ###
To secure not committing unvalid code, a GitHook script was created, which performs every test for the project and ensure that they all pass. If they do not pass, you'll be prompted with the message of resolving your code before being allowed to commit.

The following steps will guide you through how to setup a development environment on Mac OSX.

1.	Something somethig open project in Xcode
2.	Copy `pre-commit` in `/hooks/iOS/` into your local `/.git/hooks/`
3. 	Do something

* Write something about GHunit hacks (ie: see arbejdsblade)

### Android ###
1. Import the project in IntelliJ, the Android SDK (http://developer.android.com/sdk/index.html) needs to be placed at: `C:/Android/sdk` for the testing to work.
2. All testing is done with Robolectric which ports everything to the JVM. To test simply right click the test file and select "Run 'TheNameOfTheTest' with coverage".
3. Do something

X. If the IDE can't locate the android SDK even though it is specified, run the following command: android update project -p <your project directory>. The android bash command is found in the android SDK.