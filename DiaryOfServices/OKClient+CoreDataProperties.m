//
//  OKClient+CoreDataProperties.m
//  DiaryOfServices
//
//  Created by Oleksandr Kurtsev on 06.09.17.
//  Copyright © 2017 Oleksandr Kurtsev. All rights reserved.
//

#import "OKClient+CoreDataProperties.h"

@implementation OKClient (CoreDataProperties)

+ (NSFetchRequest<OKClient *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"OKClient"];
}

@dynamic name;
@dynamic phone;

@end
