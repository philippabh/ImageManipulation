//
//  ViewController.h
//  imageManipulation
//
//  Created by Philippa Bentley on 15/05/2013.
//  Copyright (c) 2013 Philippa Bentley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>

@interface ViewController : UIViewController
{
    IBOutlet UIImageView *image_display;
    UIPopoverController *popover;
    UIImage *original_image;
}
@end
