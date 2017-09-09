//
//  OKDayTableViewController.h
//  DiaryOfServices
//
//  Created by Oleksandr Kurtsev on 07.09.17.
//  Copyright © 2017 Oleksandr Kurtsev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface OKDayTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController* fetchedResultsController;

@property (nonatomic, strong) NSDate* date;

@end
