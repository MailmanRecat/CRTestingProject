//
//  PHAssetsDomeController.m
//  CRTestingProject
//
//  Created by caine on 12/22/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#define k_IPHONE_5_PIXELWIDTH 640
#define k_IPHONE_5_PIXELHEIGHT 1136
#define k_IPHONE_6_PIXELWIDTH 750
#define k_IPHONE_6_PIXELHEIGHT 1374
#define k_IPHONE_6S_PIXELWIDTH 1242
#define k_IPHONE_6S_PIXELHEIGHT 2208

#define k_CGSIZE_IPHONE4_2X  CGSizeMake(320 * 2, 148 * 2);
#define k_CGSIZE_IPHONE5_2X  CGSizeMake(320 * 2, 148 * 2);
#define k_CGSIZE_IPHONE6_2X  CGSizeMake(375 * 2, 148 * 2);
#define k_CGSIZE_IPHONE6S_3X CGSizeMake(414 * 3, 148 * 3);

#define k_CGSIZE_IPHONE4_1X  CGSizeMake(320 * 1, 148 * 1);
#define k_CGSIZE_IPHONE5_1X  CGSizeMake(320 * 1, 148 * 1);
#define k_CGSIZE_IPHONE6_1X  CGSizeMake(375 * 1, 148 * 1);
#define k_CGSIZE_IPHONE6S_1X CGSizeMake(414 * 1, 148 * 1);

#import <Photos/Photos.h>

#import "PHAssetsDomeController.h"
#import "PHCustomTableViewCell.h"

@interface PHAssetsDomeController()<UITableViewDataSource, UITableViewDelegate>

@property( nonatomic, strong ) UIImageView *imv;

@property( nonatomic, strong ) PHFetchResult *PHResult;
@property( nonatomic, strong ) UITableView *table;
@property( nonatomic, assign ) NSUInteger photosCount;

@property( nonatomic, assign ) BOOL isDone;

@property( nonatomic, strong ) NSData *testData;

@end

@implementation PHAssetsDomeController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    self.imv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20 + 56 + 72)];
    self.imv.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.imv];
    
    PHFetchResult *res = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum
                                                                  subtype:PHAssetCollectionSubtypeSmartAlbumRecentlyAdded
                                                                  options:nil];
    
    PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    
    PHFetchOptions *optionsf = [[PHFetchOptions alloc] init];
    optionsf.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:optionsf];
    
