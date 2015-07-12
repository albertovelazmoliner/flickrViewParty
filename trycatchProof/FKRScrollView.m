//
//  FKRScrollView.m
//  trycatchProof
//
//  Created by Alberto Velaz Moliner on 30/06/15.
//  Copyright © 2015 Alberto Velaz Moliner. All rights reserved.
//

#import "FKRScrollView.h"

@interface FKRScrollView () {}

@property (nonatomic) float zoomedInScale;

@property (nonatomic) float naturalZoomScale;

@end

@implementation FKRScrollView

-(id)initWithCoder:(NSCoder *)aDecoder {
    NSLog(@"%s",__PRETTY_FUNCTION__);
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor blackColor];
        
        super.delegate = self;
        
        self.imageView = [[UIImageView alloc] initWithFrame:self.frame];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.imageView];
        
    }
    return self;
}


-(void)setupScales {
    self.maximumZoomScale = 2.0f;
    self.minimumZoomScale = 1.0f;
}


-(void)setImage:(UIImage *)image {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.imageView.image = image;
        self.imageView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        [self setupScales];
    });
    
    NSLog(@"The image frame is: %@",NSStringFromCGRect(self.imageView.frame));
    
}

#pragma mark - UIScrollViewDelegate methods
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

@end
