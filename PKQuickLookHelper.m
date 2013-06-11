//
// Created by Phillip Kessels on 10.06.13.
// Copyright (c) 2013 phikes mobile&desktop. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PKQuickLookHelper.h"


@implementation PKQuickLookHelper


#pragma mark Singleton
+ (PKQuickLookHelper *)defaultHelper
{
    return defaultHelper;
}
+ (void)initialize
{
    defaultHelper = [PKQuickLookHelper new];
    defaultHelper.template = @"temp";
    defaultHelper.queue = [NSOperationQueue new];
    defaultHelper.previewItems = [NSMutableArray new];
}

- (IBAction)toggleQuickLookWindow:(id)sender
{
    if([QLPreviewPanel sharedPreviewPanelExists] && [[QLPreviewPanel sharedPreviewPanel] isVisible])
    {
        [[QLPreviewPanel sharedPreviewPanel] orderOut:self];
    }
    else
    {
        [[QLPreviewPanel sharedPreviewPanel] makeKeyAndOrderFront:self];
    }
}

- (BOOL)acceptsPreviewPanelControl:(QLPreviewPanel *)panel
{
    return YES;
}

- (void)beginPreviewPanelControl:(QLPreviewPanel *)panel
{
    [QLPreviewPanel sharedPreviewPanel].dataSource = self;
    [QLPreviewPanel sharedPreviewPanel].delegate = self;
}

- (void)endPreviewPanelControl:(QLPreviewPanel *)panel
{

}

- (NSInteger)numberOfPreviewItemsInPreviewPanel:(QLPreviewPanel *)panel
{
    return [self.previewItems count];
}

- (id <QLPreviewItem>)previewPanel:(QLPreviewPanel *)panel previewItemAtIndex:(NSInteger)index1
{
    return index1 < [self.previewItems count] ? self.previewItems[(NSUInteger) index1] : nil;
}


@end