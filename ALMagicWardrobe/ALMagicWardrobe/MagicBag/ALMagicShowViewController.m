//
//  ALMagicShowViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-21.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALMagicShowViewController.h"
#import "CustomImagePickerController.h"
#import "ImageFilterProcessViewController.h"
#import "ALMagicShowCell.h"
#import "ALMagicShowModel.h"
#import "ALMagicShowBigShowViewController.h"

@interface ALMagicShowViewController ()
<CustomImagePickerControllerDelegate,
ImageFitlerProcessDelegate,
UITableViewDataSource,
UITableViewDelegate,
UIAlertViewDelegate>
@end

@implementation ALMagicShowViewController{
    NSMutableArray *_listMagicShow;
    UIImage *_showImg;
    ALTableView *theTableView;
    
    NSInteger _delIndex;
    NSInteger _index;
    BOOL _isShow;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"魔镜秀"];
    
    __block ALMagicShowViewController *theCtrl=self;
    _delIndex = -1;
    [self _initData];
    
    [self _initView];
    
    [self setViewWithType:rightBtn1_type
                  andView:^(id view) {
                      ALButton *theBtn=view;
                      [theBtn setImage:[ALImage imageNamed:@"icon_camera"] forState:UIControlStateNormal];
    } andBackEvent:^(id sender) {
        UIActionSheet *sheet = [[UIActionSheet alloc]
                                initWithTitle:@"选择图片"
                                delegate:self
                                cancelButtonTitle:@"取消"
                                destructiveButtonTitle:nil
                                otherButtonTitles:@"拍照",@"从相册选择", nil];
        [sheet showInView:[UIApplication sharedApplication].keyWindow];

       
    }];
    
    _isShow = false;
    [self _selectUserMirrorShowAndBlock:^{
        [theTableView reloadData];
    }];
}
-(void)_initData{
    _showImg=nil;

    _listMagicShow=[[NSMutableArray alloc] initWithCapacity:2];
}
-(void)_initView{
    
    ALComView *leftBgView=[[ALComView alloc]
                           initWithFrame:CGRectMake(0,
                                                    0,
                                                    leftWidth,
                                                    self.contentView.height)];
    [leftBgView setBackgroundColor:colorByStr(@"#F2F2F2")];
    [self.contentView addSubview:leftBgView];
    
    ALComView *rightBgView=[[ALComView alloc]
                            initWithFrame:CGRectMake(leftBgView.right,
                                                     0,
                                                     kScreenWidth-leftBgView.width,
                                                     self.contentView.height)];
    [rightBgView setBackgroundColor:colorByStr(@"#E5E5E5")];
    [rightBgView setUserInteractionEnabled:YES];
    [self.contentView addSubview:rightBgView];
    
    theTableView=[[ALTableView alloc]
                               initWithFrame:CGRectMake(0,
                                                        54/2,
                                                        kScreenWidth,
                                                        self.contentView.height-54/2*2)
                               ];
    [theTableView setDataSource:self];
    [theTableView setDelegate:self];
    [theTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [theTableView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:theTableView];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        CustomImagePickerController *picker = [[CustomImagePickerController alloc] init];
//        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
//        }else{
//            [picker setIsSingle:YES];
//            [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
//        }
        [picker setCustomDelegate:self];
        [self presentViewController:picker animated:YES completion:nil];
    }
    if (buttonIndex == 1) {
        CustomImagePickerController *picker = [[CustomImagePickerController alloc] init];
            [picker setIsSingle:YES];
            [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [picker setCustomDelegate:self];
        [self presentViewController:picker animated:YES completion:nil];
    }
}
- (void)cameraPhoto:(UIImage *)image  //选择完图片
{
    ImageFilterProcessViewController *fitler = [[ImageFilterProcessViewController alloc] init];
    [fitler setDelegate:self];
    fitler.currentImage = image;
    [self presentViewController:fitler animated:YES completion:nil];
}
- (void)imageFitlerProcessDone:(UIImage *)image //图片处理完
{
    _showImg=image;
    [self _saveMirrorShowAndBlock:^{
        [self _selectUserMirrorShowAndBlock:^{
            [theTableView reloadData];
        }];
    }];
}
- (void)cancelCamera{

}

#pragma mark UITableView datasource and delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listMagicShow.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *magicShowIdentify=@"magicShowIdentify";
    ALMagicShowCell *theCell=[tableView dequeueReusableCellWithIdentifier:magicShowIdentify];
    if (theCell==nil) {
        theCell=[[ALMagicShowCell alloc]
                 initWithStyle:UITableViewCellStyleDefault
                 reuseIdentifier:magicShowIdentify];
        [theCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    [theCell setModel:_listMagicShow[indexPath.row]];
    theCell.index = indexPath.row;
    __block ALMagicShowCell *blockCell = theCell;
    [theCell setTheBlock:^(MagicShowEnum theType,NSInteger index){
        if (theType==MSTapClick_type) {
            ALMagicShowModel *theModel=_listMagicShow[indexPath.row];
            ALMagicShowBigShowViewController *theCtrl=[[ALMagicShowBigShowViewController alloc] init];
            [theCtrl setTheModel:theModel];
            [theCtrl setCurIndex:index];
            [self.navigationController pushViewController:theCtrl animated:YES];
        }else if (theType==MSLongTapClick_type){
            
            if (_isShow == false)
            {
                _isShow = YES;
                _delIndex = index;
                _index = blockCell.index;
                UIAlertView *alertView=[[UIAlertView alloc]
                                        initWithTitle:nil
                                        message:@"是否删除图片"
                                        delegate:self
                                        cancelButtonTitle:@"取消"
                                        otherButtonTitles:@"确定", nil];
                [alertView show];
            }

        }
    }];
    
    return theCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ALMagicShowModel *theModel=_listMagicShow[indexPath.row];
    NSArray *arr= [theModel.imageurls componentsSeparatedByString:@";"];
    NSMutableArray *arrTmp = [[NSMutableArray alloc] initWithCapacity:0];
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *tmp = obj;
        if (tmp.length > 0) {
             [arrTmp addObject:obj];
        }
       
    }];
    
    NSInteger count = arrTmp.count;
//    CGFloat height = 0.f;
    NSInteger row = count/4;
    if (count % 4 > 0)
    {
        row ++;
    }
    return 50 * row + 10.f + 4 * (row - 1);
//    return (arr.count/3+arr.count%3>0?1:0)*53+25+10 + height;
}

