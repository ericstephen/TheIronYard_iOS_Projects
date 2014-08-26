//
//  IWAViewController.m
//  InstaWhat?
//
//  Created by Eric Williams on 8/21/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "IWAViewController.h"

#import "IWAFilterVC.h"

#import <AssetsLibrary/AssetsLibrary.h>

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface IWAViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation IWAViewController
{
    UIImagePickerController * imagePicker;
    
    NSMutableArray * photos;
    
    ALAssetsLibrary * library;
    
    UIEdgeInsets collectionInset;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    photos = [@[] mutableCopy];
    
    self.view.layer.borderColor = [UIColor whiteColor].CGColor;
    self.view.layer.borderWidth = 6;
    
    
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.view.frame = self.view.frame;
    imagePicker.view.frame = CGRectMake(0, 0, 320, 320);
    imagePicker.showsCameraControls = NO;
    imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    imagePicker.delegate = self;
    
    [self.view addSubview:imagePicker.view];
    [self addChildViewController:imagePicker];
    
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(90, 90);
    UICollectionView * photoCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 320, 320, SCREEN_HEIGHT - 320) collectionViewLayout:layout];
    
    photoCollection.dataSource = self;
    photoCollection.delegate = self;
    photoCollection.backgroundColor = [UIColor colorWithRed:0.843f green:0.863f blue:0.882f alpha:1.0f];
    photoCollection.layer.borderColor = [UIColor whiteColor].CGColor;
    photoCollection.layer.borderWidth = 6;
    [photoCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:photoCollection];
    
    library = [[ALAssetsLibrary alloc]init];
    [library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup * group, BOOL * stop) {
        [group enumerateAssetsUsingBlock:^(ALAsset * result, NSUInteger index, BOOL * stop) {
            
            NSLog(@"type %@", [result valueForProperty:ALAssetPropertyType]);
            
            if(result) [photos addObject:result];
            
            [photoCollection reloadData];
            
        }];
    } failureBlock:^(NSError * error) {
        
    }];
    
    UIButton * takePictureButton = [[UIButton alloc] initWithFrame:CGRectMake(120, 280, 80, 80)];
    takePictureButton.backgroundColor = [UIColor orangeColor];
    takePictureButton.layer.borderWidth = 6;
    takePictureButton.layer.borderColor = [UIColor whiteColor].CGColor;
    takePictureButton.layer.cornerRadius = 40;
    [takePictureButton addTarget:self action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:takePictureButton];
}

- (UIImage *)normalizedImage:(UIImage*)normalImage
{
    if (normalImage.imageOrientation == UIImageOrientationUp) return normalImage;
    
    UIGraphicsBeginImageContextWithOptions(normalImage.size, NO, normalImage.scale);
    [normalImage drawInRect:(CGRect){0, 0, normalImage.size}];
    UIImage * normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return normalizedImage;
}

- (void)takePicture
{
    [imagePicker takePicture];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * fixedImage = [self normalizedImage:info[UIImagePickerControllerOriginalImage]];

    [self showFilterWithImage:fixedImage];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return photos.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    ALAsset * photo = photos[indexPath.item];
    
    UIImageView * thumbnailView = [[UIImageView alloc]initWithFrame:cell.bounds];
    
    thumbnailView.image = [UIImage imageWithCGImage:photo.thumbnail];
    
    [cell.contentView addSubview:thumbnailView];
    
    return cell;
    
    // push viewcontroller
    
}

- (void)showFilterWithImage:(UIImage *)image
{
    IWAFilterVC * filterVC = [[IWAFilterVC alloc] init];
    
    filterVC.originalImage = image;
    
    [self.navigationController pushViewController:filterVC animated:YES];
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    UIImageView * bigView = [[UIImageView alloc] initWithFrame: imagePicker.view.frame];
    
    ALAsset * photo = photos[indexPath.item];
    
    ALAssetRepresentation * representation = photo.defaultRepresentation;
    
    //    bigView.image = [UIImage imageWithCGImage:representation.fullResolutionImage];
    //
    //    [self.view addSubview:bigView];
    
    // push view controller
    
    [self showFilterWithImage:[UIImage imageWithCGImage:representation.fullResolutionImage]];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(13, 13, 13, 13);
}



@end
