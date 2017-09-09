//
//  OKNewClientTableViewController.m
//  DiaryOfServices
//
//  Created by Oleksandr Kurtsev on 07.09.17.
//  Copyright © 2017 Oleksandr Kurtsev. All rights reserved.
//

#import "OKNewClientTableViewController.h"
#import "OKClient+CoreDataProperties.h"
#import "OKDataManager.h"

@interface OKNewClientTableViewController () <UITextFieldDelegate>

@end

@implementation OKNewClientTableViewController

static const int localNumberMaxLenght = 7;
static const int areaCodeMaxLenght = 3;
static const int countryCodeMaxLenght = 3;

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

#pragma mark - Methods

- (NSString*)formatPhoneNumberWithString:(NSString*)newString {

    NSMutableString* resultString = [NSMutableString new];
    
    NSInteger localNumberLength = MIN([newString length], localNumberMaxLenght);
    
    if (localNumberLength > 0) {
        
        NSString* number = [newString substringFromIndex:(int)[newString length] - localNumberLength];
        
        [resultString appendString:number];
        
        if (resultString.length > 3) {
            [resultString insertString:@" " atIndex:3];
        }
    }
    
    if (newString.length > localNumberMaxLenght) {
        
        NSInteger areaCodeLength = MIN((int)newString.length - localNumberMaxLenght, areaCodeMaxLenght);
        
        NSRange areaRange = NSMakeRange((int)newString.length - localNumberMaxLenght - areaCodeLength, areaCodeLength);
        
        NSString* area = [newString substringWithRange:areaRange];
        
        area = [NSString stringWithFormat:@"(%@) ", area];
        
        [resultString insertString:area atIndex:0];
    }
    
    if (newString.length > localNumberMaxLenght + areaCodeMaxLenght) {
        
        NSInteger countryCodeLength = MIN((int)newString.length - localNumberMaxLenght - areaCodeMaxLenght, countryCodeMaxLenght);
        
        NSRange countryCodeRange = NSMakeRange(0, countryCodeLength);
        
        NSString* countryCode = [newString substringWithRange:countryCodeRange];
        
        countryCode = [NSString stringWithFormat:@"+%@ ", countryCode];
        
        [resultString insertString:countryCode atIndex:0];
    }
    
    return resultString;
}

#pragma mark - Actions

- (IBAction)actionSave:(UIButton *)sender {
    
    OKClient* client =
    [NSEntityDescription insertNewObjectForEntityForName:@"OKClient"
                                  inManagedObjectContext:[OKDataManager sharedManager].persistentContainer.viewContext];
    
    client.name = self.nameTextField.text;
    
    if (self.phoneTextField.text.length > 0) {
        client.phone = self.phoneTextField.text;
    } else {
        client.phone = @"";
    }
    
    [[OKDataManager sharedManager] saveContext];
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)actionCancel:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.nameTextField]) {
        [self.phoneTextField becomeFirstResponder];
    } else if ([textField isEqual:self.phoneTextField]) {
        [textField resignFirstResponder];
    } 
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    textField.text = @"";
    return YES;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1 || indexPath.row == 3) {
        return 30.f;
    } else {
        return 44.f;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if ([textField isEqual:self.phoneTextField]) {
        
        NSCharacterSet* validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        NSArray* components = [string componentsSeparatedByCharactersInSet:validationSet];
        
        if (components.count == 1) {
            
            NSString* newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
            NSArray* validComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
            newString = [validComponents componentsJoinedByString:@""];
            
            if (newString.length <= localNumberMaxLenght + areaCodeMaxLenght + countryCodeMaxLenght) {
                
                NSString* resultString = [self formatPhoneNumberWithString:newString];
                textField.text = resultString;
                self.phoneTextField.text = resultString;
                
            }
            
        }
        
        return NO;
    
    } else if ([textField isEqual:self.nameTextField]) {
        
        NSString* validNameCharacters = @" abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
        NSCharacterSet* set = [[NSCharacterSet characterSetWithCharactersInString:validNameCharacters] invertedSet];
        NSArray* components = [string componentsSeparatedByCharactersInSet:set];
        
        if (components.count == 1) {
            
            NSArray* componentsByAt =
            [[textField.text stringByReplacingCharactersInRange:range withString:string] componentsSeparatedByString:@"@"];
            NSString* resultString = [textField.text stringByReplacingCharactersInRange:range withString:string];
            
            if (componentsByAt.count <= 2 && resultString.length <= 30) {
                
                textField.text = resultString;
                self.nameTextField.text = resultString;

            }
            
        }
        
        return NO;
    }
    
    return YES;
}

@end
