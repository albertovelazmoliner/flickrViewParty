//
//  DetailViewController.h
//  trycatchProof
//
//  Created by Alberto Velaz Moliner on 26/06/15.
//  Copyright (c) 2015 Alberto Velaz Moliner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UIScrollViewDelegate>
@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) UIImageView *imgView;


- (void)setURL:(NSURL *)url;

@end

