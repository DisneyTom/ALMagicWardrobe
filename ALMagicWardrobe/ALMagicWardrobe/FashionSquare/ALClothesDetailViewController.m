//
//  ALClothesDetailViewController.m
//  ALMagicWardrobe
//
//  Created by anLun on 15-3-19.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "ALClothesDetailViewController.h"
#import "CustomSegmentedControl.h"
#import "ALClothsDetailModel.h"
#import "UIButton+WebCache.h"

static const float PairsIndex = 10000;

@interface ALClothesDetailViewController ()
<UITableViewDataSource,
UITableViewDelegate>
@end

@implementation ALClothesDetailViewController
{
    ALImageView *_imgView;
    ALClothsDetailModel *_theDetailModel;
    ALTableView *_tableView;
    UIImageView* imgView_Bottom;
    UILabel* lbl_TitleName;
    
    UIView* view_AddW;
    
    UIImageView* imgView_Btn ;
    
    float _orginY;
    NSString *_color;
    NSString *_size;
    NSMutableArray *_colorBtnArray;
    NSMutableArray *_sizeBtnArray;
    ALButton *_showTopBtn;
    int  _showType;//1 详情 2 参数 3 搭配
    NSMutableArray *_showThree;//搭配数据
    NSMutableArray *_showfour; //底下的搭配图
    NSMutableArray *_showTwo;//参数数据
    NSMutableArray *_imgMulArr;
    NSString *_selectedColor;
    NSString *_selectedSize;
    NSArray *_selectedCollection;
    __block ALButton *theCollectBtn; //收藏按钮
    
    NSMutableArray* array_Btn;
    NSMutableArray* array_Img;
    NSMutableArray* array_Lbl;
    __block NSString* string_Size;
    UILabel*        lbl_Add;
    ALButton*       btn_Add ;
}

-(void)toTopView
{
    [_tableView setContentOffset:CGPointMake(0,0) animated:true];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger curPage=scrollView.contentOffset.y/scrollView.height;
    if (curPage>=2) {
        [_showTopBtn setHidden:NO];
    }else{
        [_showTopBtn setHidden:YES];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self _loadFashionDetailAndBlock:^{
        
    }];
    _showTopBtn = [ALButton buttonWithType:UIButtonTypeCustom];
    _showTopBtn.hidden = true;
    _showTopBtn.frame = CGRectMake(kScreenWidth-50, kScreenHeight-100, 40, 40);
    [_showTopBtn setImage:[UIImage imageNamed:@"Top_Arrow.png"] forState:UIControlStateNormal];
    [[UIApplication sharedApplication].keyWindow addSubview:_showTopBtn];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:_showTopBtn];
    [_showTopBtn addTarget:self
                    action:@selector(toTopView)
          forControlEvents:UIControlEventTouchUpInside];
    
    _showTopBtn.backgroundColor = [UIColor clearColor];
    [_colorBtnArray removeAllObjects];
    [_sizeBtnArray removeAllObjects];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_showTopBtn removeFromSuperview];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _showThree  = [[NSMutableArray alloc]initWithCapacity:2];
    _showTwo  = [[NSMutableArray alloc]initWithCapacity:2];
    _showfour = [[NSMutableArray alloc] initWithCapacity:0];
    array_Btn = [[NSMutableArray alloc]init];
    array_Img = [[NSMutableArray alloc]init];
    array_Lbl = [[NSMutableArray alloc]init];
    [self setTitle:@"服装详情"];
    [self _initData];
    
    _showType = 1;
    [self _loadFashionDetailAndBlock:^{
        [self _initView];
    }];
}

-(void)_initData{
}



