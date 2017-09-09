//
//  OKDataManager.h
//  DiaryOfServices
//
//  Created by Oleksandr Kurtsev on 06.09.17.
//  Copyright © 2017 Oleksandr Kurtsev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface OKDataManager : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

+ (OKDataManager*)sharedManager;

- (void)saveContext;

@end
