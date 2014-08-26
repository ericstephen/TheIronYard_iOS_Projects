//
//  IWAFilterVC.m
//  InstaWhat?
//
//  Created by Eric Williams on 8/25/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "IWAFilterVC.h"

#import "IWAFilteredImageVC.h"



@interface IWAFilterVC () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation IWAFilterVC
{
    UIImageView * imageView;
    
    UICollectionView * filterCollection;
    
    NSArray * filters;
    
    NSMutableDictionary *filteredImages;
    
    UIEdgeInsets collectionInset;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.view.layer.borderColor = [UIColor whiteColor].CGColor;
        self.view.layer.borderWidth = 6;
        
        filters = @[
                    @"CIColorCrossPolynomial",
                    @"CIColorCube",
//                    @"CIColorCubeWithColorSpace",
//                    @"CIColorInvert",
//                    @"CIColorMap",
                    @"CIColorMonochrome",
                    @"CIColorPosterize",
                    @"CIFalseColor",
                    @"CIMaskToAlpha",
//                    @"CIMaximumComponent",
//                    @"CIMinimumComponent",
//                    @"CIPhotoEffectChrome",
//                    @"CIPhotoEffectFade",
//                    @"CIPhotoEffectInstant",
//                    @"CIPhotoEffectMono",
//                    @"CIPhotoEffectNoir",
//                    @"CIPhotoEffectProcess",
                    @"CIPhotoEffectTonal",
                    @"CIPhotoEffectTransfer",
                    @"CISepiaTone",
//                    @"CIVignette",
//                    @"CIVignetteEffect"
                    ];
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [self.view addSubview:imageView];
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(90, 90);
        
        filterCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 320, 320, [UIScreen mainScreen].bounds.size.height - 320) collectionViewLayout:layout];
        filterCollection.dataSource = self;
        filterCollection.delegate = self;
        filterCollection.layer.borderColor = [UIColor whiteColor].CGColor;
        filterCollection.layer.borderWidth = 6;
        filterCollection.backgroundColor = [UIColor colorWithRed:0.843f green:0.863f blue:0.882f alpha:1.0f];
        
        
        [filterCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        [self.view addSubview:filterCollection];
        
        filteredImages = [@{} mutableCopy];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setOriginalImage:(UIImage *)originalImage
{
    _originalImage = originalImage;
    
    imageView.image = originalImage;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return filters.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSString * filterName = filters[indexPath.item];
    
    UIImageView * filterView = [[UIImageView alloc] initWithFrame:cell.bounds];
    [cell addSubview:filterView];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        UIImage * filterImage = [self filterImageWithFilterName:filterName];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            filterView.image = filterImage;
            
            [filteredImages setObject:filterImage forKey:[NSString stringWithFormat:@"%d",(int)indexPath.item]];
            
        });
        
    });
    
    [cell addSubview:filterView];

    return cell;
}


- (void)showFilterView:(UIImage *)image
{
    IWAFilteredImageVC * filteredVC = [[IWAFilteredImageVC alloc] init];
    
    filteredVC.filteredImage = image;
    
    [self.navigationController pushViewController:filteredVC animated:YES];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self showFilterView:filteredImages[[NSString stringWithFormat:@"%d", (int)indexPath.item]]];
}

- (UIImage *)filterImageWithFilterName:(NSString *)filterName
{
    
    // turn uiimage into ciimage
    CIImage * ciImage = [CIImage imageWithCGImage:self.originalImage.CGImage];
    
    // create cifilter with filterName
    CIFilter * filter = [CIFilter filterWithName:filterName];
    
    // add ciimage to the filter
    [filter setValue:ciImage forKeyPath:kCIInputImageKey];
    
    // get filtered image from filter
    CIImage * ciResult = [filter outputImage];
    
    // setup context to turn ciimage into cgimage
    CIContext * ciContext = [CIContext contextWithOptions:nil];
    
    // init uiimage with cgimage
    return [UIImage imageWithCGImage:[ciContext createCGImage:ciResult fromRect:[ciResult extent]]];
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(13, 13, 13, 13);

}


@end
