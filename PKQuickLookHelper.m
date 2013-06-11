//
// Created by Phillip Kessels on 10.06.13.
// Copyright (c) 2013 phikes mobile&desktop. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PKQuickLookHelper.h"


@implementation PKQuickLookHelper

@dynamic responder;


#pragma mark Singleton
+ (PKQuickLookHelper*)sharedHelper
{
    return sharedHelper;
}

+ (void)initialize
{
    PKLog(@"Initializing the sharedHelper");

    sharedHelper = [PKQuickLookHelper new];
    sharedHelper.template = @"temp";
    sharedHelper.queue = [NSOperationQueue new];
    [sharedHelper createPreviewItemArrayIfNotExists];

    PKLog(@"To make it work: Set an responder (a window e.g) on the sharedHelper");
}

#pragma mark IBActions, etc.

- (IBAction)toggleQuickLookWindow:(id)sender
{
    PKLog(@"Received the toggleQuickLookWindow action");

    if([QLPreviewPanel sharedPreviewPanelExists] && [[QLPreviewPanel sharedPreviewPanel] isVisible])
    {
        [[QLPreviewPanel sharedPreviewPanel] orderOut:self];
        PKLog(@"QLPreviewPanel is visible: hiding it");
    }
    else
    {
        [[QLPreviewPanel sharedPreviewPanel] makeKeyAndOrderFront:self];
        PKLog(@"QLPreviewPanel is not visible: showing it");
    }
}

#pragma mark PKQuickLookHelper

- (void)createPreviewItemArrayIfNotExists
{
    if(!_previewItems)
    {
        _previewItems = [NSMutableArray new];
    }
}

- (void)addPreviewItem:(id <QLPreviewItem>)item
{
    [_previewItems addObject:item];
}

- (void)removePreviewItem:(id <QLPreviewItem>)item
{
    [_previewItems removeObject:item];
}

- (void)removeAllPreviewItems
{
    [_previewItems removeAllObjects];
}

- (NSResponder*)responder
{
    return self.nextResponder;
}

- (void)setResponder:(NSResponder *)responder
{
    if(responder.nextResponder != self)
    {
        self.nextResponder = responder.nextResponder;
        responder.nextResponder = self;
    }
}

#pragma mark QLPreviewPanel delegate/data source

- (BOOL)acceptsPreviewPanelControl:(QLPreviewPanel *)panel
{
    PKLog(@"Received the acceptsPreviewPanelControl delegate message");
    return YES;
}

- (void)beginPreviewPanelControl:(QLPreviewPanel *)panel
{
    PKLog(@"Gained control over the QLPreviewPanel");
    [QLPreviewPanel sharedPreviewPanel].dataSource = self;
    [QLPreviewPanel sharedPreviewPanel].delegate = self;
}

- (void)endPreviewPanelControl:(QLPreviewPanel *)panel
{
    PKLog(@"Lost control over the QLPreviewPanel");
}

- (NSInteger)numberOfPreviewItemsInPreviewPanel:(QLPreviewPanel *)panel
{
    NSUInteger count = self.previewItems.count;

    PKLog(@"QLPreviewPanel asked for numberOfPreviewItemsInPreviewPanel. %lu items are present", count);
    return count;
}

- (id <QLPreviewItem>)previewPanel:(QLPreviewPanel *)panel previewItemAtIndex:(NSInteger)index1
{
    PKLog(@"QLPreviewPanel asked for previewItemAtIndex with index %lu", index1);

    return index1 < [self.previewItems count] ? self.previewItems[(NSUInteger) index1] : nil;
}


@end