//
//  DropView.h
//  iconMaker
//
//  Created by Chen Yu-Chun on 2016/3/2.
//  Copyright © 2016年 Chen Yu-Chun. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@interface DropView : NSView<NSDraggingDestination>

@property (strong, nonatomic) NSImage *image;

@property (copy, nonatomic) void (^getimageblock)(NSImage *image);


- (void)initDrop;
@end
