//
//  DropView.m
//  iconMaker
//
//  Created by Chen Yu-Chun on 2016/3/2.
//  Copyright © 2016年 Chen Yu-Chun. All rights reserved.
//

#import "DropView.h"

@implementation DropView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    [self.image drawInRect:dirtyRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0f];
}

- (void)initDrop {
    NSLog(@"initDrop");
//    self.layer.borderWidth = 1.0f;
//    self.layer.borderColor = [[NSColor redColor]CGColor];
    [self registerForDraggedTypes:[NSArray arrayWithObjects:
                                   NSURLPboardType, nil]];

    self.image = [NSImage imageNamed:@"sectoin_add.png"];
    [self setNeedsDisplay:YES];
}

-(NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender {
    NSLog(@"Entered");
    return NSDragOperationNone;
}

-(NSDragOperation)draggingUpdated:(id<NSDraggingInfo>)sender {
    NSLog(@"Dragging Update");
    return NSDragOperationCopy;
}

-(void)draggingExited:(id<NSDraggingInfo>)sender {
    NSLog(@"Exited");
}

-(void)draggingEnded:(id<NSDraggingInfo>)sender {
    NSLog(@"Ended");
}

-(BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender {
    return YES;
}

-(BOOL)performDragOperation:(id<NSDraggingInfo>)sender {
    if ([NSImage canInitWithPasteboard:[sender draggingPasteboard]] == YES) {
        NSImage *image = [[NSImage alloc]initWithPasteboard:[sender draggingPasteboard]];
        self.image = image;
        
        if (self.getimageblock != nil) {
            self.getimageblock(image);
        }
    }
    return YES;
}

-(void)concludeDragOperation:(id<NSDraggingInfo>)sender {
    [self setNeedsDisplay:YES];
}
@end
