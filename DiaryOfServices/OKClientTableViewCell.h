//
//  OKClientTableViewCell.h
//  DiaryOfServices
//
//  Created by Oleksandr Kurtsev on 06.09.17.
//  Copyright © 2017 Oleksandr Kurtsev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKClientTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end
