//
//  UIImageView+Helper.m
//  FreelancerExam
//
//  Created by Sil Piplay on 7/10/15.
//  Copyright (c) 2015 Panfilo. All rights reserved.
//

#import "UIImageView+Helper.h"

@implementation UIImageView (Helper)

- (void)dimImage {
    /*CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:self.image]; //your input image
    
    CIFilter *filter= [CIFilter filterWithName:@"CIColorControls"];
    [filter setValue:inputImage forKey:@"inputImage"];
    [filter setValue:[NSNumber numberWithFloat:0.9] forKey:@"inputBrightness"];
    
    self.image = [UIImage imageWithCGImage:[context createCGImage:filter.outputImage fromRect:filter.outputImage.extent]];
    /*
    UIGraphicsBeginImageContext(self.image.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.image.size.width, self.image.size.height);
    
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -area.size.height);
    
    CGContextSaveGState(context);
    CGContextClipToMask(context, area, self.image.CGImage);
    
    //UIColor *color = [UIColor blackColor];
    //[color set];
    CGContextFillRect(context, area);
    
    CGContextRestoreGState(context);
    
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    
    CGContextDrawImage(context, area, self.image.CGImage);
    
    UIImage *colorizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.image = colorizedImage;*/
}

@end
