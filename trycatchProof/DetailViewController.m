//
//  DetailViewController.m
//  trycatchProof
//
//  Created by Alberto Velaz Moliner on 26/06/15.
//  Copyright (c) 2015 Alberto Velaz Moliner. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "SMScrollView.h"

@interface DetailViewController ()
@property (nonatomic, strong) SMScrollView *myScrollView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setURL:(NSURL *)url {
    self.url = url;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    [self configureView];
}

- (void)configureView {
    self.imgView = [[UIImageView alloc] init];

    self.myScrollView = [[SMScrollView alloc] initWithFrame:self.view.bounds];
    self.myScrollView.maximumZoomScale = 2;
    self.myScrollView.delegate = self;
    self.myScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    NSURLRequest *request =[[NSURLRequest alloc] initWithURL:self.url];
    __weak DetailViewController *weakSelf = self;
    [self.imgView setImageWithURLRequest:request placeholderImage:nil
        success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {

            weakSelf.imgView = [[UIImageView alloc] initWithImage:image];
            weakSelf.imgView.contentMode = UIViewContentModeScaleAspectFill;
            weakSelf.imgView.clipsToBounds = YES;
            
            
            weakSelf.myScrollView.contentSize = weakSelf.imgView.frame.size;
            weakSelf.myScrollView.stickToBounds = YES;
            [weakSelf.myScrollView addViewForZooming:weakSelf.imgView];
            [weakSelf.myScrollView scaleToFit];
            [weakSelf.view addSubview:weakSelf.myScrollView];
            
    }
        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            NSLog(@"Something was wrong %@", error);
    }];
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.myScrollView.viewForZooming;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