-(void)_initView{
  //  self.contentView.backgroundColor = [UIColor whiteColor];
    _tableView=[[ALTableView alloc]
                initWithFrame:CGRectMake(0, 0, kScreenWidth,
                                         self.contentView.height- 40)];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [_tableView setBackgroundColor:[UIColor clearColor]];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self createTop];
    [self createBottom];
    [self createAdd];
    
    [self.contentView addSubview:_tableView];
}
-(void)createAdd
{
    view_AddW = [[UIView alloc]init];
    view_AddW.backgroundColor = AL_RGB(240, 236, 233);
    view_AddW.frame = CGRectMake(0, self.contentView.height - 40, kScreenWidth, 40);
    UIView* view_AddLine = [[UIView alloc]init];
    view_AddLine.backgroundColor = [UIColor brownColor];
    view_AddLine.frame = CGRectMake(0, 0, kScreenWidth, 0.5);
    UIView* view_AddL = [[UIView alloc]init];
    view_AddL.backgroundColor = [UIColor brownColor];
    view_AddL.frame = CGRectMake(kScreenWidth - 95, 0, 0.3, 40);
    [view_AddW addSubview:view_AddLine];
    [view_AddW addSubview:view_AddL];
    
    btn_Add = [[ALButton alloc]init];
    imgView_Btn = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"add to"]];
    lbl_Add = [[UILabel alloc]init];
    lbl_Add.font = [UIFont systemFontOfSize:16];
    lbl_Add.textAlignment = NSTextAlignmentCenter;
    lbl_Add.text = @"加入衣橱";
    lbl_Add.textColor = [UIColor whiteColor];
    [btn_Add addSubview:imgView_Btn];
    [btn_Add addSubview:lbl_Add];
    btn_Add.frame = CGRectMake(kScreenWidth - 95,0 , 95, 40);
    lbl_Add.frame = btn_Add.bounds;
    imgView_Btn.frame = btn_Add.bounds;
    [view_AddW addSubview:btn_Add];
    [btn_Add setTheBtnClickBlock:^(id sender){
        UIButton* btn =sender;
        btn.userInteractionEnabled = false;
        if ([lbl_Add.text isEqualToString:@"加入衣橱"])
        {
            [self _addWardrobeData:_theDetailModel.clothsId lbl:lbl_Add Size:string_Size];
        }
        else
        {
            [self _addAbanWardrobe:_theDetailModel.collection[0][@"wardrobeId"] lbl:lbl_Add];
        }
        
    }];
    
    UILabel* lbl = [[UILabel alloc]init];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.text = @"尺码";
    lbl.frame = CGRectMake(0,0,70,40);
    
    
    NSArray* array_Size = [_theDetailModel.size componentsSeparatedByString:@","];
    if (array_Size.count == 1)
    {
        ALButton* btn = [[ALButton alloc]init];
        btn.tag = 0;
        UIImageView* imgView;
        UILabel* lbl = [[UILabel alloc]init];
        lbl.highlightedTextColor = [UIColor whiteColor];
        lbl.font = [UIFont systemFontOfSize:12];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.textColor = [UIColor brownColor];
        
        if ( [array_Size[0]isEqualToString:@"均码"])
        {
            imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selected_sizeJ"] highlightedImage:[UIImage imageNamed:@"selected_sizeJHL"]];
            lbl.text = @"均码";
            btn.frame = CGRectMake(75,(40 -25)/2 , 41, 25);
            lbl.frame = btn.bounds;
            imgView.frame = btn.bounds;
        }else
        {
            imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selected_size"] highlightedImage:[UIImage imageNamed:@"selected_sizeHL"]];
            lbl.text = array_Size[0];
            btn.frame = CGRectMake( 75,(40 -25)/2 , 25, 25);
            lbl.frame = btn.bounds;
            imgView.frame = btn.bounds;
        }
        [btn addSubview:imgView];
        [btn addSubview:lbl];
        if (_theDetailModel.collection.count > 0)
        {
            if ([_theDetailModel.collection[0][@"size"] isEqualToString:lbl.text] && [_theDetailModel.collection[0][@"isAbandon"]isEqualToString:@"N"])
            {
                imgView.highlighted = true;
                lbl.highlighted = true;
                lbl_Add.text = @"已加入衣橱";
                lbl_Add.textColor = [UIColor blackColor];
                imgView_Btn.hidden = true;
                btn.backgroundColor = [UIColor clearColor];
            }
            else
            {
                imgView.highlighted = true;
                lbl.highlighted = true;
                string_Size = lbl.text;
            }
        }
        else
        {
            imgView.highlighted = true;
            lbl.highlighted = true;
            string_Size = lbl.text;
        }
        [btn setTheBtnClickBlock:^(id sender)
         {
             imgView.highlighted = true;
             lbl.highlighted = true;
             string_Size= lbl.text;
         }];
        [array_Lbl addObject:lbl];
        [array_Img addObject:imgView];
        [view_AddW addSubview:btn];
        
    }
    else
    {
        [array_Size enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ALButton* btn = [[ALButton alloc]init];
            btn.tag = idx;
            UIImageView* imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selected_size"] highlightedImage:[UIImage imageNamed:@"selected_sizeHL"]];
            UILabel* lbl = [[UILabel alloc]init];
            lbl.font = [UIFont systemFontOfSize:12];
            lbl.textAlignment = NSTextAlignmentCenter;
            lbl.text = array_Size[idx];
            lbl.highlightedTextColor = [UIColor whiteColor];
            lbl.textColor = [UIColor brownColor];
            [btn addSubview:imgView];
            [btn addSubview:lbl];
            btn.frame = CGRectMake(idx*(25+ 5) + 75,(40 -25)/2 , 25, 25);
            lbl.frame = btn.bounds;
            imgView.frame = btn.bounds;
            
            if (_theDetailModel.collection.count > 0)
            {
                if ([_theDetailModel.collection[0][@"size"] isEqualToString:lbl.text] && [_theDetailModel.collection[0][@"isAbandon"]isEqualToString:@"N"])
                {
                    imgView.highlighted = true;
                    lbl.highlighted = true;
                    lbl_Add.text = @"已加入衣橱";
                    lbl_Add.textColor = [UIColor blackColor];
                    btn.backgroundColor = [UIColor clearColor];
                    imgView_Btn.hidden = true;
                }
            }
            
            [btn setTheBtnClickBlock:^(id sender)
             {
                 if ([lbl_Add.text isEqualToString:@"已加入衣橱"])
                 {
                     showWarn(@"请先点击右下角按钮取消加入衣橱");
                 }
                 else
                 {
                 imgView.highlighted = true;
                 lbl.highlighted = true;
                 string_Size = lbl.text;
                 [array_Img enumerateObjectsUsingBlock:^(id obj, NSUInteger idxss, BOOL *stop) {
                     if (idx != idxss)
                     {
                         UIImageView* img = obj;
                         img.highlighted = false;
                         UILabel* lbl = array_Lbl[idxss];
                         lbl.highlighted = false;
                     }
                 }];
                 }
             }];
            [array_Lbl addObject:lbl];
            [array_Img addObject:imgView];
            [view_AddW addSubview:btn];
        }];
    }
    [view_AddW addSubview:lbl];
    
    [self.contentView addSubview:view_AddW];
}
-(void)createTop
{
    ALComView *bgView=[[ALComView alloc]
                       initWithFrame:CGRectMake(0, 0, kScreenWidth, 5+30+5)];
    [bgView setBackgroundColor:[UIColor clearColor]];
    bgView.backgroundColor = AL_RGB(240, 236, 233);
    bgView.userInteractionEnabled = true;
    
    _imgView=[[ALImageView alloc]
              initWithFrame:CGRectMake(0, 0, kScreenWidth, 361)];
    [_imgView setImageWithURL:[NSURL URLWithString:_theDetailModel.mainImage]
             placeholderImage:LoadIngImg];
    [bgView addSubview:_imgView];
    imgView_Bottom = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"deltail_B"]];
    [_imgView addSubview:imgView_Bottom];
    imgView_Bottom.frame = CGRectMake(0, 361 - 35, kScreenWidth, 35);
    lbl_TitleName = [[UILabel alloc]init];
    lbl_TitleName.textColor = [UIColor blackColor];
    lbl_TitleName.font = [UIFont systemFontOfSize:12];
    lbl_TitleName.frame = CGRectMake(20, 0, kScreenWidth-40, 35);
    lbl_TitleName.text = _theDetailModel.name;
    [imgView_Bottom addSubview:lbl_TitleName];
    _orginY =_imgView.bottom + 5;
    //尺码与款式编码
    UIView* view_SizeNu = [[UIView alloc]init];
    view_SizeNu.backgroundColor = [UIColor colorWithRed:252/255.f green:251/255.f blue:251/255.f alpha:1];
    view_SizeNu.frame = CGRectMake(0, _orginY, kScreenWidth, 35);
    UILabel* lbl_Size = [[UILabel alloc]init];
    lbl_Size.backgroundColor = [UIColor clearColor];
    lbl_Size.frame = CGRectMake(10, 0, kScreenWidth - 10, 35);
    lbl_Size.text = [NSString stringWithFormat:@"尺码: %@",[_theDetailModel.size stringByReplacingOccurrencesOfString:@"," withString:@" "]];
    lbl_Size.font = [UIFont systemFontOfSize:12];
    [view_SizeNu addSubview:lbl_Size];
    UILabel* lbl_Number = [[UILabel alloc]init];
    lbl_Number.backgroundColor = [UIColor clearColor];
    lbl_Number.frame = CGRectMake(10, 0, kScreenWidth - 10, 35);
    lbl_Number.font = [UIFont systemFontOfSize:12];
    lbl_Number.frame = CGRectMake(50, 0, 50, 35);
    lbl_Number.text = [NSString stringWithFormat:@"款式编码: %@",_theDetailModel.styleNumber];
    [lbl_Number sizeToFit];
    lbl_Size.frame = CGRectMake(10, 0, kScreenWidth - lbl_Number.width - 20, 35);
    lbl_Number.frame = CGRectMake(10 + lbl_Size.width  , 0, lbl_Number.width, 35);
    [view_SizeNu addSubview:lbl_Number];
    [bgView addSubview:view_SizeNu];
    _orginY = view_SizeNu.bottom + 5;
    
    //尺码表
    UIView* view_SizeModel = [[UIView alloc]init];
    view_SizeModel.backgroundColor = view_SizeNu.backgroundColor;
    
    UIView* view_Detail = [[UIView alloc]init];
    ALLabel*showConten3=[[ALLabel alloc]
                         initWithFrame:CGRectMake(10 , 10, 70, 14)
                         andColor:colorByStr(@"#2E2C28")
                         andFontNum:14];
    showConten3.textColor = [UIColor brownColor];
    showConten3.textAlignment = NSTextAlignmentLeft;
    showConten3.text = @"尺码表:";
    [view_SizeModel  addSubview:showConten3];
    
    
    NSArray *showAll =@[@"尺码",@"胸围",@"腰围",@"臀围",@"肩宽",@"衣长",@"裤长",@"裙长",@"袖长"];
    
    NSInteger dataCount = _showTwo.count;
    NSInteger columnNum = dataCount + 1;
    
    NSInteger rowNum = showAll.count;
    CGFloat bgWidth = 300;
    CGFloat verLineWidth = 0.5;
    CGFloat everWidth = 0.f;
    if (columnNum == 1)
    {
        everWidth = bgWidth;
    }
    else
    {
        everWidth = (bgWidth - verLineWidth * dataCount)/columnNum;
    }
    
    for (int j = 0; j < columnNum; j ++)
    {
        for (int i=0; i<rowNum; i++)
        {
            ALComView *bgView = [[ALComView alloc]
                                 initWithFrame:CGRectMake(10 + (everWidth + verLineWidth) * j, 25 * i,everWidth, 25)];
            [view_Detail addSubview:bgView];
            if (i == 0)
            {
                bgView.backgroundColor=AL_RGB(185,140,96); //title背景
            }
            else
            {
                if (i%2==0) {
                    bgView.backgroundColor = AL_RGB(230,230,230);
                }
                else{
                    bgView.backgroundColor = AL_RGB(242,242,242);
                }
            }
            ALLabel*showConten3=[[ALLabel alloc]
                                 initWithFrame:CGRectMake(0, 0,everWidth, 25)
                                 andColor:colorByStr(@"#2E2C28")
                                 andFontNum:12];
            showConten3.textColor =AL_RGB(92, 92, 92);
            showConten3.textAlignment = NSTextAlignmentCenter;
            //                    showConten3.backgroundColor = [UIColor redColor];
            [bgView addSubview:showConten3];
            if (j != columnNum - 1)
            {
                UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectZero];
                image.backgroundColor = [UIColor whiteColor];
                [bgView addSubview:image];
                image.frame = CGRectMake(everWidth, 0, verLineWidth, 25);
                [bgView addSubview:image];
            }
            
            
            if (j == 0)
            {
                showConten3.text = showAll[i];
            }
            else
            {
                NSInteger contentIndex = j - 1;
                if (i == 0)
                {
                    showConten3.text = MBNonEmptyString(_showTwo[contentIndex][@"size"]);
                }
                if (i==1) {
                    showConten3.text = MBNonEmptyString(_showTwo[contentIndex][@"bust"]);
                }
                if (i==2) {
                    showConten3.text = MBNonEmptyString(_showTwo[contentIndex][@"waistline"]);
                }
                if (i==3) {
                    showConten3.text = MBNonEmptyString(_showTwo[contentIndex][@"hipline"]);
                }
                if (i==4) {
                    showConten3.text = MBNonEmptyString(_showTwo[contentIndex][@"shoulderWidth"]);
                }
                if (i==5) {
                    showConten3.text = MBNonEmptyString(_showTwo[contentIndex][@"length"]);
                }
                if (i==6) {
                    showConten3.text = MBNonEmptyString(_showTwo[contentIndex][@"outseam"]);
                }
                if (i==7) {
                    showConten3.text = MBNonEmptyString(_showTwo[contentIndex][@"skirtLength"]);
                }
                if (i==8) {
                    showConten3.text = MBNonEmptyString(_showTwo[contentIndex][@"sleeveLength"]);
                }
                
            }
            if (i == 0)
            {
                showConten3.textColor=[UIColor whiteColor];
            }
            else
            {
                showConten3.textColor=colorByStr(@"#2E2C28");
            }
            
        }
    }
    view_Detail.frame = CGRectMake(0.f, 30, kScreenWidth, showAll.count * 25);
    view_SizeModel.frame = CGRectMake(0.f, _orginY, kScreenWidth, showAll.count * 25 + 30 + 10);
    [view_SizeModel addSubview:view_Detail];
    [bgView addSubview:view_SizeModel];
    
    _orginY = view_SizeModel.bottom;
    bgView.frame = CGRectMake(0, 0, kScreenWidth, _orginY);
    _tableView.tableHeaderView = bgView;
}

