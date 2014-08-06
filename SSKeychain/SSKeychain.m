//
//  SSKeychain.m
//  SSKeychain
//
//  Created by Sam Soffes on 5/19/10.
//  Copyright (c) 2010-2014 Sam Soffes. All rights reserved.
//

#import "SSKeychain.h"

NSString *const kSSKeychainErrorDomain = @"com.samsoffes.sskeychain";
NSString *const kSSKeychainAccountKey = @"acct";
NSString *const kSSKeychainCreatedAtKey = @"cdat";
NSString *const kSSKeychainClassKey = @"labl";
NSString *const kSSKeychainDescriptionKey = @"desc";
NSString *const kSSKeychainLabelKey = @"labl";
NSString *const kSSKeychainLastModifiedKey = @"mdat";
NSString *const kSSKeychainWhereKey = @"svce";

#if __IPHONE_4_0 && TARGET_OS_IPHONE
	static CFTypeRef SSKeychainAccessibilityType = NULL;
#endif

@implementation SSKeychain

+ (NSDictionary *)loginInfoForService:(NSString *)serviceName account:(NSString *)account {
	return [self loginInfoForService:serviceName account:account error:nil];
}


+ (NSDictionary *)loginInfoForService:(NSString *)serviceName account:(NSString *)account error:(NSError *__autoreleasing *)error {
	SSKeychainQuery *query = [[SSKeychainQuery alloc] init];
	query.service = serviceName;
	query.account = account;
	[query fetch:error];
	return query.loginInfo;
}


+ (BOOL)deleteloginInfoForService:(NSString *)serviceName account:(NSString *)account {
	return [self deleteloginInfoForService:serviceName account:account error:nil];
}


+ (BOOL)deleteloginInfoForService:(NSString *)serviceName account:(NSString *)account error:(NSError *__autoreleasing *)error {
	SSKeychainQuery *query = [[SSKeychainQuery alloc] init];
	query.service = serviceName;
	query.account = account;
	return [query deleteItem:error];
}


+ (BOOL)setloginInfo:(NSDictionary *)loginInfo forService:(NSString *)serviceName account:(NSString *)account {
	return [self setloginInfo:loginInfo forService:serviceName account:account error:nil];
}


+ (BOOL)setloginInfo:(NSDictionary *)loginInfo forService:(NSString *)serviceName account:(NSString *)account error:(NSError *__autoreleasing *)error {
	SSKeychainQuery *query = [[SSKeychainQuery alloc] init];
	query.service = serviceName;
	query.account = account;
	query.loginInfo = loginInfo;
	return [query save:error];
}


+ (NSArray *)allAccounts {
	return [self accountsForService:nil];
}


+ (NSArray *)accountsForService:(NSString *)serviceName {
	SSKeychainQuery *query = [[SSKeychainQuery alloc] init];
	query.service = serviceName;
	return [query fetchAll:nil];
}


#if __IPHONE_4_0 && TARGET_OS_IPHONE
+ (CFTypeRef)accessibilityType {
	return SSKeychainAccessibilityType;
}


+ (void)setAccessibilityType:(CFTypeRef)accessibilityType {
	CFRetain(accessibilityType);
	if (SSKeychainAccessibilityType) {
		CFRelease(SSKeychainAccessibilityType);
	}
	SSKeychainAccessibilityType = accessibilityType;
}
#endif

@end
