//
//  OKNewClientTableViewController.h
//  DiaryOfServices
//
//  Created by Oleksandr Kurtsev on 07.09.17.
//  Copyright © 2017 Oleksandr Kurtsev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKNewClientTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

- (IBAction)actionSave:(UIButton *)sender;
- (IBAction)actionCancel:(UIButton *)sender;

@end