-(void)createBottom
{
    
    UIView* view_Bottom = [[UIView alloc]init];
    view_Bottom.frame = CGRectMake(0, 0, kScreenWidth, 50);
    view_Bottom.backgroundColor = [UIColor colorWithRed:252/255.f green:251/255.f blue:251/255.f alpha:1];
    UILabel* lbl = [[UILabel alloc]init];
    lbl.textColor = [UIColor brownColor];
    lbl.frame = CGRectMake(0, 0, kScreenWidth, 30);
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.text = @"搭配";
    [view_Bottom addSubview:lbl];
    
    CGFloat everyWidth =  (self.contentView.width - 30)/3;
    CGFloat itemHeight = everyWidth;
    
    CGFloat imageY = CGRectGetMaxY(lbl.frame) + 10;
    if (_showfour.count > 0)
    {
        
        NSInteger count = _showfour.count;
        NSInteger mod = count / 3;
        if (count % 3 > 0)
        {
            mod ++;
        }
        for (int j = 0; j < mod; j ++)
        {
            for (int i = 0;  i < 3; i ++)
            {
                int index = j * 3 + i;
                if (index < count)
                {
                    CGFloat x = everyWidth * i + 5 * i + 10;
                    UIButton *contentUpImgBtn=[UIButton buttonWithType:UIButtonTypeCustom];
                    [contentUpImgBtn setFrame:CGRectMake(x,(itemHeight + 5) * j + imageY,everyWidth,itemHeight)];
                    
                    [view_Bottom addSubview:contentUpImgBtn];
                    NSString *imageURL = _showfour[index][@"mainImage"];
                    if (imageURL.length > 0)
                    {
                        [contentUpImgBtn setImageWithURL:[NSURL URLWithString:imageURL] forState:UIControlStateNormal placeholderImage:[ALImage imageNamed:@"icon_about.png"]];
                        contentUpImgBtn.tag = PairsIndex + index;
                        [contentUpImgBtn addTarget:self action:@selector(pairsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                    }
                    
                }
            }
        }
    }
    
    NSInteger count = _showfour.count;
    NSInteger mod = count / 3;
    if (count % 3 > 0)
    {
        mod ++;
    }
    CGFloat contentHeight = 0.f;
    if (mod > 0)
    {
        contentHeight = itemHeight* mod + (mod - 1) * 5;
    }
    view_Bottom.frame = CGRectMake(0, 0, kScreenWidth,lbl.bottom + 32 + contentHeight);
    
    
    
    _tableView.tableFooterView = view_Bottom;
}

#pragma mark tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify=@"identify";
    UITableViewCell *theCell=[tableView dequeueReusableCellWithIdentifier:identify];;
    ALComView *contenView_Detail;
    ALComView *contenView_Parm;
    ALComView *contenView_Mat;
    if (!theCell)
    {
        theCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        
        contenView_Detail= [[ALComView alloc]init];
        contenView_Parm= [[ALComView alloc]init];
        contenView_Mat= [[ALComView alloc]init];
        contenView_Detail.tag = 100;
        contenView_Parm.tag = 101;
        contenView_Mat.tag = 102;
        
        [theCell addSubview:contenView_Detail];
        [theCell addSubview:contenView_Mat];
        [theCell addSubview:contenView_Parm];
    }
    contenView_Detail = (ALComView*)[theCell viewWithTag:100];
    contenView_Mat = (ALComView*)[theCell viewWithTag:101];
    contenView_Parm = (ALComView*)[theCell viewWithTag:102];
    contenView_Detail.hidden = true;
    contenView_Parm.hidden = true;
    contenView_Mat.hidden = true;
    
    
    
    contenView_Detail.hidden = false;
    [contenView_Detail removeAllSubviews];
    NSArray *imageArray;
    if (_theDetailModel.images&&[_theDetailModel.images length]>0) {
        imageArray = [MBNonEmptyStringNo_(_theDetailModel.images) componentsSeparatedByString:@","];
    }
    
    if (_imgMulArr == nil)
    {
        _imgMulArr = [[NSMutableArray alloc] initWithCapacity:0];
        [imageArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ((obj&&[obj length]>0)) {
                [_imgMulArr addObject:obj];
            }
        }];
    }
    contenView_Detail.frame =  CGRectMake(0, 5, kScreenWidth, _imgMulArr.count*371);
    [contenView_Detail setBackgroundColor:[UIColor whiteColor]];
    //    contenView_Detail.backgroundColor = AL_RGB(240, 236, 233);
    contenView_Detail.backgroundColor  =[UIColor colorWithRed:252/255.f green:251/255.f blue:251/255.f alpha:1];
    for (int i=0; i<_imgMulArr.count; i++) {
        
        UIButton *contentUpImgView=[[UIButton alloc]
                                    initWithFrame:CGRectMake(0, i * 366, contenView_Detail.width, 361)];
        [contentUpImgView setImageWithURL:[NSURL URLWithString:_imgMulArr[i]] forState:UIControlStateNormal placeholderImage:[ALImage imageNamed:@"icon_about.png"]];
        [contenView_Detail addSubview:contentUpImgView];
    }
    
    if (_showType==3)
    {
        contenView_Mat.hidden = false;
        [contenView_Mat removeAllSubviews];
        contenView_Mat.frame = CGRectMake(0, 0, kScreenWidth, _showThree.count*361);
        [contenView_Mat setBackgroundColor:[UIColor whiteColor]];
        // [theCell addSubview:contentView];
        contenView_Mat.backgroundColor = AL_RGB(240, 236, 233);
        
        CGFloat tipY = contenView_Mat.bottom;;
        for (int i=0; i<_showThree.count; i++) {
            UIButton *contentUpImgBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            int index = i;
            [contentUpImgBtn setFrame:CGRectMake(0, 5 * i + index * 361, contenView_Mat.width, 361)];
            //                NSString *imageURL = _showThree[i][@"mainImage"];
            NSString *imageURL = _showThree[i];
            if (imageURL.length > 0)
            {
                [contentUpImgBtn setImageWithURL:[NSURL URLWithString:imageURL] forState:UIControlStateNormal placeholderImage:[ALImage imageNamed:@"icon_about.png"]];
                contentUpImgBtn.tag = PairsIndex + i;
                [contentUpImgBtn addTarget:self action:@selector(pairsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            }
            tipY = CGRectGetMaxY(contentUpImgBtn.frame);
            [contenView_Mat addSubview:contentUpImgBtn];
            contentUpImgBtn.userInteractionEnabled = NO;
        }
        CGFloat everyWidth =  (self.contentView.width - 30)/3;
        CGFloat itemHeight = everyWidth;
        if (_showfour.count > 0)
        {
            UILabel *tip = [[UILabel alloc] initWithFrame:CGRectMake(10.f, tipY + 10, contenView_Mat.width - 20, 12)];
            tip.textAlignment = NSTextAlignmentLeft;
            tip.textColor = AL_RGB(199, 170, 151);
            tip.text = @"搭配服装:";
            tip.font = [UIFont systemFontOfSize:12];
            [contenView_Mat addSubview:tip];
            
            CGFloat imageY = CGRectGetMaxY(tip.frame) + 10;
            if (_showfour.count > 0)
            {
                
                NSInteger count = _showfour.count;
                NSInteger mod = count / 3;
                if (count % 3 > 0)
                {
                    mod ++;
                }
                for (int j = 0; j < mod; j ++)
                {
                    for (int i = 0;  i < 3; i ++)
                    {
                        int index = j * 3 + i;
                        if (index < count)
                        {
                            CGFloat x = everyWidth * i + 5 * i + 10;
                            UIButton *contentUpImgBtn=[UIButton buttonWithType:UIButtonTypeCustom];
                            [contentUpImgBtn setFrame:CGRectMake(x,(itemHeight + 5) * j + imageY,everyWidth,itemHeight)];
                            
                            [contenView_Mat addSubview:contentUpImgBtn];
                            NSString *imageURL = _showfour[index][@"mainImage"];
                            if (imageURL.length > 0)
                            {
                                [contentUpImgBtn setImageWithURL:[NSURL URLWithString:imageURL] forState:UIControlStateNormal placeholderImage:[ALImage imageNamed:@"icon_about.png"]];
                                contentUpImgBtn.tag = PairsIndex + index;
                                [contentUpImgBtn addTarget:self action:@selector(pairsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                            }
                            
                            //                                [image setImageWithURL:[NSURL URLWithString:_showfour[index]] placeholderImage:LoadIngImg];
                        }
                    }
                }
            }
        }
        NSInteger count = _showfour.count;
        NSInteger mod = count / 3;
        if (count % 3 > 0)
        {
            mod ++;
        }
        CGFloat contentHeight = 0.f;
        if (mod > 0)
        {
            contentHeight = itemHeight* mod + (mod - 1) * 5;
        }
        contenView_Mat.frame = CGRectMake(0, 5, kScreenWidth, _showThree.count *490 + 32 + contentHeight);
        
    }
    
    [theCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    theCell.backgroundColor = AL_RGB(240, 236, 233);
    return theCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *imageArray = [_theDetailModel.images componentsSeparatedByString:@","];
    if (imageArray.count > 0)
    {
        NSMutableArray *imgMulArr = [[NSMutableArray alloc] initWithCapacity:0];
        [imageArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ((obj&&[obj length]>0)) {
                [imgMulArr addObject:obj];
            }
        }];
        return imgMulArr.count *371 - 60;
    }
    return imageArray.count *371 - 60;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section==1)
//    {
//        return 5+30+5;
//    }else{
//        return 0;
//    }
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark loadData
#pragma mark -
-(void)_loadFashionDetailAndBlock:(void(^)())theBlock{
    showRequest;
    theCollectBtn.userInteractionEnabled = true;
    if (self.fashionId.length <= 0)
    {
        return;
    }
    
    NSDictionary *sendDic=@{
                            @"userId":[[ALLoginUserManager sharedInstance] getUserId],
                            @"fashionId":self.fashionId,
                            @"wardrobeId":filterStr(self.mwColothsId)
                            };
    [DataRequest requestApiName:@"fashionSquare_fashionDetail" andParams:sendDic andMethod:Post_type successBlcok:^(id sucContent) {
        _theDetailModel=[ALClothsDetailModel questionWithDict:sucContent[@"body"][@"result"]];
        
        
        _selectedCollection = _theDetailModel.collection;
        _showTwo = [NSMutableArray arrayWithArray:_theDetailModel.fashionSize];
        _showfour = [NSMutableArray arrayWithArray:_theDetailModel.assortFashions];
        
        [_tableView reloadData];
        
        if (theBlock) {
            theBlock();
        }
        hideRequest;
    } failedBlock:^(id failContent) {
        showFail(failContent);
    } reloginBlock:^(id reloginContent) {
        
    }];
}

#pragma mark - 加入费衣娄
-(void)_addAbanWardrobe:(NSString *)wardrobeId lbl:(UILabel *)lbl{
    if (![[ALLoginUserManager sharedInstance] loginCheck]) {
        [self toLoginAndBlock:^{
            theCollectBtn.userInteractionEnabled = true;
            
            [self _addAbanWardrobe:wardrobeId lbl:lbl];
        } andObj:self];
        return;
    }
    NSDictionary *sendDic=@{
                            @"wardrobeId":filterStr(wardrobeId),
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId])
                            };
    [DataRequest requestApiName:@"fashionSquare_addAbanWardrobe" andParams:sendDic andMethod:Post_type successBlcok:^(id sucContent) {
         btn_Add.userInteractionEnabled = true;
       // hideRequest;
        if(!sucContent[@"body"]||![MBNonEmptyString(sucContent[@"body"][@"code"]) isEqualToString:@"000000"]){
            showWarn(@"移除至衣篓失败");
            
        }else{
            showWarn(@"移除至衣篓成功");
           
            lbl.text = @"加入衣橱";
            lbl.textColor = [UIColor whiteColor];
            imgView_Btn.hidden = false;
            [array_Lbl enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                if (array_Lbl.count > 1)
                {
                    UILabel* lbl = obj;
                    lbl.highlighted = false;
                }
                else
                {
                    UILabel* lbl = obj;
                    string_Size = lbl.text;
                }
                
            }];
            [array_Img enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                if (array_Img.count > 1)
                {
                    UIImageView* img = obj;
                    img.highlighted = false;
                }
            }];
            //            [btn setTitle:@"已移除" forState:UIControlStateNormal];
            [self _loadFashionDetailAndBlock:^{
                
            }];
            int collectsTmp = [self.clothsModel.collects intValue];
            collectsTmp = collectsTmp - 1;
            self.clothsModel.collects = [NSString stringWithFormat:@"%d",collectsTmp];
        }
    } failedBlock:^(id failContent) {
         btn_Add.userInteractionEnabled = true;
        theCollectBtn.userInteractionEnabled = true;
        showFail(failContent);
    } reloginBlock:^(id reloginContent) {
    }];
}
/**
 *  加入衣橱
 *
 *  @param fashionId 衣服id
 */
