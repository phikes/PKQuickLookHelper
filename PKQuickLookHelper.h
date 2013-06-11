//
// Created by Phillip Kessels on 10.06.13.
// Copyright (c) 2013 phikes mobile&desktop. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import <Quartz/Quartz.h>

@class PKQuickLookHelper;

static PKQuickLookHelper* defaultHelper;



@interface PKQuickLookHelper : NSResponder<QLPreviewPanelDataSource, QLPreviewPanelDelegate>

+ (PKQuickLookHelper*)defaultHelper;

- (IBAction)toggleQuickLookWindow:(id)sender;

@property(nonatomic, strong) NSString* template;
@property(nonatomic, strong) NSOperationQueue* queue;
@property(nonatomic, strong) NSMutableArray* previewItems; //TODO use non-mutable array to the outside

@end