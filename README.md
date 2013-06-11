PKQuickLookHelper
=================

PKQuickLookHelper enables Apple's QuickLook to be used with NSData instead of actual files.

Usage
====

Initializing the sharedHelper
----

    //assuming we are in a class which is in the responder chain
    [PKQuickLookHelper sharedHelper].responder = self; //inserts the sharedHelper into the responder chain



Creating preview items
----

    PKQuickLookItem* item = PKQuickLookItem* item = [[PKQuickLookItem alloc] initWithData:[@"Test" dataUsingEncoding:NSUTF8StringEncoding] 
                                                                            fileExtension:@"txt"];
    [[PKQuickLookHelper sharedHelper] addPreviewItem:item]; //you can add any class conforming to QLPreviewItem! (e.g. NSURL)



Showing the preview panel
----

    [[PKQuickLookHelper sharedHelper] toggleQuickLookWindow:self];


* The source files are also documented!
