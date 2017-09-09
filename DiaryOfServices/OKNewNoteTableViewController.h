//
//  OKNewNoteTableViewController.h
//  DiaryOfServices
//
//  Created by Oleksandr Kurtsev on 07.09.17.
//  Copyright © 2017 Oleksandr Kurtsev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKNewNoteTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *nameNoteTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameClientTextField;

@property (strong, nonatomic) NSDate* date;

- (IBAction)actionSave:(UIButton *)sender;
- (IBAction)actionCancel:(UIButton *)sender;

@end
