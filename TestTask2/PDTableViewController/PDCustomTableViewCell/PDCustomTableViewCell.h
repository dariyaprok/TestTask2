//
//  PDCustomTableViewCell.h
//  TestTask2
//
//  Created by админ on 10/24/15.
//  Copyright (c) 2015 Dariya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDCustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *recipeImageView;
@property (weak, nonatomic) IBOutlet UILabel *recipeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *publisherLabel;

@end
