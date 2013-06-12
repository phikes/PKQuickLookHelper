PKQuickLookHelper
=================

PKQuickLookHelper enables Apple's QuickLook to be used with NSData instead of actual files.

Usage
====

Include the files in your AppCode/XCode Project and be sure you link against the **Quartz and QuickLook** frameworks.

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

Caching
----

It is possible to cache preview items, for later use. This is useful if there is a restricted set
of items a user can perform the quicklook action on.

    [[PKQuickLookHelper sharedHelper] cachePreviewItem:item];

License
====

The MIT License (MIT)

Copyright (c) 2013 Phillip Kessels

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

* In the source code other licensing information may be present. Consider it replaced 
by the above text.
