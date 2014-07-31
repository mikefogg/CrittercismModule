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

var breadcrumb_button = Ti.UI.createButton({title: 'Drop Breadcrumb', bottom: 10, height : 50});

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