//    NSLog(@"%ld", [res count]);
//    NSLog(@"%ld", [topLevelUserCollections count]);
//    NSLog(@"%ld", [assetsFetchResults count]);
    
    PHCachingImageManager *manager = [[PHCachingImageManager alloc] init];
    if( [assetsFetchResults count] > 0 ){
        PHAsset *seset = assetsFetchResults[0];
        [manager requestImageForAsset:seset
                           targetSize:CGSizeMake(375 / 2, 100)
                          contentMode:PHImageContentModeAspectFill
                              options:nil
                        resultHandler:^(UIImage *image, NSDictionary *info){
//                            self.imv.image = image;
                        }];

    }
    
    NSString *npath = [NSString stringWithFormat:@"%@/Documents/DICK", NSHomeDirectory()];
    
    BOOL isDir;
    if( ![[NSFileManager defaultManager] fileExistsAtPath:npath isDirectory:&isDir] && !isDir ){
        [[NSFileManager defaultManager] createDirectoryAtPath:npath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    BOOL IS = [[NSFileManager defaultManager] fileExistsAtPath:npath isDirectory:&isDir];
    
//    NSLog(@"-last- %d %d", IS, isDir);
    
    NSString *path = [NSString stringWithFormat:@"%@/Documents/FUCK.PNG", NSHomeDirectory()];
    BOOL YE = [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/Documents/FUCK.PNG", NSHomeDirectory()]];
    BOOL DF = [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/Documents", NSHomeDirectory()]];
    
//    NSBundle *B = [NSBundle bundleWithPath:[NSString stringWithFormat:@"%@/Documents/FUCK.PNG", NSHomeDirectory()]];
//    NSURL *iu  =[b ]
    
    if( YE )
        self.imv.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/FUCK.PNG", NSHomeDirectory()]];
    
    NSError *error;
//    [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
    
    BOOL AYE = [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/Documents/FUCK.PNG", NSHomeDirectory()]];
//    NSLog(@"%d", AYE);
    
    PHCachingImageManager *cachingImageManager = [[PHCachingImageManager alloc] init];
    
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.predicate = [NSPredicate predicateWithFormat:@"favorite == YES"];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"" ascending:YES]];
    
    PHFetchResult *results = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage
                                                       options:nil];
    
    NSMutableArray<PHAsset *> *assets = [[NSMutableArray alloc] init];
    [results enumerateObjectsUsingBlock:^(id  _Nonnull object, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([object isKindOfClass:[PHAsset class]]) {
            [assets addObject:object];
        }
    }];
    
    [cachingImageManager startCachingImagesForAssets:assets
                                          targetSize:PHImageManagerMaximumSize
                                         contentMode:PHImageContentModeAspectFit
                                             options:nil];
    
    self.PHResult = assetsFetchResults;
//    self.PHResult = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:nil];
    
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 20 + 56 + 72, 375, self.view.frame.size.height - 148 - 52) style:UITableViewStylePlain];
    self.table.dataSource = self;
    self.table.delegate = self;
    [self.view addSubview:self.table];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 20 + 56 + 72;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.PHResult count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ({
        PHCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FUCK"];
        if( cell == nil ){
            cell = [[PHCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FUCK"];
            cell.clipsToBounds = YES;
        }
        
        PHAsset *asset = [self.PHResult objectAtIndex:indexPath.row];
        PHImageManager *manager = [PHImageManager defaultManager];
        
//        NSLog(@"%lu", (unsigned long)asset.pixelHeight);
//        NSLog(@"%lu", (unsigned long)asset.pixelWidth);
        
        [manager requestImageForAsset:asset
                           targetSize:CGSizeMake(self.view.frame.size.width, 148)
                          contentMode:PHImageContentModeAspectFill
                              options:nil
                        resultHandler:^(UIImage *image, NSDictionary *info){
                            cell.crimageview.image = image;
//                            if( indexPath.row == 0 ){
//                                NSString *path = [NSString stringWithFormat:@"%@/Documents/FUCK.PNG", NSHomeDirectory()];
//                                [UIImagePNGRepresentation(image) writeToFile:path atomically:YES];
//                            }
                            
                            
//                            NSLog(@"%lf %lf", size.width, size.height);
                            
                            if( indexPath.row == 0 ){
                                CGSize imageSize = image.size;
//                                NSLog(@"%@ w%f h%f", image, imageSize.width, imageSize.height);
//                                NSData *png = UIImagePNGRepresentation(image);
//                                NSData *imd = UIImageJPEGRepresentation(image, 0.5);
//                                CGFloat len = imd.length / 1024 / 1024.0;
//                                NSLog(@"png %.2f MB", png.length / 1024 / 1024.0);
//                                NSLog(@"make %.2f MB", len);
                            }
                        }];
        
        
        if( indexPath.row == 0 ){
        }
        
        cell;
    });
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PHAsset *asset = [self.PHResult objectAtIndex:indexPath.row];
    PHImageManager *manager = [PHImageManager defaultManager];
    
    void (^logImageLen)(NSString *, CGFloat) = ^(NSString *prefix, CGFloat len){
        NSLog(@"%@ %.3f MB", prefix, len / 1024 / 1024.0);
    };
    
    PHImageRequestOptions *OP = [[PHImageRequestOptions alloc] init];
    OP.resizeMode = PHImageRequestOptionsResizeModeFast;
    
    [manager requestImageDataForAsset:asset
                              options:OP
                        resultHandler:
     ^(NSData * _Nullable imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info){
         
         CGFloat pro = 1.0 / (imageData.length / 1024 / 1024.0);
//         NSLog(@"pro %f", pro);
         
         NSData *jpg = UIImageJPEGRepresentation([UIImage imageWithData:imageData], pro / 10);
//         logImageLen(@"ori:", imageData.length);
//         logImageLen(@"jpg:", jpg.length);
         
         self.imv.image = [UIImage imageWithData:jpg];
         
         
         //                 NSLog(@"%@", info);
     }];
    
    PHImageRequestOptions *PHO = [[PHImageRequestOptions alloc] init];
    
//    PHO.resizeMode = PHImageRequestOptionsResizeModeExact;
    PHO.resizeMode = PHImageRequestOptionsResizeModeExact;
    PHO.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
//    PHO.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
    
    NSString *dinfo = [UIDevice currentDevice].localizedModel;
    
    NSUInteger model = 7;
    CGSize targetSize;
    if( model == 4 )
        targetSize = k_CGSIZE_IPHONE4_2X
    else if( model == 5 )
        targetSize = k_CGSIZE_IPHONE5_2X
    else if( model == 6 )
        targetSize = k_CGSIZE_IPHONE6_2X
    else if( model == 7 )
        targetSize = k_CGSIZE_IPHONE6S_3X
    
    __block NSUInteger counter = 0;
    
    __block NSData *fuck, *dick;
    
    [manager requestImageForAsset:asset
                       targetSize:targetSize
                      contentMode:PHImageContentModeAspectFill
                          options:PHO
                    resultHandler:^(UIImage *image, NSDictionary *info){
                        ++counter;
                        NSLog(@"%ld %@", counter, image);
                        
//                        fuck = UIImageJPEGRepresentation(image, 0.6);
                        
                        NSData *odat = UIImageJPEGRepresentation(image, 1);
                        NSData *data = UIImageJPEGRepresentation(image, 0.2);
                        logImageLen(@"OEX:", odat.length);
                        logImageLen(@"EXA:", data.length);
                        
                        [NSThread sleepForTimeInterval:1];
                        
                        BOOL save1 = [odat writeToFile:@"/users/caine/downloads/FUCKNOTEO.jpg" atomically:YES];
                        BOOL save = [data writeToFile:@"/users/caine/downloads/FUCKNOTE.jpg" atomically:YES];
                        NSLog(@"saved: %d %d", save, save1);
                        
                    }];
    [manager requestImageDataForAsset:asset
                              options:nil
                        resultHandler:
     ^(NSData *__nullable imageData, NSString *__nullable dataUTI, UIImageOrientation orientation, NSDictionary *__nullable info){
         dick = imageData;
     }];

    
    NSLog(@"Over");
}

- (void)saveFile{
    
}

- (void)callback{
    
}

- (void)fuck{
}

@end
