//
//  DataRequest.h
//  GoodNews
//
//  Created by 紫月 on 14-7-9.
//
//

#import <Foundation/Foundation.h>

typedef enum {
    Get_type,
    Post_type
}ReqeustMethodEnum; //请求方式

@interface DataRequest : NSObject
/**
 *  通讯通用接口
 *
 *  @param apiName  MWApi.plist 里面的 key
 *  @param params       参数
 *  @param method       get或post或.....
 *  @param successBlock 成功返回block
 *  @param failedBlock  失败回调block
 *  @param reloginBlock 重新登录回调block
 */
+(void)requestApiName:(NSString *)apiName
            andParams:(NSDictionary *)params
            andMethod:(ReqeustMethodEnum)method
         successBlcok:(void(^)(id sucContent))successBlock
          failedBlock:(void(^)(id failContent))failedBlock
         reloginBlock:(void(^)(id reloginContent))reloginBlock;

+(void)requestApiName:(NSString *)apiName
            andParams:(NSDictionary *)params
            andMethod:(ReqeustMethodEnum)method
         successBlcok:(void(^)(id sucContent))successBlock
          failedBlock:(void(^)(id failContent))failedBlock
         reloginBlock:(void(^)(id reloginContent))reloginBlock andShowLoad:(BOOL)show;

+(void)requestApiName:(NSString *)apiName
            andParams:(NSDictionary *)params
               andImg:(NSData *)imgData
         successBlcok:(void(^)(id sucContent))successBlock
          failedBlock:(void(^)(id failContent))failedBlock
         reloginBlock:(void(^)(id reloginContent))reloginBlock;
@end
