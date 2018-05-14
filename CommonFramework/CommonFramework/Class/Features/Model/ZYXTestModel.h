//
//  ZYXTestModel.h
//  CommonFramework
//
//  Created by 张哈哈 on 2018/5/14.
//  Copyright © 2018年 zyx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYXBook:ZYXBaseModel
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *pages;
@end

@interface ZYXTestModel : ZYXBaseModel
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic,strong) NSMutableArray *books;
@end



