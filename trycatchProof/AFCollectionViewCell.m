//
//  AFCollectionViewCell.m
//  Chapter 2 Project 6
//
//  Created by Ash Furrow on 2012-12-17.
//  Copyright (c) 2012 Ash Furrow. All rights reserved.
//

#import "AFCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation AFCollectionViewCell
{
    UIImageView *imageView;
}

- (id)initWithFrame:(CGRect)frame
{
    if (!(self = [super initWithFrame:frame])) return nil;
    
    self.backgroundColor = [UIColor whiteColor];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, 2, 2)];
    [self.contentView addSubview:imageView];

    return self;
}

#pragma mark - Overriden UICollectionViewCell methods

-(void)prepareForReuse
{
    [super prepareForReuse];
    
    self.image = nil; //also resets imageView’s image
}

#pragma mark - Overridden Properties

-(void)setImageWithURL:(NSURL *)url
{
    [imageView setImageWithURL:url];
}


@end
