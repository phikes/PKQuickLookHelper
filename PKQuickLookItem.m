//
// Created by Phillip Kessels on 10.06.13.
// Copyright (c) 2013 phikes mobile&desktop. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PKQuickLookItem.h"
#import "PKQuickLookHelper.h"


@implementation PKQuickLookItem {
}

- (id)initWithData:(NSData *)data fileExtension:(NSString*)fileExtension
{
    self = [super init];
    if(self)
    {
        _data = data;
        _extension = [@"." stringByAppendingString: fileExtension];
        _helper = [PKQuickLookHelper sharedHelper];
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
    NSString* template = [NSTemporaryDirectory() stringByAppendingString:[[PKQuickLookHelper sharedHelper] template]];
    template = [template stringByAppendingString:@"XXXXXX"];

    const char* templateCString = [template fileSystemRepresentation];

    char *tempFileNameCString = (char*) malloc(strlen(templateCString) + 1);
    strcpy(tempFileNameCString, templateCString);

    PKLog(@"Creating temporary file.");
    _fileDescriptor = mkstemp(tempFileNameCString);

    if(_fileDescriptor == -1)
    {
        PKLog(@"Could not create temporary file. Aborting.");
        return;
    }

    NSString* file = [[NSFileManager defaultManager] stringWithFileSystemRepresentation:tempFileNameCString
                                                                                 length:strlen(tempFileNameCString)];
    PKLog(@"Created temporary file at %@", file);
    NSFileHandle* fileHandle = [[NSFileHandle alloc] initWithFileDescriptor:_fileDescriptor];

    NSError* err;
    [[NSFileManager defaultManager] moveItemAtPath:file
                                            toPath:[file stringByAppendingString:_extension] error:&err];
    if(err)
    {
        PKLog(@"Unable to process temporary file. Aborting.");
    }
    file = [file stringByAppendingString:_extension];
    PKLog(@"Renamed file to %@", file);

    //write the file
    PKLog(@"Writing data to file: %@", file);
    [fileHandle seekToEndOfFile];
    [fileHandle writeData:_data];
    [fileHandle closeFile];

    free(tempFileNameCString);

    _tempFileURL = [NSURL fileURLWithPath:file];
}
@end