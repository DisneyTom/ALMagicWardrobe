//
//  MGUICtrl_Search.m
//  ALMagicWardrobe
//
//  Created by Vct on 15/6/22.
//  Copyright (c) 2015年 anLun. All rights reserved.
//

#import "MGUICtrl_Search.h"
//#import "ALUtilities.h"
#import "ALClothesDetailViewController.h"
#import "ALClothesTableViewCell.h"

@interface MGUICtrl_Search ()

@end

@implementation MGUICtrl_Search
{
    NSString* string_Key;
    NSMutableArray *_listClothesArr;
    ALTextField* _txtField;
    ALTableView *_moreClothesTableView;
    NSMutableArray* array_MostS;
    UIScrollView* scrollView_Most;
    UILabel*      lbl_Prompt;
    float btnY ;
    float btnX;
    int _pageNo;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationView.hidden = true;
    self.navigationController.navigationBarHidden = false;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = true;
    self.navigationView.hidden = false;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setLeftBarButtonItem:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endRefresh) name:@"kNetConnectionException" object:nil];
    _listClothesArr = [[NSMutableArray alloc]init];
    array_MostS = [[NSMutableArray alloc]init];
    scrollView_Most = [[UIScrollView alloc]init];
 //   scrollView_Most.backgroundColor = AL_RGB(240,236,233);
    scrollView_Most.userInteractionEnabled = true;
    UIImageView *bgView=[[UIImageView alloc]
                         initWithFrame:CGRectMake((kScreenWidth-(kScreenWidth-35*2))/2.0f, (kNavigationBarHeight-29)/2+10, kScreenWidth-35*2, 29)];
  //  [bgView setImage:[ALImage imageNamed:@"bg01"]];
    [bgView setUserInteractionEnabled:YES];
    _txtField = [[ALTextField alloc]
                 initWithFrame:CGRectMake(0, 0, bgView.width, bgView.height)];
    _txtField.layer.cornerRadius = 5;
    [_txtField setBackgroundColor:AL_RGB(53,44,31)];
    _txtField.font = [UIFont systemFontOfSize:12];
    [_txtField setTextColor:[UIColor whiteColor]];
    _txtField.textViewDelegate = self;
    [_txtField setTextAlignment:NSTextAlignmentLeft];
    [bgView addSubview:_txtField];
    ALButton *searchBtn=[ALButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setFrame:CGRectMake(0, 0, 27, 27)];
    [searchBtn setImage:[ALImage imageNamed:@"icon006"] forState:UIControlStateNormal];
    _txtField.leftView = searchBtn;
    _txtField.leftViewMode = UITextFieldViewModeAlways;
    _txtField.delegate = self;
    [_txtField becomeFirstResponder];
    self.navigationItem.titleView = bgView;
    self.navigationItem.hidesBackButton = true;
    UIButton *button = [[UIButton alloc]init];
    button.frame = CGRectMake(0, 0, 40, 44);
    [button setTitle:@"  取消" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onRightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:AL_RGB(149,105,62) forState:0];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setRightBarButtonItem:rightItem];
    lbl_Prompt = [[UILabel alloc]init];
    lbl_Prompt.backgroundColor = [UIColor clearColor];
    lbl_Prompt.text = @"大家都在搜";
    lbl_Prompt.font = [UIFont systemFontOfSize:14];
    lbl_Prompt.textColor = ALUIColorFromHex(0x4c4c4c);
    [scrollView_Most addSubview:lbl_Prompt];
    _moreClothesTableView=[[ALTableView alloc]
                           initWithFrame:CGRectMake(0, 0, kScreenWidth, self.contentView.height)];
    [_moreClothesTableView setDataSource:self];
    [_moreClothesTableView setDelegate:self];
    [_moreClothesTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    __block MGUICtrl_Search *theBlockCtrl=self;
    [_moreClothesTableView addHeaderWithCallback:^{
        [theBlockCtrl headLoadMore];
    }];
    [_moreClothesTableView addFooterWithCallback:^{
        [theBlockCtrl foodLoadMore];
    }];

    [self.view addSubview:_moreClothesTableView];
    [self.view addSubview:scrollView_Most];
     int maxCount = (self.view.bounds.size.width - 20 - 50)/55;
    float spaceW = (self.view.bounds.size.width - 20 - 50*(maxCount + 1))/maxCount;
    btnY = 40;
    btnX = 10;
    __block float btnW = 0;
    [self _loadFashionHotSearchAndBlock:^{
        [array_MostS enumerateObjectsUsingBlock:^(id obj,NSUInteger idx,BOOL *stop)
         {
             UIButton* btn = [[UIButton alloc]init];
             btn.backgroundColor = [UIColor whiteColor];
             btn.layer.cornerRadius = 3;
             btn.clipsToBounds = true;
             btn.layer.borderWidth = 0.5;
             btn.layer.borderColor = ALUIColorFromHex(0xa1a1a1).CGColor;
             [btn setTitle:array_MostS[idx] forState:0];
             [btn setTitleColor:ALUIColorFromHex(0xa1a1a1) forState:0];
             btn.tag = idx;
             btn.titleLabel.font = [UIFont systemFontOfSize:10];
             [btn addTarget:self action:@selector(chooseMost:) forControlEvents:UIControlEventTouchUpInside];
             [scrollView_Most addSubview:btn];

             if (idx != 0)
             {
                 NSString* string_BtnContent = array_MostS[idx - 1];
                 if (string_BtnContent.length >= 3)
                 {
                     btnW = 50;
                 }
                 else
                 {
                     btnW = 40;
                 }
                 btnX = btnX + btnW+spaceW;
             }
             if (idx%(maxCount+1) == 0 && idx != 0)
             {
                 btnY = btnY + 10 + 25 ;
                 btnX = 10;
             }
             NSString* string_BtnContent = array_MostS[idx];
             if (string_BtnContent.length >= 3)
             {
                  btn.frame = CGRectMake(btnX, btnY, 50, 25);
             }
             else
             {
                  btn.frame = CGRectMake(btnX, btnY, 40, 25);
             }
            
         }];
    }];
    
    // Do any additional setup after loading the view.
}
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
//{
//    scrollView_Most.hidden = false;
//    return true;
//}
//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//
//}
- (void)endRefresh
{
    [_moreClothesTableView headerEndRefreshing];
    [_moreClothesTableView footerEndRefreshing];
}
-(void)headLoadMore
{
    _pageNo=1;
    [self _loadFashionSearchAndBlock:^{
        [_moreClothesTableView headerEndRefreshing];
        [_moreClothesTableView reloadData];
    }];
}
-(void)foodLoadMore{
    _pageNo+=1;
    [self _loadFashionSearchAndBlock:^{
        [_moreClothesTableView footerEndRefreshing];
        [_moreClothesTableView reloadData];
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location == 0)
    {
        [_listClothesArr removeAllObjects];
        [_moreClothesTableView reloadData];
        scrollView_Most.hidden = false;
    }
    return true;
}
- (void)textViewDidFinsihEditing:(ALTextField *)textField
{
    string_Key = _txtField.text;
    [_listClothesArr removeAllObjects];
    [_moreClothesTableView reloadData];
 //   [_moreClothesTableView reloadData];
    [self _loadFashionSearchAndBlock:^{
        [_moreClothesTableView reloadData];
    }];
}
-(void)onRightButtonClick
{
    [_txtField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:true];
}
//- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
//{
//    [self.navigationController popViewControllerAnimated:true];
//}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    scrollView_Most.frame = self.view.bounds;
    _moreClothesTableView.frame =self.view.bounds;
    lbl_Prompt.frame = CGRectMake(10, 10, 100, 20);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 644/4+10+108/4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listClothesArr.count/2+_listClothesArr.count%2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *clothesIdentify=@"clothesMoreIdentify";
    ALClothesTableViewCell *theCell=[tableView dequeueReusableCellWithIdentifier:clothesIdentify];
    if (theCell==nil) {
        theCell=[[ALClothesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:clothesIdentify];
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
        else{
            [theCell setRightModel:nil];
        }
        
        [theCell setTheBlock:^(NSInteger index){
            ALClothesDetailViewController *theClothesDetailCtrl=[[ALClothesDetailViewController alloc] init];
            if (index==0) {
                ALClothsModel *theModel=_listClothesArr[indexPath.row*2+0];
                [theClothesDetailCtrl setFashionId:theModel.clothsId];
                theClothesDetailCtrl.clothsModel = theModel;
                [self.navigationController pushViewController:theClothesDetailCtrl animated:YES];
            }else if (index==1){
                NSInteger index = indexPath.row*2+1;
                if (index < _listClothesArr.count)
                {
                    ALClothsModel *theModel=_listClothesArr[index];
                    [theClothesDetailCtrl setFashionId:theModel.clothsId];
                    theClothesDetailCtrl.clothsModel = theModel;
                    [self.navigationController pushViewController:theClothesDetailCtrl animated:YES];
                }
                
            }
            
        }];
        
        return theCell;
    }
    return theCell;
    
}
#pragma mark btn Void
#pragma mark -
-(void)chooseMost:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    int index = (int)btn.tag;
    string_Key = array_MostS[index];
    _txtField.text = string_Key;
    [self _loadFashionSearchAndBlock:^{
        scrollView_Most.hidden = true;
        [_moreClothesTableView reloadData];
    }];
}

