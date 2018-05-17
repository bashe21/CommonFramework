//
//  HelperCoreDataManager.m
//  coreDataDemo
//
//  Created by 张哈哈 on 2017/2/7.
//  Copyright © 2017年 Mr Zhang. All rights reserved.
//

#import "HelperCoreDataManager.h"

@implementation HelperCoreDataManager
// 创建单例
+ (instancetype)shareInstance {
    static HelperCoreDataManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
    });
    return _manager;
}

- (void)saveContext {
    NSManagedObjectContext *context = self.context;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}
#pragma mark -  懒加载
- (NSManagedObjectModel *)managedObjectModel {
    if (!_managedObjectModel) {
        NSURL *modalUrl = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modalUrl];
    }
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (!_persistentStoreCoordinator) {
        // 创建coordinator对象
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        // 创建本地的sqlite数据库文件
        NSURL *sqliteUrl = [[self documentDirectoryURL] URLByAppendingPathComponent:@"Model.sqlite"];
        NSError *error;
        // 为persistentStoreCoordinator指定本地的存储类型，这里为sqlite类型
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqliteUrl options:nil error:&error];
        if (error) {
            NSLog(@"falied to create persistentStoreCoordinator %@", error.localizedDescription);
        }
    }
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)context {
    if (!_context) {
        _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _context.persistentStoreCoordinator = self.persistentStoreCoordinator;
    }
    return _context;
}

// 用来获取 document 目录
- (nullable NSURL *)documentDirectoryURL {
    return [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
}
@end
