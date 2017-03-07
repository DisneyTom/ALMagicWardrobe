//
//  DataRequest.m
//  GoodNews
//
//  Created by 紫月 on 14-7-9.
//
//

#import "DataRequest.h"
#import "OcnCacheTool.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import "NSStringAdditions.h"
static BOOL showLoadView=NO;

@implementation DataRequest
+ (AFHTTPRequestOperationManager *)sharedInstance {
    static dispatch_once_t once;
    static AFHTTPRequestOperationManager *_manager;
    dispatch_once(&once, ^{
        _manager = [AFHTTPRequestOperationManager manager];
    });
    return _manager;
}
+(void)requestApiName:(NSString *)apiName
            andParams:(NSDictionary *)params
            andMethod:(ReqeustMethodEnum)method
         successBlcok:(void(^)(id sucContent))successBlock
          failedBlock:(void(^)(id failContent))failedBlock
         reloginBlock:(void(^)(id reloginContent))reloginBlock andShowLoad:(BOOL)show{
    showLoadView=show;
    [DataRequest requestApiName:apiName andParams:params andMethod:method successBlcok:successBlock failedBlock:failedBlock reloginBlock:reloginBlock];
}
+(void)requestApiName:(NSString *)apiName
            andParams:(NSDictionary *)params
            andMethod:(ReqeustMethodEnum)method
         successBlcok:(void(^)(id sucContent))successBlock
          failedBlock:(void(^)(id failContent))failedBlock
         reloginBlock:(void(^)(id reloginContent))reloginBlock{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",
                        GetApiByKey(@"host"),
                        GetApiByKey(apiName)
                        ];
    NSDictionary *params1=@{
                            @"body":params
                            };
    NSString *post1=[NSString stringWithFormat:@"%@",[params1 JSONString]];
    
    NSDictionary *p2=@{
                       @"dataJson":post1
                       };
    switch (method) {
        case Get_type:
        {
            showLoadView?showRequest:@"";
            [[DataRequest sharedInstance] GET:urlStr parameters:p2 success:^(AFHTTPRequestOperation *operation, id responseObject) {

                
                showLoadView?hideRequest:@"";
                showLoadView=NO;
                //                NSLog(@"%@",responseObject);
             //   DLog(@"%@",operation.request.URL);
                id object = responseObject;
              //  DLog(@"%@",object);
                
                if ([responseObject[@"body"][@"code"] isEqualToString:@"000000"]) {
                    if (successBlock) {
                        successBlock(responseObject);
                    }
                }else{
                    if(failedBlock){
                        failedBlock(responseObject);
                    }
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                showLoadView?hideRequest:@"";
                showLoadView=NO;

                NSLog(@"%@",error);
                if(failedBlock){
                    failedBlock(operation);
                }
            }];
        }
            break;
        case Post_type:
        {
        
                showLoadView?showRequest:@"";
        
            
            [[DataRequest sharedInstance] POST:urlStr parameters:p2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    showLoadView?showRequest:@"";
                    showLoadView=NO;
               // NSLog(@"___________+++++++++++++%@",responseObject);
               // NSLog(@"%@",operation.request.URL);
                if ([responseObject[@"body"][@"code"] isEqualToString:@"000000"]) {
                    if (successBlock) {
                        successBlock(responseObject);
                    }
                }else{
                    if(failedBlock){
                        failedBlock(responseObject);
                    }
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                showLoadView?hideRequest:@"";
                showLoadView=NO;

            //    NSLog(@"%@",error);
                if(failedBlock){
                    failedBlock(operation);
                }
            }];
        }
            break;
        default:
            break;
    }
}
+(void)requestApiName:(NSString *)apiName
            andParams:(NSDictionary *)params
               andImg:(NSData *)imgData
         successBlcok:(void(^)(id sucContent))successBlock
          failedBlock:(void(^)(id failContent))failedBlock
         reloginBlock:(void(^)(id reloginContent))reloginBlock{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",
                        GetApiByKey(@"host"),
                        GetApiByKey(apiName)
                        ];
    NSDictionary *params1=@{
                            @"body":params
                            };
    NSString *post1=[NSString stringWithFormat:@"%@",[params1 JSONString]];
    
    NSDictionary *p2=@{
                       @"dataJson":[post1 urlEncoded]
                       };
    
    NSString *post2=[NSString stringWithFormat:@"dataJson=%@",[post1 urlEncoded]];
    
    NSString *str=[NSString stringWithFormat:@"%@?%@",urlStr,post2];
    
    [[DataRequest sharedInstance] POST:str
                            parameters:p2
             constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                 //添加要上传的文件，此处为图片
                 [formData appendPartWithFileData:imgData
                                             name:@"name"
                                         fileName:@"file.jpeg"
                                         mimeType:@"image/jpeg"];
             } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 NSLog(@"%@",operation.request.URL);
                 if (successBlock) {
                     successBlock(responseObject);
                 }
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             }];
}
@end
