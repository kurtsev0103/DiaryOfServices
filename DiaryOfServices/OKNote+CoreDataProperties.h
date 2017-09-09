//
//  OKNote+CoreDataProperties.h
//  
//
//  Created by Oleksandr Kurtsev on 07.09.17.
//
//

#import "OKNote+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface OKNote (CoreDataProperties)

+ (NSFetchRequest<OKNote *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *client;
@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, copy) NSString *note;
@property (nullable, nonatomic, copy) NSString *price;

@end

NS_ASSUME_NONNULL_END
