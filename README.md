# GiphySearcher

Simple Flutter demo for iOS and Android for searching and sharing GIFs using Giphy API

![Screenshot](ScreenshotSearch.png){:height="30%" width="30%"}

## Clone and build project

1) Open terminal and type:
$ cd /your_project_folder/
$ git clone https://github.com/VoropayAndrey/GiphySearcher.git
$ cd GiphySearcher
$ flutter packages get

2) Open project folder with Android Studio and enjoy.

## Install Flutter for iOS and Android, full instruction:

1) First of all you need to have a Mac with macOS Sierra 10.12.6, High Siera 10.13 or MacOS Mojave 10.14. Hackintosh will not work for this case. At least if you really want to have a raging pain in the ass.
Also if you use android virtual devices and iOS simulator your Mac must be powerful enough for handling IDE, AVD and simulator simultaneously. 

2) Install Android Studio 3.0 or later, if you don't have it yet:
https://developer.android.com/studio
You also have a choose between Visual Studio and Android Studio, but I prefer to use Android Studio.

3) After start Android Studio open plugin preferences (Preferences > Plugins)
4) Select Browse repositories, select the Flutter plugin and click Install.
5) Click Yes when prompted to install the Dart plugin.
6) Click Restart when prompted.

7) For downloading Flutter SDK go to:
https://storage.googleapis.com/flutter_infra/releases/stable/macos/flutter_macos_v1.2.1-stable.zip
8) Decompress flutter_macos_v1.2.1-stable.zip file to folder whatever you want. For example:
unzip $HOME/Downloads/flutter_macos_v1.2.1-stable.zip
cp -R $HOME/Downloads/flutter $HOME/Library
9) Add whatever folder in you path permanently like this:

nano $HOME/.bash_profile

export FLUTTER_HOME=/Users/andrey/Library/flutter 
export PATH=${PATH}:$FLUTTER_HOME/bin

Ctrl+O - Save file
Ctrl+X - Close file

To activate your changes type this:
$ source .bash_profile

Now type:
$ echo $PATH

You will see new value of path variable which now contains the Flutter folder.

10) Run this command:
$ flutter doctor -v

11) Download and install Xcode 9.0 or later
https://itunes.apple.com/us/app/xcode/id497799835
https://developer.apple.com/xcode/

12) Agree Xcode license, type:
$ sudo xcodebuild -license
"agree"  

13) Make sure your simulator is using a 64-bit device (iPhone 5s or later) by checking the settings in the simulator’s Hardware > Device menu.

$ open -a Simulator

14) Depending on your development machine’s screen size, simulated high-screen-density iOS devices may overflow your screen. 
Set the device scale under the Window > Scale menu in the simulator.

15) If you don't have Home Brew, please install this:
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

16) Ensure that homebrew is up to date:
$ brew update

17) Install the tools for deploying Flutter apps to iOS devices by running the following commands:

$ brew install --HEAD usbmuxd
$ brew link usbmuxd
$ brew install --HEAD libimobiledevice
$ brew install ideviceinstaller ios-deploy cocoapods
$ pod setup

Follow the Xcode signing flow to provision your project:

18) Open the default Xcode workspace in your project by running open ios/Runner.xcworkspace in a terminal window from your Flutter project directory.
19)In Xcode select the Runner project in the left navigation panel.
20)In the Runner target settings page make sure your Development Team is selected under General > Signing > Team. When you select a team, Xcode creates and downloads a Development Certificate, registers your device with your account, creates and downloads a provisioning profile (if needed).

21) To start your first iOS development project, you may need to sign into Xcode with your Apple ID. 

Development and testing are supported for any Apple ID. 
Enrolling in the Apple Developer Program is required to distribute your app to the App Store. 
For details about membership types see:
https://developer.apple.com/support/compare-memberships/

The first time you use an attached physical device for iOS development, you will need to trust both your Mac and the Development Certificate on that device. 
Select Trust in the dialog prompt during the first connection of the iOS device to your Mac.

22) Then go to the Settings app on the iOS device, select General > Device Management and trust your Certificate.

If automatic signing fails in Xcode, verify that the project’s General > Identity > Bundle Identifier value is unique. 
Start your app by running flutter run.

23) Enable VM acceleration on your machine.
24) Launch Android Studio > Tools > Android > AVD Manager and select Create Virtual Device. 
(The Android submenu is only presented inside an Android project.)
25) Choose a device definition and select Next.
26) Select one or more system images for the Android versions you want to emulate, and select Next. An x86 or x86_64 image is recommended.
Under Emulated Performance select Hardware - GLES 2.0 to enable hardware acceleration.
27) Verify if the AVD configuration is correct and select Finish.
For details on the above steps, visit:
https://developer.android.com/studio/run/managing-avds

28) In Android Virtual Device Manager click Run in the toolbar. The emulator starts up and displays the default canvas for your selected OS version and device.

29) At the end type:
flutter doctor

30) Well done!
