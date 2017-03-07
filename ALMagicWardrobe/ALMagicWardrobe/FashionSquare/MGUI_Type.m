//
//  MGUI_Type.m
//  ALMagicWardrobe
//
//  Created by Vct on 15/8/14.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "MGUI_Type.h"
#import "MGUI_TypeViewCell.h"
#import "MGData_Type.h"
#import "ALClothesDetailViewController.h"

@interface MGUI_Type()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation MGUI_Type
{
    UIScrollView*   scrollView_Type; //分类界面
    float btnX;
    float btnY;
    int btnXS;
    int btnYS;
    NSMutableArray* array_Type;
    NSMutableArray* array_Btn;
    NSMutableArray* array_Btns;
    UIView* view_Line;
    
    ALButton* btn_T ;
    ALTableView* tableView_Type; // 选择分类后的UITableView
    NSMutableArray* _listClothesArr;
    int _pageNo;
    NSString* string_Type;
    NSString* string_Style;
    
    UIButton *cancelBtn;  // 取消按钮
    UIButton *confirmBtn; // 确定按钮
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    // 下拉选项 设置
     btn_T = [[ALButton alloc]init];
    UIImageView* imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
    [btn_T addSubview:imgView];
    btn_T.backgroundColor = AL_RGB(240,236,233);
    btn_T.frame = CGRectMake(0, 0, kScreenWidth, 30);
    imgView.frame = CGRectMake((kScreenWidth - 16)/2,(30 - 9)/2,16,9);
    [btn_T setTheBtnClickBlock:^(id sender){
        [UIView animateWithDuration:0.6 animations:^{
            scrollView_Type.frame = CGRectMake(0, 0, self.width, self.height);
        } completion:^(BOOL finished) {
            
        }];
    }];