-(void)_addWardrobeData:(NSString *)fashionIds lbl:(UILabel *)lbl Size:(NSString*)size
{
    if (![[ALLoginUserManager sharedInstance] loginCheck])
    {
        [self toLoginAndBlock:^{
            [self _addWardrobeData:fashionIds lbl:lbl Size:size];
        } andObj:self];
        return;
    }
    //    if (![filterStr(_color) length]>0) {
    //        showWarn(@"请选择颜色");
    //        theCollectBtn.userInteractionEnabled = true;
    //        return;
    //    }
    if ([string_Size isEqualToString:@""] || !string_Size) {
        showWarn(@"请选择尺码");
         btn_Add.userInteractionEnabled = true;
        return;
    }
    NSDictionary *sendDic=@{
                            @"size":filterStr(string_Size),
                            @"userId":filterStr([[ALLoginUserManager sharedInstance] getUserId]),
                            @"fashionId":filterStr(fashionIds),
                            };
    
    [DataRequest requestApiName:@"fashionSquare_addWardrobe"
                      andParams:sendDic
                      andMethod:Post_type
                   successBlcok:^(id sucContent) {
                        btn_Add.userInteractionEnabled = true;
                      // hideRequest;
                       if(!sucContent[@"body"]||![MBNonEmptyString(sucContent[@"body"][@"code"]) isEqualToString:@"000000"]){
                           showWarn(@"加入衣橱失败");
                           lbl.text = @"加入衣橱";
                       }else{
                           
                           showWarn(@"加入衣橱成功");
                           lbl.text = @"已加入衣橱";
                           lbl.textColor = [UIColor blackColor];
                           imgView_Btn.hidden = true;
                           string_Size = @"";
                           [self _loadFashionDetailAndBlock:^{
                               
                           }];
                       }
                   } failedBlock:^(id failContent) {
                       theCollectBtn.userInteractionEnabled = true;
                       showFail(failContent);
                        btn_Add.userInteractionEnabled = true;
                   } reloginBlock:^(id reloginContent) {
                       
                   }];
}


