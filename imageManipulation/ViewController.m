//
//  ViewController.m
//  imageManipulation
//
//  Created by Philippa Bentley on 15/05/2013.
//  Copyright (c) 2013 Philippa Bentley. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate> 

@end

@implementation ViewController


//function to turn the picture black & white...
- (void)makeBlackAndWhite:(UIImage *)image
{
    //change the image from a UIImage to a core image (CIImage) in order to use the filter libraries in CoreImage...
    CIImage *starting_image = [CIImage imageWithCGImage:image.CGImage];
    
    //make a filter called black_and_white...
    CIFilter *black_and_white = [CIFilter filterWithName:@"CIColorControls"];
    [black_and_white setValue:starting_image forKey:kCIInputImageKey];
    [black_and_white setValue:[NSNumber numberWithFloat:0.0] forKey:@"inputBrightness"];
    [black_and_white setValue:[NSNumber numberWithFloat:1.1] forKey:@"inputContrast"];
    [black_and_white setValue:[NSNumber numberWithFloat:0.0] forKey:@"inputSaturation"];
    
    CIImage *result_image = [black_and_white valueForKey:kCIOutputImageKey];
    
    //convert image back to a UIImage...
    CIContext *result_context = [CIContext contextWithOptions:nil];
    CGImageRef result_cg = [result_context createCGImage:result_image fromRect:[result_image extent]];
    UIImage *final_image = [UIImage imageWithCGImage:result_cg];
    
    image_display.image = final_image;
    
}


//function to add a vignette...
- (void)addVignette:(UIImage *)image
{
    //change the image from a UIImage to a core image (CIImage) in order to use the filter libraries in CoreImage...
    CIImage *starting_image = [CIImage imageWithCGImage:image.CGImage];
    
    //make a filter called black_and_white...
    CIFilter *black_and_white = [CIFilter filterWithName:@"CIVignette"];
    [black_and_white setValue:starting_image forKey:kCIInputImageKey];
    [black_and_white setValue:[NSNumber numberWithFloat:0.8] forKey:@"inputIntensity"];
    [black_and_white setValue:[NSNumber numberWithFloat:1.0] forKey:@"inputRadius"];
        
    CIImage *result_image = [black_and_white valueForKey:kCIOutputImageKey];
    
    //convert image back to a UIImage...
    CIContext *result_context = [CIContext contextWithOptions:nil];
    CGImageRef result_cg = [result_context createCGImage:result_image fromRect:[result_image extent]];
    UIImage *final_image = [UIImage imageWithCGImage:result_cg];
    
    image_display.image = final_image;
    
}



- (IBAction) button_action:(UIButton *)button
{
   
    if (button.tag == 1)
    {
        [self makeBlackAndWhite:original_image];
    }
    else if (button.tag == 2)
    {
        //Get Image button has been pressed
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        //make self the delegate... (picker is image picker to choose image)
        picker.delegate = self;
        
        //if a camera is supported...
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
        {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
        }
        else
        {
            //if camera isn't available and if device is an iPad...
            picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
               {
                   popover = [[UIPopoverController alloc] initWithContentViewController:picker];
                   [popover presentPopoverFromRect:button.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                }
            else
               {
                   [self presentViewController:picker animated:YES completion:nil];
               }
        }
    }
    else if (button.tag == 3)
    {
        [self addVignette:original_image];
    }
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        [popover dismissPopoverAnimated:YES];
        
        //print out the contents of the dictionary...
        NSLog(@"%@", info);
        
        //cast the returned contents of the dictionary? to be a UIImage type
        original_image =(UIImage *) [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        //putting our image into the image view
        image_display.image = original_image;
    }


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
