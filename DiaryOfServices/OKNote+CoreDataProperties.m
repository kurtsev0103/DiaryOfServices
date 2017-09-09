//
//  OKNote+CoreDataProperties.m
//  
//
//  Created by Oleksandr Kurtsev on 07.09.17.
//
//

#import "OKNote+CoreDataProperties.h"

@implementation OKNote (CoreDataProperties)

+ (NSFetchRequest<OKNote *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"OKNote"];
}

@dynamic client;
@dynamic date;
@dynamic note;
@dynamic price;

@end
