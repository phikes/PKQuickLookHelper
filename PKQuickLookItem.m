//
// Created by Phillip Kessels on 10.06.13.
// Copyright (c) 2013 phikes mobile&desktop. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PKQuickLookItem.h"
#import "PKQuickLookHelper.h"


@implementation PKQuickLookItem {
    NSString *_fileExtension;
}

- (id)initWithContent:(NSString *)content fileExtension:(NSString*)fileExtension
{
    self = [super init];
    if(self)
    {
        _content = content;
        _fileExtension = fileExtension;
        _helper = [PKQuickLookHelper defaultHelper];
        _busy = NO;
    }
    return self;
}

#pragma mark QLPreviewItem

- (NSString *)previewItemTitle
{
    return self.title;
}

- (NSURL *)previewItemURL
{
    NSURL* ret = nil;

    if(!_busy)
    {
        if(_tempFileURL)
        {
            ret = _tempFileURL;
        }
        else
        {
            [[_helper queue] addOperationWithBlock:^{
                _busy = YES;
                [self createTempFile];
                _busy = NO;
                [[QLPreviewPanel sharedPreviewPanel] refreshCurrentPreviewItem];
            }];
        }
    }
    return ret;
}

- (void)createTempFile
{
    NSString* template = [NSTemporaryDirectory() stringByAppendingString:[[PKQuickLookHelper defaultHelper] template]];
    template = [template stringByAppendingString:@"XXXXXX"];
    //TODO layout to helper ^

    const char* templateCString = [template fileSystemRepresentation];

    char *tempFileNameCString = (char*) malloc(strlen(templateCString) + 1);
    strcpy(tempFileNameCString, templateCString);

    _fileDescriptor = mkstemp(tempFileNameCString);

    if(_fileDescriptor == -1)
    {
        //TODO error
    }

    NSString* file = [[NSFileManager defaultManager] stringWithFileSystemRepresentation:tempFileNameCString
                                                                                 length:strlen(tempFileNameCString)];
    NSFileHandle* fileHandle = [[NSFileHandle alloc] initWithFileDescriptor:_fileDescriptor];

    [[NSFileManager defaultManager] moveItemAtPath:file
                                            toPath:[file stringByAppendingString:_fileExtension] error:nil];
    //TODO error
    file = [file stringByAppendingString:_fileExtension]; //TODO argument should not have the dot

    //write the file
    [fileHandle seekToEndOfFile];
    [fileHandle writeData:[_content dataUsingEncoding:NSUTF8StringEncoding]];
    [fileHandle closeFile];

    free(tempFileNameCString);

    _tempFileURL = [NSURL fileURLWithPath:file];
}

- (void)dealloc
{
    //TODO
}

@end