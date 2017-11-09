//
//  NoteInfo.h
//  XML数据解析
//
//  Created by zh dk on 2017/8/29.
//  Copyright © 2017年 zh dk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoteInfo : NSObject

@property(retain,nonatomic) NSString *date;
@property(retain,nonatomic) NSString *content;
@property(retain,nonatomic) NSString *user;
@property(assign,nonatomic) NSInteger *noteId;

@end
