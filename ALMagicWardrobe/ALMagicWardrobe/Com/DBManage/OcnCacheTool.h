//
//  OcnCacheTool.h
//  OcnO2O
//
//  Created by anLun on 15-1-17.
//  Copyright (c) 2015年 广州都市圈信息技术服务有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OcnCacheTool : NSObject
AL_AS_SINGLETON(OcnCacheTool);

#pragma mark 首页
/**
 *  添加首页的缓存
 *
 *  @param indexDic 需要缓存的字典
 */
-(void)addIndexIndexCache:(NSDictionary *)indexDic;

/**
 *  获取首页缓存字典
 *
 *  @return 返回首页缓存字典
 */
-(NSDictionary *)indexIndexCache;

#pragma mark 行业列表
/**
 *  行业列表缓存字典
 *
 *  @param shopListIndustryDic 缓存字典
 */
-(void)addShopListIndustryCache:(NSDictionary *)shopListIndustryDic;

/**
 *  获取行业列表字典
 *
 *  @return 返回行业列表缓存字典
 */
-(NSDictionary *)shopListIndustryCache;

#pragma mark 商店
/**
 *  商店列表缓存字典
 *
 *  @param shopPageDic 缓存字典
 */
-(void)addShopPageCache:(NSDictionary *)shopPageDic andToken:(NSDictionary *)params;
/**
 *  获取商店列表缓存
 *
 *  @return 返回缓存字典
 */
-(NSDictionary *)shopPageCacheAndToken:(NSDictionary *)params;

#pragma mark 优惠
/**
 *  <#Description#>
 *
 *  @param couponPageDic <#couponPageDic description#>
 *  @param params        <#params description#>
 */
-(void)addCouponPageCache:(NSDictionary *)couponPageDic andToken:(NSDictionary *)params;
/**
 *  <#Description#>
 *
 *  @param params <#params description#>
 *
 *  @return <#return value description#>
 */
-(NSDictionary *)couponPageCacheAndToken:(NSDictionary *)params;

#pragma mark 活动
/**
 *  <#Description#>
 *
 *  @param activityPageDic <#activityPageDic description#>
 *  @param params          <#params description#>
 */
-(void)addActivityPageCache:(NSDictionary *)activityPageDic andToken:(NSDictionary *)params;
/**
 *  <#Description#>
 *
 *  @param params <#params description#>
 *
 *  @return <#return value description#>
 */
-(NSDictionary *)activityPageCacheAndToken:(NSDictionary *)params;

/**
 *  <#Description#>
 *
 *  @param listIndustryClassifyDic <#listIndustryClassifyDic description#>
 *  @param params                  <#params description#>
 */
-(void)addShopListIndustryClassifyCache:(NSDictionary *)listIndustryClassifyDic andToken:(NSDictionary *)params;
/**
 *  <#Description#>
 *
 *  @param params <#params description#>
 *
 *  @return <#return value description#>
 */
-(NSDictionary *)shopListIndustryClassifyCacheAndToken:(NSDictionary *)params;
@end
