/**
 * CrittercismModule
 *
 * Created by Your Name
 * Copyright (c) 2014 Your Company. All rights reserved.
 */

#import "CrittercismModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

#import "Crittercism.h"

@implementation CrittercismModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"1d150bda-33b2-4489-84f1-4630affc1b05";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"crittercism";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];

	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably

	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs


//
//  Initialize Crittercism with
//
//  Crittercism.start({
//    appID: "1234567"
//  });
//

-(void)start:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    NSLog(@"[CrittercismModule] Starting Crittercism!");
    
    @try {
        NSString *app_id;
        ENSURE_ARG_OR_NIL_FOR_KEY(app_id, args, @"appID", NSString);

        [Crittercism enableWithAppID:app_id andDelegate:self];
    } @catch (NSException *exception) {
        NSLog(@"[CrittercismModule] Failed to start.");
    }
}

//
//  Crash the app :)
//
//  Crittercism.crash();
//

-(void)crash:(NSString *)reason
{    
    ENSURE_SINGLE_ARG(reason, NSString);

    if(!reason){
        reason = @"[CrittercismModule] Crashing your app! Take that!";
    };
    
    assert(! reason);
}

//
//  Store a username for the current user
//
//  Crittercism.setUsername("mike-fogg");
//

-(void)setUsername:(NSString *)name
{
    ENSURE_SINGLE_ARG(name, NSString);

    @try {
        [Crittercism setUsername:name];
    } @catch (NSException *exception) {
        // Well... that didn't work...
    }
}

//
//  Drop a breadcrumb to be sent with the crash report
//
//  Crittercism.leaveBreadcrumb("visit_home_page");
//

-(void)leaveBreadcrumb:(NSString *)crumb
{
    ENSURE_SINGLE_ARG(crumb, NSString);

    @try {
        [Crittercism leaveBreadcrumb:crumb];
    } @catch (NSException *exception) {
        // Well... that didn't work...
    }
}

//
//  Changing a users OptOut status
//
//  Crittercism.setOptOutStatus(false);
//

-(void)setOptOutStatus:(bool *)status
{
    @try {
        [Crittercism setOptOutStatus:status];
    } @catch (NSException *exception) {
        // Well... that didn't work...
    }
}

//
//  Log handled exception
//
//  Crittercism.logHandledException({
//    name: "Login Error",
//    reason: "Incorrect email and password"
//  });
//

-(void)logHandledException:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    @try {
        NSString *name = [args objectForKey:@"name"];
        NSString *reason = [args objectForKey:@"reason"];
        NSException *exception = [[NSException alloc] initWithName:name reason:reason userInfo:nil];
        
        [Crittercism logHandledException:exception];
    } @catch (NSException *exception) {
        // Well... that didn't work...
    }
}

//
//  Set MetaData for a user
//
//  Crittercism.setMetaData({
//    has_feature: true,
//    email_address: "test@example.com"
//  });
//

-(void)setMetaData:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    for(id key in args){
        @try {
            [Crittercism setValue:[args objectForKey:key] forKey:key];
        } @catch (NSException *exception) {
            // Well... that didn't work...
        }
    }
}

#pragma mark CrittercismDelegate Method

- (void)crittercismDidCrashOnLastLoad {
    NSLog(@"[CrittercismModule] App crashed the last time it was loaded!");
}

@end
