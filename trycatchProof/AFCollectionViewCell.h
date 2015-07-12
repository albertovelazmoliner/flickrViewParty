//
//  AFCollectionViewCell.h
//  Chapter 2 Project 6
//
//  Created by Ash Furrow on 2012-12-17.
//  Copyright (c) 2012 Ash Furrow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *image;

-(void)setImageWithURL:(NSURL *)url;

@end
