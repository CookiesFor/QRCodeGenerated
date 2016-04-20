//
//  ReCodeViewController.m
//  二维码
//
//  Created by iOS香肠 on 15/10/8.
//  Copyright (c) 2015年 二维火. All rights reserved.
//

#import "ReCodeViewController.h"

@interface ReCodeViewController ()

@property (nonatomic ,strong) NSString *code ;
@property (nonatomic ,strong) UIImageView *qrCodeImageView;
@property (nonatomic ,strong) UIImageView *qrCodeSizeImageView;
@property (nonatomic ,strong) UIButton *button;

@end

@implementation ReCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self CreateReQte];
}
- (void)CreateReQte
{
    
   self.code =@"1";//二维码信息
   self.qrCodeImageView =[[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
   [self.view addSubview:self.qrCodeImageView];
    _qrCodeImageView.image = [self generateBarCode :_code width:_qrCodeImageView.frame.size.width height:_qrCodeImageView.frame.size.height];
   if (_qrCodeImageView.frame.size.width != 0 && _qrCodeImageView.frame.size.height != 0) {
    NSLog(@"重新加载二维码");
    _qrCodeSizeImageView.image = [UIImage imageWithCIImage:[_qrCodeImageView.image CIImage] scale:1.0 orientation:UIImageOrientationDown];
}
}
//二维码
- (UIImage *)generateQRCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height {
    
    // 生成二维码图片
    CIImage *qrcodeImage;
    NSData *data = [_code dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    qrcodeImage = [filter outputImage];
    
    // 消除模糊
    CGFloat scaleX = width / qrcodeImage.extent.size.width; // extent 返回图片的frame
    CGFloat scaleY = height / qrcodeImage.extent.size.height;
    CIImage *transformedImage = [qrcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    
    return [UIImage imageWithCIImage:transformedImage];
}
//条形码
- (UIImage *)generateBarCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height {
    // 生成条形码图片
    CIImage *barcodeImage;
    NSData *data = [_code dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    
    [filter setValue:data forKey:@"inputMessage"];
    barcodeImage = [filter outputImage];
    // 消除模糊
    CGFloat scaleX = width / barcodeImage.extent.size.width; // extent 返回图片的frame
    CGFloat scaleY = height / barcodeImage.extent.size.height;
    CIImage *transformedImage = [barcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    return [UIImage imageWithCIImage:transformedImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
