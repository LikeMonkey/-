//
//  UserTouchManager.m
//  VoteCloud
//
//  Created by ios2 on 2019/8/14.
//  Copyright © 2019 CY. All rights reserved.
//

#import "UserTouchManager.h"
#import <LocalAuthentication/LocalAuthentication.h>
 //用户指纹
#define USER_Touch [[NSUserDefaults standardUserDefaults] stringForKey:@"isUserTouch"]

@implementation UserTouchManager

+(BOOL)isOpenTouch {
	if ([UIDevice currentDevice].systemVersion.floatValue < 8.0)  {
		return NO;
	}
	if (!USER_Touch) {
		[self setIsOpenTouch:YES];
		return YES;
	}else{
		if ([USER_Touch isEqualToString:@"1"]) {
			return YES;
		}else{
			return NO;
		}
	}
}
+(void)setIsOpenTouch:(BOOL)isOpen
{
	[[NSUserDefaults standardUserDefaults] setObject:isOpen?@"1":@"0" forKey:@"isUserTouch"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

+(BOOL)isSuportTouch {
	LAContext *ctx = [[LAContext alloc] init]; // 判断设备是否支持指纹识别
	if ([ctx canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:NULL]) {
		return YES;
	}else{
		return NO;
	}
}
+(void)useFaceOrTouch:(void(^)(TouchIdAuthorState state))completion
{
	if (![self isSuportTouch]) {
		!completion?:completion(NotSurportTouchId); //不支持指纹
		return;
	}
	if (![self isOpenTouch]) {
		!completion?:completion(UserSetCloseType); //用户设置关闭
		return;
	}
	LAContext *ctx = [[LAContext alloc] init];
	NSString *str = @"通过Home键验证指纹进行投票";
	if (@available(iOS 11.0, *)) {
		if (ctx.biometryType == LABiometryTypeTouchID) {
			str = @"通过Home键验证指纹进行投票";
		}else if (ctx.biometryType == LABiometryTypeFaceID){
			str = @"通过面容ID验证进行投票";
		}
	}

	[ctx evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
		localizedReason:NSLocalizedString(str,nil)
				  reply:^(BOOL success, NSError *error) {
					  dispatch_async(dispatch_get_main_queue(), ^{
						  if (success) {
							  !completion?:completion(AuthorSucessType); //回调验证成功
						  }else{
							  if (error.code == -2) {
								  !completion?:completion(UserCancelType); //回调用户取消
							  }else{
								  !completion?:completion(AuthorFailType); //指纹验证失败回调
							  }
						  }
					  });
				  }];
}

@end
