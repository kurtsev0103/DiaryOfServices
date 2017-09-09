//
//  OKNewNoteTableViewController.m
//  DiaryOfServices
//
//  Created by Oleksandr Kurtsev on 07.09.17.
//  Copyright © 2017 Oleksandr Kurtsev. All rights reserved.
//

#import "OKNewNoteTableViewController.h"
#import "OKNote+CoreDataProperties.h"
#import "OKDataManager.h"

@interface OKNewNoteTableViewController () <UITextFieldDelegate>

@end

@implementation OKNewNoteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        return 144.f;
    } else if (indexPath.row == 8) {
        return 44.f;
    } else {
        return 30.f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.nameClientTextField]) {
        [self.nameNoteTextField becomeFirstResponder];
    } else if ([textField isEqual:self.nameNoteTextField]) {
        [self.priceTextField becomeFirstResponder];
    } else if ([textField isEqual:self.priceTextField]) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    textField.text = @"";
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([textField isEqual:self.nameClientTextField] ||
        [textField isEqual:self.nameNoteTextField]) {
        
        NSString* validNameCharacters = @" abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
        NSCharacterSet* set = [[NSCharacterSet characterSetWithCharactersInString:validNameCharacters] invertedSet];
        NSArray* components = [string componentsSeparatedByCharactersInSet:set];
        
        if (components.count == 1) {
            
            NSArray* componentsByAt =
            [[textField.text stringByReplacingCharactersInRange:range withString:string] componentsSeparatedByString:@"@"];
            NSString* resultString = [textField.text stringByReplacingCharactersInRange:range withString:string];
            
            if (componentsByAt.count <= 2 && resultString.length <= 30) {
                
                textField.text = resultString;
                
                if ([textField isEqual:self.nameClientTextField]) {
                    self.nameClientTextField.text = resultString;
                } else {
                    self.nameNoteTextField.text = resultString;
                }
                
            }
            
        }
        
        return NO;
        
    } else if ([textField isEqual:self.priceTextField]) {
        
        NSCharacterSet* validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        NSArray* components = [string componentsSeparatedByCharactersInSet:validationSet];
        
        if (components.count == 1) {
            
            NSString* newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
            NSArray* validComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
            newString = [validComponents componentsJoinedByString:@""];
            
            NSRange range = [newString rangeOfString:@"0"];
            
            if (newString.length <= 6 && range.location != 0) {
                
                textField.text = newString;
                self.priceTextField.text = newString;
                
            }
            
        }
        
        return NO;
    }
    
    return YES;
}

#pragma mark - Actions

- (IBAction)actionSave:(UIButton *)sender {
    
    OKNote* note =
    [NSEntityDescription insertNewObjectForEntityForName:@"OKNote"
                                  inManagedObjectContext:[OKDataManager sharedManager].persistentContainer.viewContext];
    
    note.note = self.nameNoteTextField.text;
    
    if (self.nameClientTextField.text.length > 0) {
        note.client = self.nameClientTextField.text;
    } else {
        note.client = @"";
    }
    
    if (self.priceTextField.text.length > 0) {
        note.price = self.priceTextField.text;
    } else {
        note.price = @"";
    }
    
    NSDateFormatter* dateFormatter = [NSDateFormatter new];
    
    [dateFormatter setDateFormat:@"dd MM yyyy"];
    NSString* currentDateStr = [dateFormatter stringFromDate:self.date];
    
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString* currentTimeStr = [dateFormatter stringFromDate:self.datePicker.date];
    
    [dateFormatter setDateFormat:@"dd MM yyyy HH:mm"];
    
    NSDate* date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@", currentDateStr, currentTimeStr]];
    
    note.date = date;
    
    [[OKDataManager sharedManager] saveContext];
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)actionCancel:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