#pragma mark -设置收藏按钮的状态
- (void)setbtnState
{
    if (_color.length > 0 && _size.length > 0)
    {
        __block BOOL isHave = YES;
        [_selectedCollection enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary *dict = obj;
            NSString *selectedColor = [dict objectForKey:@"color"];
            NSString *size = [dict objectForKey:@"size"];
            BOOL isAbandon = [[dict objectForKey:@"isAbandon"] boolValue];
            if ([selectedColor isEqualToString:_color] && [size isEqualToString:_size] &&isAbandon == YES) //存在于衣篓
            {
                isHave = YES; //要了
                *stop = YES;
            }else if ([selectedColor isEqualToString:_color] && [size isEqualToString:_size] &&isAbandon == NO)
            {
                isHave = NO;
                *stop = YES;
            }
        }];
        
        if (isHave == YES)
        {
            theCollectBtn.selected = NO;
            [theCollectBtn setTitle:@"要了" forState:UIControlStateNormal];
        }
        else
        {
            theCollectBtn.selected = YES;
            [theCollectBtn setTitle:@" 不要了" forState:UIControlStateNormal];
        }
    }
    else
    {
        theCollectBtn.selected = NO;
        [theCollectBtn setTitle:@"要了" forState:UIControlStateNormal];
    }
}


