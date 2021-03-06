//
//  JSSOAuthAccount.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/11.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSOAuthAccount.h"

@implementation JSSOAuthAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    JSSOAuthAccount *account = [[self alloc] init];
    
    account.access_token = dict[@"access_token"];
    account.expires_in = dict[@"expires_in"];
    account.uid = dict[@"uid"];
    // 存储保存用户信息时的时间
    [account setSaveTime:[NSDate date]];
    
    return account;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.saveTime forKey:@"saveTime"];
    [encoder encodeObject:self.name forKey:@"name"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    
    if (self) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.saveTime = [decoder decodeObjectForKey:@"saveTime"];
        self.name = [decoder decodeObjectForKey:@"name"];
    }
    
    return self;
}

@end
