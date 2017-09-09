//
//  OKNoteTableViewCell.h
//  DiaryOfServices
//
//  Created by Oleksandr Kurtsev on 07.09.17.
//  Copyright © 2017 Oleksandr Kurtsev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKNoteTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameClientLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameNoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
