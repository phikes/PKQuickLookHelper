//
// Created by Phillip Kessels on 10.06.13.
// Copyright (c) 2013 phikes mobile&desktop. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//

#define PK_DEBUG

#ifdef PK_DEBUG
    #define PKLog(x...) NSLog(x)
#else
    #define PKLog(x)
#endif


#import <Foundation/Foundation.h>
#import <Quartz/Quartz.h>

@class PKQuickLookHelper;

static PKQuickLookHelper*sharedHelper;



@interface PKQuickLookHelper : NSResponder<QLPreviewPanelDataSource, QLPreviewPanelDelegate>
{
    NSMutableArray* _previewItems;
}

+ (PKQuickLookHelper*)sharedHelper;

- (IBAction)toggleQuickLookWindow:(id)sender;

- (void)addPreviewItem:(id<QLPreviewItem>)item;
- (void)removePreviewItem:(id<QLPreviewItem>)item;

- (void)removeAllPreviewItems;


@property(nonatomic, strong) NSString* template;
@property(nonatomic, strong) NSOperationQueue* queue;
@property(nonatomic, readonly) NSArray* previewItems;

@property(nonatomic, weak) NSResponder* responder;

@end