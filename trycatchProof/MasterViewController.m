//
//  MasterViewController.m
//  trycatchProof
//
//  Created by Alberto Velaz Moliner on 26/06/15.
//  Copyright (c) 2015 Alberto Velaz Moliner. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "AFCollectionViewCell.h"
#import "AFNetworking.h"
#import "Constants.h"


@interface MasterViewController ()

@property NSMutableArray *flickrPhotos;
@end

static NSString *CellIdentifier = @"Cell Identifier";

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    //configure our collection view layout
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    flowLayout.minimumInteritemSpacing = 2.0f;
    flowLayout.minimumLineSpacing = 2.0f;
    flowLayout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
    flowLayout.itemSize = CGSizeMake(90, 90);
    
    //configure our collection view
    [self.collectionView registerClass:[AFCollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    self.collectionView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.collectionView.allowsMultipleSelection = YES;
    self.collectionView.canCancelContentTouches = NO;
    self.collectionView.delaysContentTouches = NO;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"https://api.flickr.com/services/rest"
      parameters:@{@"method":@"flickr.photos.search",
                   @"api_key":flickrApiKey,
                   @"tags":@"party",
                   @"format":@"json",
                   @"nojsoncallback":@"1",
                   @"per_page":@"100"}
         success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
         CGFloat total = [[responseObject objectForKey:@"photos.total"] floatValue];
         self.flickrPhotos = [[responseObject objectForKey:@"photos"] objectForKey:@"photo"];
         
         NSLog(@"total : %f", total);
         [self.collectionView reloadData];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error.localizedDescription);
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource Methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.flickrPhotos.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AFCollectionViewCell *cell = (AFCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSURL *url = [self flickrUrlConstructuctor:self.flickrPhotos[indexPath.item] withSuffix:@"_s"];
    [cell setImageWithURL:url];
    
    return cell;
}

- (NSURL *)flickrUrlConstructuctor:(NSDictionary*)dic withSuffix:(NSString*)suffix {
    NSString *stringUrl = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@%@.jpg",
                           [dic valueForKey:@"farm"],
                           [dic valueForKey:@"server"],
                           [dic valueForKey:@"id"],
                           [dic valueForKey:@"secret"],
                           suffix];
    NSURL *url = [NSURL URLWithString:stringUrl];
    return url;
}

-(void)collectionView:(nonnull UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DetailViewController *vc = [[DetailViewController alloc] init];
    vc.title = [self.flickrPhotos[indexPath.item] valueForKey:@"title"];
    [vc setUrl:[self flickrUrlConstructuctor:self.flickrPhotos[indexPath.item] withSuffix:@"_b"]];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
