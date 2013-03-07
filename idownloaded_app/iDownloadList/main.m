//
//  main.m
//  iDownloadList
//
//  Created by Jason Campisi on 3/6/13.
//  Copyright (c) 2013 Jason Campisi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <AppleScriptObjC/AppleScriptObjC.h>

int main(int argc, char *argv[])
{
    [[NSBundle mainBundle] loadAppleScriptObjectiveCScripts];
    return NSApplicationMain(argc, (const char **)argv);
}