    string_Type = @"";;
    string_Style = @"";
    self.backgroundColor = colorByStr(@"#F0ECE9");
    view_Line= [[UIView alloc]init];
    view_Line.backgroundColor = ALUIColorFromHex(0xdedede);
    view_Line.frame = CGRectMake(0, 128 + 78 + 10, kScreenWidth, 0.5);
    array_Btn= [[NSMutableArray alloc]init];
    array_Btns = [[NSMutableArray alloc]init];
    scrollView_Type = [[UIScrollView alloc]init];
    scrollView_Type.backgroundColor = colorByStr(@"#F0ECE9");
    [scrollView_Type addSubview:view_Line];
    _pageNo = 1;
    [self addSubview:btn_T];
    _listClothesArr = [[NSMutableArray alloc]init];
    tableView_Type=[[ALTableView alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth, self.height - 30)
                                                style:UITableViewStyleGrouped];
    [tableView_Type setDataSource:self];
    [tableView_Type setDelegate:self];
    [tableView_Type setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    __block MGUI_Type *theCtrl=self;
    [tableView_Type addHeaderWithCallback:^{
        [theCtrl headLoadMore];
    }];
    [tableView_Type addFooterWithCallback:^{
        [theCtrl foodLoadMore];
    }];
    [self addSubview:tableView_Type];
    UIColor *backColor = colorByStr(@"#F0ECE9");
    tableView_Type.backgroundColor = backColor;

    [self createTop];
    [self addSubview:scrollView_Type];
    return self;
}
-(void)createTop
{
    int maxCount = 4;
    float spaceW = (self.width - 20 - 67*maxCount)/3;
    float btnW =67;
    btnY = 226 + 10;
    btnX = 10;
    array_Type = [[NSMutableArray alloc]initWithObjects:@"连衣裙",@"衬衫",@"针织衫",@"卫衣",@"半裙",@"T恤",@"外套",@"大衣",@"毛衣",@"马甲/背心",@"裤子",@"所有", nil];
    [array_Type enumerateObjectsUsingBlock:^(id obj,NSUInteger idx,BOOL *stop)
     {
         UIButton* btn = [[UIButton alloc]init];
         [btn setBackgroundImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
         btn.backgroundColor = [UIColor clearColor];
         btn.layer.cornerRadius = 3;
         btn.clipsToBounds = true;
         btn.layer.borderWidth = 0.5;
         btn.layer.borderColor = ALUIColorFromHex(0xa1a1a1).CGColor;
         [btn setTitle:array_Type[idx] forState:0];
         [btn setTitleColor:ALUIColorFromHex(0x81776a) forState:0];
         [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
         btn.tag = idx;
         btn.titleLabel.font = [UIFont systemFontOfSize:12];
         [btn addTarget:self action:@selector(chooseTypeName:) forControlEvents:UIControlEventTouchUpInside];
         [scrollView_Type addSubview:btn];
         if (idx != 0)
         {
             btnX = btnX + btnW + spaceW;
             if (idx%maxCount == 0) {
                 btnY = btnY + 25 + 30 ;
                 btnX = 10;
                 scrollView_Type.contentSize = CGSizeMake(self.width,btnY + 30 + 30);
             }
         }
         btn.frame = CGRectMake(btnX, btnY, btnW, 30);
         [array_Btn addObject:btn];
     }];
    NSArray * array_Style = [[NSMutableArray alloc]initWithObjects:@"甜美清新",@"职场淑女",@"文艺小妞",@"轻松休闲",@"女王大人",@"小小性感", nil];
    btnXS = 17;
    btnYS = 20;
    float btnWS = 78;
    float spaceWS = (self.width - 35 - btnWS * 3)/2;
    [array_Style enumerateObjectsUsingBlock:^(id obj,NSUInteger idx,BOOL *stop)
     {
         UIButton* btn = [[UIButton alloc]init];
         [btn setBackgroundImage:[UIImage imageNamed:@"unselected big"] forState:0];
         [btn setBackgroundImage:[UIImage imageNamed:@"selected big"] forState:UIControlStateSelected];
         [btn setTitle:array_Style[idx] forState:0];
         [btn setTitleColor:ALUIColorFromHex(0x81776a) forState:0];
         [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
         btn.tag = idx;
         btn.titleLabel.font = [UIFont systemFontOfSize:12];
         [btn addTarget:self action:@selector(chooseStyle:) forControlEvents:UIControlEventTouchUpInside];
         [scrollView_Type addSubview:btn];
         if (idx != 0)
         {
             btnXS = btnXS + btnWS + spaceWS;
             if (idx%3 == 0)
             {
                 btnYS = btnYS + 20 + 78 ;
                 btnXS = 17;
             }
         }
         btn.frame = CGRectMake(btnXS, btnYS, btnWS, 78);
         [array_Btns addObject:btn];
     }];
}
-(void)showChoose
{
    [UIView animateWithDuration:0.6 animations:^{
       scrollView_Type.frame = CGRectMake(0, 0, self.width, self.height);
    } completion:^(BOOL finished) {
        
    }];
    
}
-(void)chooseStyle:(id)sender
{
    [_listClothesArr removeAllObjects];
    [tableView_Type reloadData];
    [array_Btns enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (sender == obj)
        {
            UIButton* btn = obj;
            btn.selected = true;
            [UIView animateWithDuration:0.6 animations:^{
                scrollView_Type.frame = CGRectMake(0, -self.height, self.width, self.height);
            } completion:^(BOOL finished) {
                
            }];
            string_Style = btn.titleLabel.text;
            string_Type = @"";
            [self _loadFashionSquareAllDataAndBlock:^{
                [tableView_Type reloadData];
            }];
        }
        else
        {
            UIButton* btn = obj;
            btn.selected = false;
        }
    }];
    [array_Btn enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton* btn = obj;
        btn.selected = false;
    }];
}
-(void)chooseTypeName:(id)sender
{
     [_listClothesArr removeAllObjects];
    [tableView_Type reloadData];
    
    [array_Btn enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (sender == obj)
        {
            UIButton* btn = obj;
            btn.selected = true;
            [UIView animateWithDuration:0.6 animations:^{
                scrollView_Type.frame = CGRectMake(0, -self.height, self.width, self.height);
            } completion:^(BOOL finished) {
                
            }];
            string_Style = @"";
            string_Type = btn.titleLabel.text;
            [self _loadFashionSquareAllDataAndBlock:^{
                [tableView_Type reloadData];
            }];
//            if (self.blockMove)
//            {
//                self.blockMove(@"",btn.titleLabel.text);
//            }
        }
        else
        {
            UIButton* btn = obj;
            btn.selected = false;
        }
    }];
    [array_Btns enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton* btn = obj;
        btn.selected = false;
    }];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    scrollView_Type.frame = self.bounds;
}
-(void)headLoadMore{
    _pageNo=1;
    [self _loadFashionSquareAllDataAndBlock:^{
        [tableView_Type headerEndRefreshing];
        [tableView_Type reloadData];
    }];
}
-(void)foodLoadMore{
    _pageNo+=1;
    [self _loadFashionSquareAllDataAndBlock:^{
        [tableView_Type footerEndRefreshing];
        [tableView_Type reloadData];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listClothesArr.count/2+_listClothesArr.count%2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *clothesIdentify=@"clothesMoreIdentify";
    MGUI_TypeViewCell *theCell=[tableView dequeueReusableCellWithIdentifier:clothesIdentify];
    if (theCell==nil) {
        theCell=[[MGUI_TypeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:clothesIdentify];
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
        
        if ((indexPath.row+1)*2<=_listClothesArr.count) {
            [theCell setRightModel:_listClothesArr[indexPath.row*2+1]];
        }
        else
        {
            [theCell setRightModel:nil];
        }
        
        [theCell setTheBlock:^(NSInteger index){
            if (index==0) {
                MGData_Type *theModel=_listClothesArr[indexPath.row*2+0];
                if (self.theblock)
                {
                    self.theblock(theModel.keyFashionsId);
                }
            }else if (index==1){
                NSInteger indexTmp = indexPath.row*2+1;
                if (indexTmp < _listClothesArr.count)
                {
                    MGData_Type *theModel=_listClothesArr[indexTmp];
                    if (self.theblock)
                    {
                        self.theblock(theModel.keyFashionsId);
                    }
                }
                
            }
            
        }];
        
        return theCell;
    }
    return theCell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}
#pragma mark loadData
#pragma mark -
-(void)_loadFashionSquareAllDataAndBlock:(void(^)())theBlock{
    NSDictionary *sendDic=@{
                            @"type":string_Type,
                            @"style":string_Style,
                            @"pageNo":[NSString stringWithFormat:@"%d",_pageNo],
                            @"pageSize":@"10"
                            };
    if (_pageNo==1) {
        [_listClothesArr removeAllObjects];
    }
    NSLog(@"%@",sendDic);
    [DataRequest requestApiName:@"fashionSquare_fashionSquareAllData" andParams:sendDic andMethod:Post_type successBlcok:^(id sucContent) {
        
        @try {
            NSArray *clothsArr=sucContent[@"body"][@"result"][@"dataList"];
            
            [clothsArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                MGData_Type *theModel=[MGData_Type questionWithDict:obj];
                [_listClothesArr addObject:theModel];
            }];
            
        }
        @catch (NSException *exception) {
        }
        @finally {
        }
        if (theBlock) {
            theBlock();
        }
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
    [tableView_Type headerEndRefreshing];
    [tableView_Type footerEndRefreshing];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
