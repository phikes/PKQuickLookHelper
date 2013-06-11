//
// Created by Phillip Kessels on 10.06.13.
// Copyright (c) 2013 phikes mobile&desktop. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import <Quartz/Quartz.h>

@class PKQuickLookHelper;


@interface PKQuickLookItem : NSObject<QLPreviewItem>
{
    NSString* _content;

    int _fileDescriptor;

    NSURL* _tempFileURL;

    PKQuickLookHelper* _helper; //TODO allow change of hlper

    BOOL _busy;
}

- (id)initWithContent:(NSString*)content fileExtension:(NSString*)fileExtension;

@property (strong, nonatomic) NSString* title;

@end