//查询搭配
-(void)_loadFashionAssortsAndBlock:(void(^)())theBlock{
    NSDictionary *sendDic=@{
                            @"fashionId":filterStr(self.fashionId)
                            };
    [DataRequest requestApiName:@"fashionSquare_fashionAssorts"
                      andParams:sendDic
                      andMethod:Get_type
                   successBlcok:^(id sucContent) {
                       @try {
                           if (sucContent[@"body"][@"result"]) {
                               if (_showThree.count>0) {
                                   [_showThree removeAllObjects];
                               }
                               if (_showfour.count > 0)
                               {
                                   [_showfour removeAllObjects];
                               }
                               
                               
                               NSString *assort = sucContent[@"body"][@"result"][@"assortImages"];
                               if (assort.length > 0)
                               {
                                   NSArray *ar = [assort componentsSeparatedByString:@","];
                                   [ar enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                       NSString *tmp = obj;
                                       if (tmp.length > 0)
                                       {
                                           [_showThree addObject:tmp];
                                       }
                                   }];
                               }
                               [_showfour addObjectsFromArray:sucContent[@"body"][@"result"][@"fashionAssorts"]];
                           }
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
                   } andShowLoad:YES];
}
//获得尺码表
-(void)_loadFashionSizeTableAndBlock:(void(^)())theBlock{
    NSDictionary *sendDic=@{
                            @"fashionId":filterStr(self.fashionId)
                            };
    [DataRequest requestApiName:@"fashionSquare_fashionSizeTable"
                      andParams:sendDic
                      andMethod:Get_type
                   successBlcok:^(id sucContent) {
                       if (_showTwo.count>0) {
                           [_showTwo removeAllObjects];
                       }
                       [_showTwo addObjectsFromArray:sucContent[@"body"][@"result"]];
                       
                       if (theBlock) {
                           theBlock();
                       }
                   } failedBlock:^(id failContent) {
                       showFail(failContent);
                   } reloginBlock:^(id reloginContent) {
                   } andShowLoad:YES];
}


