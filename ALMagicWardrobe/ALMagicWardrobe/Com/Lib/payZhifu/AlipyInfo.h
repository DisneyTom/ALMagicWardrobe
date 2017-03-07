//
//  AlipyInfo.h
//  ALMagicWardrobe
//
//  Created by wang on 4/15/15.
//  Copyright (c) 2015 anLun. All rights reserved.
//

#ifndef ALMagicWardrobe_AlipyInfo_h
#define ALMagicWardrobe_AlipyInfo_h


///使用时请将以下字段替换为真实数据，这些数据也可以通过接口从服务端获取

//合作商户ID
#define KPartner                @"2088811909396251"

//账户ID
#define KSeller                 @"2088811909396251"

//商户私钥（pkcs8格式）
#define KRsaPrivateKey          @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBANuUwrJ1wyjHm6bXVHINABKs4RtJEVXTLg24XzIdpepSqDuFaEjcyJcl+fRIsqIp6LkVPqg2jvSxGs+2uFh/ZOqsvJvkIDq492nVxRTpvrOeO1bZChCEwtA73ilcw/agMXviVhgMGnpUSi6HsQNgITUbOhnrcpeegaURPvcvG5HpAgMBAAECgYBd8OjS/Lq/yZX37Qu9t34ef0PXLo1yEGUVjZl8kV6YP0CmJk8VTQ+sSp0DO87gvdlIxaQGx0ClwtdboiqAAhCj4txfbh9S1oEiMPQ8g6HCfTnmQ6Gn1LXifV+HV7QZCM8lQoAZVAHKcGuioXtfntmwKZ++DfijVDXyn+dqaZ9VYQJBAPAaejAvzmAuG+rKlOc6IUiK0tWoEU67/mWgBX3PH1gIg7xPkH0qOZmGHHIskXJlbKm+uLJxDu07eHTXA/GfBa0CQQDqHnMNAlQUYZNvu0kZtOzrD3V7Vu+KMaFvFikQZNQYoAxZLiOY2A2UKV9orXefv1WpTnX4PxRmLGsxSXzvtyytAkEA2gbBA7a1iWL1WMxiUGHZzVy6POdj6AIP7UpVEjwdczwwG7SIORA5w64jcI4F+UIeXTlh0C+X5VZGeJqy6xqC9QJBAIFQdk3+NkDXsJ8rfHIVjDM9469P0pmrVjbMr7vdZYWAibGMmZ7n34Ax5gAkqIl1HrSYoPKQrQzOhhrAM6EYtTUCQEpW/iDCO0734vUApXn14fByjNb2tEuXaHSp9UUJZ7ri0G6kwYj4qt0oQQR9OPKJkRRx19rxX01sB4UdQ2KSbEs="

//支付宝公钥(快捷支付的话，所有商家都一样)
#define KRsaPublicKey           @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB"

//回调地址
#define KAliPayNotifyUrl        @"******"

//应用注册scheme（URL types下定义）
#define KAliPayAppScheme        @"AliPay.FrameWorkDemo"

#endif
