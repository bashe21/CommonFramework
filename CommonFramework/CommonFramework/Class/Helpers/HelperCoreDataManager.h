//
//  HelperCoreDataManager.h
//  coreDataDemo
//
//  Created by 张哈哈 on 2017/2/7.
//  Copyright © 2017年 Mr Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface HelperCoreDataManager : NSObject
/** 内存中manageObject对象的上下文*/
@property (strong, nonatomic) NSManagedObjectContext *context;
/** 描述数据模型对象的结构信息*/
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
/** 数据持久层和内存对象模型的协调器*/
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (instancetype)shareInstance;
- (void)saveContext;

@end
