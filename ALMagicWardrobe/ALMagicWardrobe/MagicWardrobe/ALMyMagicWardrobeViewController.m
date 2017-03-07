//
//  ALMyMagicWardrobeViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-22.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALMyMagicWardrobeViewController.h"
#import "ALMyMagicWardrobeCollectionViewCell.h"
#import "ALClothesDetailViewController.h"
#import "ALUtilities.h"
#import "ALMyBasketViewController.h"
#import "ALMagicWardrobeClothsModel.h"
#import "ALMyMWTableViewCell.h"

#define tipStr @"这个衣橱是空的,这样是生成不了魔法包的呢";

@interface ALMyMagicWardrobeViewController ()
<UITableViewDataSource,UITableViewDelegate>
@end

@implementation ALMyMagicWardrobeViewController{
    NSMutableArray *_listClothesArr;
    NSInteger _pageNo;
    ALLabel *_showLabel;
    NSString *_type;
    ALImageView *headImgView;
    ALTableView *_myMWTableView;
    
    UIImageView *leftGressImgView;
    UIImageView *rightTopGressImgView;
    UIImageView *rightBottomGressImgView;
    
    UILabel *_leftTopCountLbl;
    UIImageView *_leftTopImg;
    UILabel *_rightTopCountLbl;
    UIImageView *_rightTopImg;
    
    UILabel *_rightBtmCountLbl;
    UIImageView *_rightBtmImg;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _pageNo = 1;
    _type = @"全身";
    [self setTitle:@"我的衣橱"];
    
    [self _initData];
    
    __block ALMyMagicWardrobeViewController *theBlockSelf  = self;
    
    [self _initView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endRefresh) name:@"kNetConnectionException" object:nil];
    [self setViewWithType:rightBtn1_type
                  andView:^(id view) {
                      ALButton *theBtn=view;
//                      DLog(@"btnLeft is %f,btnY is %f, btnwidth is %f,btnheight is %f",theBtn.left+theBtn.width/4, theBtn.top+theBtn.height/4,theBtn.width/2,theBtn.height/2);
                      [theBtn setFrame:CGRectMake(285, 28, 22, 25)];
                      [theBtn setImage:[[ALImage imageNamed:@"icon_delete"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
                  } andBackEvent:^(id sender) {
                      ALMyBasketViewController *theCtrl=[[ALMyBasketViewController alloc] init];
                      [theBlockSelf.navigationController pushViewController:theCtrl animated:YES];
                  }];
    
//    [self _loadMyWardrobeDataAndBlock:^{
//        [_myMWTableView reloadData];
//    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _pageNo=1;
    [self _loadMyWardrobeDataAndBlock:^{

        [_myMWTableView reloadData];
    }];
}
-(void)_initData{
    _listClothesArr=[[NSMutableArray alloc] initWithCapacity:2];
}
-(void)_initView{
    
    UIColor *color = colorByStr(@"#75491F");
    headImgView=[[ALImageView alloc]
                 initWithFrame:CGRectMake(5, 5, 605/2, 455/2+5+5)];
    [headImgView setImage:[ALImage imageNamed:@"wardrobe_bg"]];
    
    __block ALMyMagicWardrobeViewController *blockSelf  = self;
    
    UIImageView *clothesLeftImgView=[[UIImageView alloc]
                                     initWithFrame:CGRectMake(38, 40, 102, 150)];
    [clothesLeftImgView setImage:[ALImage imageNamed:@"wardrobe_clothes_left"]];
    clothesLeftImgView.userInteractionEnabled = YES;
    [headImgView addSubview:clothesLeftImgView];
    
    leftGressImgView=[[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 281/2+10+5,427/2+20)];
    [leftGressImgView setImage:[ALImage imageNamed:@"wardrobe_glass_left"]];
    [headImgView addSubview:leftGressImgView];
    
    ALButton *leftBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:leftGressImgView.frame];
    [leftBtn setTheBtnClickBlock:^(id sender){
        [leftGressImgView setHidden:YES];
        [rightTopGressImgView setHidden:NO];
        [rightBottomGressImgView setHidden:NO];
        _type = @"全身";
        if (_listClothesArr.count>0) {
            [_listClothesArr removeAllObjects];
        }
        [_myMWTableView reloadData];
        
        [blockSelf _loadMyWardrobeDataAndBlock:^{
            
            [_myMWTableView reloadData];
        }];

    }];
    [clothesLeftImgView addSubview:leftBtn];
    
    _leftTopImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yiChuCountBack.png"]];
    _leftTopImg.frame = CGRectMake(leftGressImgView.left + 90, leftGressImgView.height - 63, 20, 15);
    [clothesLeftImgView addSubview:_leftTopImg];
    
    _leftTopCountLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftGressImgView.left + 90, leftGressImgView.height - 63, 20, 15)];
    _leftTopCountLbl.textAlignment = NSTextAlignmentRight;
    _leftTopCountLbl.textColor = [UIColor whiteColor];
    _leftTopCountLbl.font = [UIFont boldSystemFontOfSize:12];
        _leftTopCountLbl.textAlignment = NSTextAlignmentCenter;
    _leftTopCountLbl.text = @"0";
    [clothesLeftImgView addSubview:_leftTopCountLbl];
    
    
    
    UIImageView *clothesRightTopImgView=[[UIImageView alloc]
                                         initWithFrame:CGRectMake(clothesLeftImgView.right+60,
                                                                  20,
                                                                  72,
                                                                  89)];
    [clothesRightTopImgView setImage:[ALImage imageNamed:@"wardrobe_clothes_right_top"]];
    [headImgView addSubview:clothesRightTopImgView];
    clothesRightTopImgView.userInteractionEnabled = YES;

    rightTopGressImgView=[[UIImageView alloc]
                          initWithFrame:CGRectMake(326/2,18/2-10, 278/2+10+5,206/2+10+5)];
    [rightTopGressImgView setImage:[ALImage imageNamed:@"wardrobe_glass_right_top"]];
    [headImgView addSubview:rightTopGressImgView];
    
    _rightTopImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yiChuCountBack.png"]];
    _rightTopImg.frame = CGRectMake(rightTopGressImgView.left + 120, rightTopGressImgView.bottom - 25, 20, 15);
    [headImgView addSubview:_rightTopImg];
    
    _rightTopCountLbl = [[UILabel alloc] initWithFrame:CGRectMake(rightTopGressImgView.left + 120, rightTopGressImgView.bottom - 25, 20, 15)];
    _rightTopCountLbl.textAlignment = NSTextAlignmentRight;
    _rightTopCountLbl.textColor = [UIColor whiteColor];
    _rightTopCountLbl.font = [UIFont boldSystemFontOfSize:12];
    _rightTopCountLbl.textAlignment = NSTextAlignmentCenter;
    [headImgView addSubview:_rightTopCountLbl];
    _rightTopCountLbl.text = @"0";
    
    
    ALButton *rightTopBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [rightTopBtn setFrame:rightTopGressImgView.frame];
    [rightTopBtn setTheBtnClickBlock:^(id sender){
        [leftGressImgView setHidden:NO];
        [rightTopGressImgView setHidden:YES];
        [rightBottomGressImgView setHidden:NO];
        
        _type = @"上半身";
        if (_listClothesArr.count>0) {
            [_listClothesArr removeAllObjects];
        }
        [_myMWTableView reloadData];
        
        [blockSelf _loadMyWardrobeDataAndBlock:^{
            
            [_myMWTableView reloadData];
        }];
    }];
    [headImgView addSubview:rightTopBtn];
    
    UIImageView *clothesRightBottomImgView=[[UIImageView alloc]
                                            initWithFrame:CGRectMake(
                                                                     clothesRightTopImgView.left - 10, clothesRightTopImgView.bottom+30,
                                                                     87,
                                                                     77)];
    [clothesRightBottomImgView setImage:[ALImage imageNamed:@"wardrobe_clothes_right_bottom"]];
    [headImgView addSubview:clothesRightBottomImgView];
    
    rightBottomGressImgView=[[UIImageView alloc]
                             initWithFrame:CGRectMake(326/2,rightTopGressImgView.bottom+10-5, 278/2+10+5,206/2+10)];
    [rightBottomGressImgView setImage:[ALImage imageNamed:@"wardrobe_glass_right_bottom"]];
    [headImgView addSubview:rightBottomGressImgView];
    
    clothesRightBottomImgView.userInteractionEnabled = YES;
    
    _rightBtmImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yiChuCountBack.png"]];
    _rightBtmImg.frame = CGRectMake(rightBottomGressImgView.left + 120, rightBottomGressImgView.bottom - 25, 20, 15);
    [headImgView addSubview:_rightBtmImg];

    
    _rightBtmCountLbl = [[UILabel alloc] initWithFrame:CGRectMake(rightBottomGressImgView.left + 120, rightBottomGressImgView.bottom - 25, 20, 15)];
    _rightBtmCountLbl.textAlignment = NSTextAlignmentRight;
    _rightBtmCountLbl.textColor = [UIColor whiteColor];
    _rightBtmCountLbl.font = [UIFont boldSystemFontOfSize:12];
    _rightBtmCountLbl.textAlignment = NSTextAlignmentCenter;
    [headImgView addSubview:_rightBtmCountLbl];
    _rightBtmCountLbl.text = @"0";
    
    
    ALButton *rightBottomBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [rightBottomBtn setFrame:rightBottomGressImgView.frame];
    [rightBottomBtn setTheBtnClickBlock:^(id sender){
        [leftGressImgView setHidden:NO];
        [rightTopGressImgView setHidden:NO];
        [rightBottomGressImgView setHidden:YES];
        _type = @"下半身";
        if (_listClothesArr.count>0) {
            [_listClothesArr removeAllObjects];
        }
        [_myMWTableView reloadData];
        
        [blockSelf _loadMyWardrobeDataAndBlock:^{
            
            [_myMWTableView reloadData];
        }];
    }];
    [headImgView addSubview:rightBottomBtn];
    
    //默认
    [leftGressImgView setHidden:YES];
    [rightTopGressImgView setHidden:NO];
    [rightBottomGressImgView setHidden:NO];

    headImgView.userInteractionEnabled = YES;
    
    _myMWTableView=[[ALTableView alloc] initWithFrame:CGRectMake(0,
                                                                0,
                                                                kScreenWidth,
                                                                self.view.size.height - 24) style:UITableViewStyleGrouped];
    [_myMWTableView setDataSource:self];
    [_myMWTableView setDelegate:self];
    [_myMWTableView setBackgroundColor:[UIColor clearColor]];
    [_myMWTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_myMWTableView addHeaderWithCallback:^{
        [blockSelf loadView:0];
    }];
    [_myMWTableView addFooterWithCallback:^{
        [blockSelf loadView:1];
    }];
    [_myMWTableView setTableHeaderView:headImgView];
    [self.contentView addSubview:_myMWTableView];
    self.contentView.scrollEnabled = NO;
    
    _showLabel  = [[ALLabel alloc]
                   initWithFrame:CGRectMake(15, 270, kScreenWidth-30, 50)];
    _showLabel.backgroundColor = [UIColor clearColor];
    _showLabel.font = [UIFont systemFontOfSize:14.f];
    _showLabel.textAlignment = NSTextAlignmentCenter;
    _showLabel.text = tipStr;
    _showLabel.numberOfLines = 2;
    _showLabel.textColor = color;
    _showLabel.layer.borderColor =color.CGColor;
    _showLabel.layer.borderWidth = 1;
    _showLabel.layer.masksToBounds = YES;
    _showLabel.layer.cornerRadius = 2;
    [_myMWTableView addSubview:_showLabel];
    _showLabel.hidden = YES;
    
    self.contentView.backgroundColor = AL_RGB(240, 236, 233);

}
-(void)loadView:(int)pageNo{
    if (pageNo==0) {
        _pageNo=1;
    }else{
        _pageNo+=1;
    }
    [self _loadMyWardrobeDataAndBlock:^{
        if (pageNo==0) {
            [_myMWTableView headerEndRefreshing];
        }else{
            [_myMWTableView footerEndRefreshing];
        }
        
        [_myMWTableView reloadData];
    }];
}
#pragma mark datasource and Delegate
#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_listClothesArr.count>0)
    {
        NSInteger count = _listClothesArr.count;
        NSInteger mod = _listClothesArr.count/2;
        if (count % 2 > 0)
        {
            mod ++;
        }
        
        return mod;
    }
    else
    {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *clothesIdentify=@"clothesMoreIdentify";
    ALMyMWTableViewCell *theCell=[tableView dequeueReusableCellWithIdentifier:clothesIdentify];
    if (theCell==nil) {
        theCell=[[ALMyMWTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:clothesIdentify];
        [theCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    NSInteger index = indexPath.row;
    NSInteger count = _listClothesArr.count;
    NSInteger mod = count /2;
    if (count % 2 > 0)
    {
        mod ++;
    }
    
    if (index < mod)
    {
        [theCell setLeftModel:_listClothesArr[indexPath.row*2+0]];
        theCell.index = 0;
        theCell.userInteractionEnabled = YES;
        if ((index+1)*2<=_listClothesArr.count) {
            [theCell setRightModel:_listClothesArr[index*2+1]];
            theCell.userInteractionEnabled = YES;
            theCell.index = 1;
        }
        else
        {
            [theCell setRightModel:nil];
            theCell.index = 1;

        }
        [theCell setTheBigBlock:^(NSInteger index){
            ALClothesDetailViewController *theClothesDetailCtrl=[[ALClothesDetailViewController alloc] init];
            theClothesDetailCtrl.fromMyMagicWardrobe = YES;
            if (index==0) {
                ALMagicWardrobeClothsModel *theModel=_listClothesArr[indexPath.row*2+0];
                [theClothesDetailCtrl setFashionId:theModel.fashion_id];
                theClothesDetailCtrl.mwColothsId = theModel.mwColothsId;
                [self.navigationController pushViewController:theClothesDetailCtrl animated:YES];
            }else if (index==1){
                NSInteger index = indexPath.row*2+1;
                if (index < _listClothesArr.count)
                {
                    ALMagicWardrobeClothsModel *theModel=_listClothesArr[index];
                    [theClothesDetailCtrl setFashionId:theModel.fashion_id];
                    theClothesDetailCtrl.mwColothsId = theModel.mwColothsId;
                    [self.navigationController pushViewController:theClothesDetailCtrl animated:YES];
                }

            }

            
            

        }];
        [theCell setTheSmallBlock:^(NSInteger index){
            NSInteger indexTmp = indexPath.row;
            indexTmp = indexTmp * 2 + index;
            if (indexTmp < _listClothesArr.count)
            {
                ALMagicWardrobeClothsModel *theModel=_listClothesArr[indexTmp];
                [self _addAbanWardrobe:theModel.mwColothsId];
            }
            

        }];
        
        return theCell;
    }
    return theCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 644/4+10+108/4 - 5;
}

#pragma mark loadData
#pragma mark -
-(void)_loadMyWardrobeDataAndBlock:(void(^)())theBlock{
    NSDictionary *sendDic=@{
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId]),
                            @"pageNo":[NSString stringWithFormat:@"%ld",(long)_pageNo],
                            @"pageSize":@"10",
                            @"type":_type
                            };
    if (_pageNo==1) {
        [_listClothesArr removeAllObjects];
    }
    [DataRequest requestApiName:@"fashionSquare_myWardrobeData"
                      andParams:sendDic
                      andMethod:Post_type
                   successBlcok:^(id sucContent) {
        @try {
//            id object = sucContent;
            NSArray *tempArr=sucContent[@"body"][@"result"][@"dataList"];
            [tempArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                ALMagicWardrobeClothsModel *theModel=[ALMagicWardrobeClothsModel questionWithDict:obj];
                [_listClothesArr addObject:theModel];
            }];
            

            NSDictionary *totalDic = sucContent[@"body"][@"result"][@"counts"];
            if (totalDic != nil)
            {
                _rightTopCountLbl.text = [NSString stringWithFormat:@"%@",totalDic[@"sbs"]];
                _leftTopCountLbl.text = [NSString stringWithFormat:@"%@",totalDic[@"qs"]];
                _rightBtmCountLbl.text = [NSString stringWithFormat:@"%@",totalDic[@"xbs"]];
            }
            
            
            int rightTop = [_rightTopCountLbl.text intValue];
            int leftTop = [_leftTopCountLbl.text intValue];
            int rightBtm = [_rightBtmCountLbl.text intValue];
            if (([_type isEqualToString:@"全身"] &&  leftTop <= 0) || ([_type isEqualToString:@"上半身"] &&  rightTop <= 0) || ([_type isEqualToString:@"下半身"] &&  rightBtm <= 0))
            {
                _showLabel.hidden = NO;
                _myMWTableView.hidden = NO;
            }else{
                _showLabel.hidden = YES;
                _myMWTableView.hidden = NO;
            }
            
            [_myMWTableView reloadData];
        }
        @catch (NSException *exception) {
            NSLog(@"error:%@",exception);
        }
        @finally {
        }
        if (theBlock) {
            theBlock();
        }
    } failedBlock:^(id failContent) {
        showFail(failContent);
    } reloginBlock:^(id reloginContent) {
    } andShowLoad:YES];
}
//加入费衣娄
-(void)_addAbanWardrobe:(NSString *)wardrobeId{
    NSDictionary *sendDic=@{
                            @"wardrobeId":filterStr(wardrobeId),
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId])

                            };
    [DataRequest requestApiName:@"fashionSquare_addAbanWardrobe"
                      andParams:sendDic
                      andMethod:Get_type
                   successBlcok:^(id sucContent) {
        showWarn(@"移除成功");
                       _pageNo=1;
                       [_myMWTableView reloadData];
                       [self _loadMyWardrobeDataAndBlock:^{
 
                       }];
    } failedBlock:^(id failContent) {
        showFail(failContent);
    } reloginBlock:^(id reloginContent) {
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)endRefresh
{
    [_myMWTableView headerEndRefreshing];
    [_myMWTableView footerEndRefreshing];
}

@end
