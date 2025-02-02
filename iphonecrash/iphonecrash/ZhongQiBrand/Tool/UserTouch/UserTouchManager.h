//
//  UserTouchManager.h
//  VoteCloud
//
//  Created by ios2 on 2019/8/14.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
	NotSurportTouchId,      //不支持
	UserCancelType,             //用户自己关闭
	UserSetCloseType,       //用户设置关闭
	AuthorSucessType,      //验证成功
	AuthorFailType,            //验证失败
} TouchIdAuthorState;


@interface UserTouchManager : NSObject

//是否用户启用指纹
+(BOOL)isOpenTouch;

//设置是否开启指纹
+(void)setIsOpenTouch:(BOOL)isOpen;

//是否支持指纹或者 faceId
+(BOOL)isSuportTouch;

//使用指纹或者 faceID 时 有可能是异步回到主线程
+(void)useFaceOrTouch:(void(^)(TouchIdAuthorState state))completion;

@end

