//
//  AppDelegate.m
//  Lesson_1
//
//  Created by jiesu on 2019/4/3.
//  Copyright © 2019 jiesu. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    NSLog(@"AppDelegate:applicationDidFinishLaunching");
    NSProcessInfo* process = [NSProcessInfo processInfo];
    self._activity = [process beginActivityWithOptions : NSActivityUserInitiated | NSActivityLatencyCritical
                               reason : @"Lesson_1"];
    
    [self registerNotifications];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    NSLog(@"AppDelegate:applicationWillTerminate");
    [self unregisterNotifications];
}

- (void) receiveSleepNote: (NSNotification*) note
{
    NSLog(@"AppDelegate:receiveSleepNote %@", [note name]);
    NSProcessInfo* process = [NSProcessInfo processInfo];
    [process endActivity:self._activity];
    self._activity = nil;
}

- (void) receiveWakeNote: (NSNotification*) note
{
    NSLog(@"AppDelegate:receiveWakeNote %@", [note name]);
    NSProcessInfo* process = [NSProcessInfo processInfo];
    self._activity = [process beginActivityWithOptions : NSActivityUserInitiated | NSActivityLatencyCritical
                                                reason : @"Lesson_1"];
}

- (void)receiveScreenDidSleepNote: (NSNotification*)note
{
    NSLog(@"AppDelegate:receiveScreenDidSleepNote %@", [note name]);
}

- (void)receiveScreenDidWakeNote: (NSNotification*)note
{
    NSLog(@"AppDelegate:receiveScreenDidWakeNote %@", [note name]);
}

- (void) registerNotifications
{
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver: self
                                                           selector: @selector(receiveSleepNote:)
                                                               name: NSWorkspaceWillSleepNotification object: NULL];
    
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver: self
                                                           selector: @selector(receiveWakeNote:)
                                                               name: NSWorkspaceDidWakeNotification object: NULL];
    
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver: self
                                                           selector: @selector(receiveScreenDidSleepNote:)
                                                               name: NSWorkspaceScreensDidSleepNotification object: NULL];
    
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver: self
                                                           selector: @selector(receiveScreenDidWakeNote:)
                                                               name: NSWorkspaceScreensDidWakeNotification object: NULL];
}

- (void)unregisterNotifications
{
    [[[NSWorkspace sharedWorkspace] notificationCenter] removeObserver:self];
}

@end