#pragma mark - 搭配的点击动作
- (void)pairsBtnClick:(UIButton *)btn
{
    NSInteger tag = btn.tag;
    NSInteger indexTmp = tag - PairsIndex;
    if (indexTmp >= 0)
    {
        ALClothesDetailViewController *theCtrl=[[ALClothesDetailViewController alloc] init];
        [theCtrl setFashionId:[NSString stringWithFormat:@"%@",_showfour[indexTmp][@"id"]]];
        [self.navigationController pushViewController:theCtrl animated:YES];
    }
}


#pragma mark - 还原垃圾篓
#pragma mark 从废衣娄还原
-(void)_returnWardrobeAndBlock:(NSString *)wardrobeId{
    NSDictionary *sendDic=@{
                            @"wardrobeId":filterStr(wardrobeId)
                            };
    [DataRequest requestApiName:@"fashionSquare_returnWardrobe"
                      andParams:sendDic
                      andMethod:Get_type
                   successBlcok:^(id sucContent) {
                       showWarn(@"加入衣橱成功");
                       [self _loadFashionDetailAndBlock:^{
                           
                       }];
                   } failedBlock:^(id failContent) {
                       theCollectBtn.userInteractionEnabled = true;
                       showFail(failContent);
                   } reloginBlock:^(id reloginContent) {
                   }];
}
@end
