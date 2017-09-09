//
//  OKClient+CoreDataProperties.h
//  DiaryOfServices
//
//  Created by Oleksandr Kurtsev on 06.09.17.
//  Copyright © 2017 Oleksandr Kurtsev. All rights reserved.
//

#import "OKClient+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface OKClient (CoreDataProperties)

+ (NSFetchRequest<OKClient *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *phone;

@end

NS_ASSUME_NONNULL_END