#pragma mark loadData
#pragma mark -

-(void)_loadFashionHotSearchAndBlock:(void(^)())theBlock
{
    NSDictionary *sendDic=@{@"configKey":@"mostsearch"};
    showRequest;
    [DataRequest requestApiName:@"fashionSquare_SysCongfig"
                      andParams:sendDic
                      andMethod:Post_type
                   successBlcok:^(id sucContent) {
                       @try {
                           @try {
                               hideRequest;
                               NSString *_string =sucContent[@"body"][@"result"][@"configvalue"];
                              
                              NSArray* arr = [_string componentsSeparatedByString:NSLocalizedString(@"，", nil)];
                               // array_MostS = arr;
                               if (arr)
                               {
                                   [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                       // ALClothsModel *theModel=[ALClothsModel questionWithDict:obj];
                                       [array_MostS addObject:obj];
                                   }];
                               }
                           }
                           @catch (NSException *exception) {
                           }
                           @finally {
                           }
                       }
                       @catch (NSException *exception) {
                       }
                       @finally {
                           
                       }
                       if (theBlock)
                       {
                           theBlock();
                       }
                   } failedBlock:^(id failContent) {
                       showFail(failContent);
                   } reloginBlock:^(id reloginContent) {
                   }];
    
    
}
-(void)_loadFashionSearchAndBlock:(void(^)())theBlock{
    NSDictionary *sendDic=@{
                           @"search":filterStr(string_Key),
                            @"pageNo":[NSString stringWithFormat:@"%d",_pageNo],
                            @"pageSize":@"10"
                            };
    if (_pageNo==1) {
        [_listClothesArr removeAllObjects];
    }
    [DataRequest requestApiName:@"fashionSquare_fashionSearch"
                      andParams:sendDic
                      andMethod:Post_type
                   successBlcok:^(id sucContent) {
                       @try {
                           @try {
                               NSArray *arr=sucContent[@"body"][@"result"][@"dataList"];
                               if (arr)
                               {
                                   [_txtField resignFirstResponder];
                                   [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                       ALClothsModel *theModel=[ALClothsModel questionWithDict:obj];
                                       [_listClothesArr addObject:theModel];
                                   }];
                                   if (_listClothesArr.count > 0)
                                   {
                                       scrollView_Most.hidden = true;
                                   }
                                   else
                                   {
                                        scrollView_Most.hidden = false;
                                   }

                               }
                           }
                           @catch (NSException *exception) {
                               
                           }
                           @finally {
                               
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
                   }];
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