/**
 *  删除图片
 *
 *  @param alertView   alertView
 *  @param buttonIndex 按钮点击
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    _isShow = false;
    if (buttonIndex==1)
    {
        if (_delIndex < 0)
        {
            return;
        }
        ALMagicShowModel *theModel=_listMagicShow[_index];
        NSArray *arr = [theModel.imageurls componentsSeparatedByString:@";"];
        NSInteger count = arr.count;
        if (count > 0)
        {
            if (_delIndex >= count)
            {
                return;
            }
            NSDictionary *sendDic=@{
                                    @"imageurl":arr[_delIndex]
                                    };
            [DataRequest requestApiName:@"magicBag_delMirrorShow"
                              andParams:sendDic
                              andMethod:Post_type
                           successBlcok:^(id sucContent) {
//                               id object = sucContent;
                               //                           _isFirstBuyBool=[sucContent[@"body"][@"result"] boolValue];
                               //                           if (theBlock) {
                               //                               theBlock();
                               //                           }
                               [self _selectUserMirrorShowAndBlock:^{
                                   [theTableView reloadData];
                               }];
                               _delIndex = -1;
                           } failedBlock:^(id failContent) {
                               showFail(failContent);
                           } reloginBlock:^(id reloginContent) {
                           }];
        }
    
    }
    else
    {
        _delIndex = -1;
    }
}

#pragma mark loadData
#pragma mark -
#pragma mark 查询个人魔镜秀记录
-(void)_selectUserMirrorShowAndBlock:(void(^)())theBlock
{
    NSDictionary *sendDic=@{
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId])
                            };
    [DataRequest requestApiName:@"magicBag_selectUserMirrorShow"
                      andParams:sendDic
                      andMethod:Get_type
                   successBlcok:^(id sucContent) {
                       [_listMagicShow removeAllObjects];
                       if ([sucContent[@"body"][@"result"] isKindOfClass:[NSArray class]]) {
                           NSArray *tempArr=sucContent[@"body"][@"result"];
                           [tempArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                               ALMagicShowModel *theModel=[ALMagicShowModel questionWithDict:obj];
                               [_listMagicShow addObject:theModel];
                           }];
                       }
                       
                       if (theBlock) {
                           theBlock();
                       }
    } failedBlock:^(id failContent) {
        showFail(failContent);
    } reloginBlock:^(id reloginContent) {
    }];
}
#pragma mark 保存个人秀图片
-(void)_saveMirrorShowAndBlock:(void(^)())theBlock{
    //添加图片，并对其进行压缩（0.0为最大压缩率，1.0为最小压缩率）
    NSData *imageData = UIImageJPEGRepresentation(_showImg, 1.0);
    
    if (![[ALLoginUserManager sharedInstance] loginCheck]) {
        showWarn(@"请先登录");
        return;
    }
    
    NSDictionary *sendDic=@{
                            @"magicPackageId":filterStr(self.magicBagDic[@"id"]),
                            @"expressId":filterStr(self.magicBagDic[@"expressId"]),
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId])
                            };
    [DataRequest requestApiName:@"magicBag_saveMirrorShow"
                      andParams:sendDic
                         andImg:imageData
                   successBlcok:^(id sucContent) {
                       if (theBlock) {
                           theBlock();
                       }
    } failedBlock:^(id failContent) {
        showFail(failContent);
    } reloginBlock:^(id reloginContent) {
    }];
}
@end
