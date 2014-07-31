Appcelerator Titanium :: Crittercism
=============

An Appcelerator Titanium module that integrates the Crittercism SDK (http://www.crittercism.com/) for Crash Reporting.

<h2>Supports</h2>

<h3>Devices</h3>
  - iPhone (Tested with 3GS, 4, 4s, 5, 5c and 5s)
  - iPad (Tested with multiple iPads)
  - iPod Touch
  - Ton's and tons of Android devices

<h3>iOS Versions</h3>
  - 6.0+ (up to the latest iOS 7)

  * __NOTE:__ I have not tested against iOS8 Beta yet but will be doing that in the coming months (but feel free to try it and let me know :) ) 

<h3>Android Versions</h3>
  - 4.0+

  * __NOTE:__ I am sure that this module would work on older versions as well, if it does not let me know and I'll fix it up!

<h3>Titanium SDK Versions</h3>
  - 3.2.0
  - 3.2.1
  - 3.2.3
  - 3.3.0

  * __Note:__ I am sure it works on many more versions than this, but these are just the one's I've used

<h2>Setup</h2>

Include the module in your tiapp.xml:

<pre><code>
crittercism

</code></pre>

<h2>Usage</h2>

<pre><code>
var Crittercism = require('crittercism'); // Initialize the SquareCamera module

//
// *** Start it up! *** 
//

var app_id = "unique_ios_app_id_from_crittercism";

if(Ti.Platform.osname == 'android'){
  app_id = "unique_android_app_id_from_crittercism";
};

Crittercism.start({
  appID: app_id,
  customAppVersion: "testing_version_1", // Optional (Available on Android Only - Will be ignored on iOS)
  setLogcatReportingEnabled: true // Optional (Available on Android Only - Will be ignored on iOS)
});

//
// *** Set this Users Name (can be used to lookup a user in Crittercism) *** 
// NOTE: This can be set at any time and setting it again will override the last username
//

Crittercism.setUsername("test_user");

//
// *** Set some metadata on the user *** 
// NOTE: This can be set at any time and setting it again will override the last username
//

Crittercism.setMetaData({
  tag_1: "tag_1_value",
  tag_2: false,
  test_3: ""
});

//
// *** Create a Crash Button *** 
// NOTE: It's possible that this doesn't crash the app 100% of the time :(
//

var crash_button = Ti.UI.createButton({title: 'Crash App', bottom: 130, height : 50});

crash_button.addEventListener('click',function(e)
{
  Crittercism.crash("-- crashing via button click --");
});

//
// *** Create a Handled Exception Button *** 
//

var create_exception_button = Ti.UI.createButton({title: 'Create Exception', bottom: 70, height : 50});

create_exception_button.addEventListener('click',function(e)
{      
  Crittercism.logHandledException({
    name: "SAMPLE EXCEPTION",
    reason: "Testing an exception"
  });
});

//
// *** Leave a Breadcrumb *** 
//

var breadcrumb_button = Ti.UI.createButton({title: 'Drop Breadcrumb', bottom: 10, height : 50, width: 200});

var crumb_count = 0;

breadcrumb_button.addEventListener('click',function(e)
{
  crumb_count += 1;
  
  var breadcrumb = "dropping a crumb "+crumb_count;
  
  breadcrumb_button.title = "Drop Breadcrumb ("+crumb_count+")";

  Crittercism.leaveBreadcrumb(breadcrumb);
});

//
// *** Open the Window *** 
//

var win = Ti.UI.createWindow({
  backgroundColor:'white'
});

win.add(crash_button);
win.add(create_exception_button);
win.add(breadcrumb_button);

win.open();

</code></pre>

<h2>Functions</h2>

<h3>Crittercism.start();</h3>

Starting up the Crittercism SDK

<h4>Takes:</h4>
 - appID: Your application id from Crittercism
 - customAppVersion: A version to display in Crittercism (ANDROID ONLY - Will be ignored in iOS - Version from tiapp.xml will be used)
 - setLogcatReportingEnabled: Send more logging (ANDROID ONLY - Will be ignored in iOS)

<h3>Crittercism.setUsername(name);</h3>

Sets a username for the current user session

<h3>Crittercism.setMetaData(tags);</h3>

Takes a hash of tags and values to store on the current user. This will be visible in Crittercism and can help figure out a users settings that lead to a crash (or whatever you want :)).

<h3>Crittercism.leaveBreadcrumb(crumb);</h3>

Drops a breadcrumb that will be used to help follow a user through various flows. On crash, the last 99 crumbs will be sent along with it.

<h3>Crittercism.crash(reason);</h3>

Panic and crash the app for a certain reason (more of a suggestion.. it __usually__ crashes the app :) Good exception handling by Titanium in dev mode makes this not 100% perfect).

<h3>Crittercism.logHandledException();</h3>

Starting up the Crittercism SDK

<h4>Takes:</h4>
 - name: A name/title to send with the error
 - reason: Why did it crash!? Oh. Type that here

<h2>Known Issues and Future Improvements</h2>

1. Allow something to happen if your last load was a crash (a callback on load the next time)

<h2>Please let me know if you'd like any additions or something isn't working!</h2>

<h3>License</h3>
Do whatever you want, however you want, whenever you want. And if you find a problem on your way, let me know so I can fix it for my own apps too :)

<h3>Other Stuff</h3>

http://www.crittercism.com/
