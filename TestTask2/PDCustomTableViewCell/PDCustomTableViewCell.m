//
//  PDCustomTableViewCell.m
//  TestTask2
//
//  Created by админ on 10/24/15.
//  Copyright (c) 2015 Dariya. All rights reserved.
//

#import "PDCustomTableViewCell.h"

@implementation PDCustomTableViewCell


-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.recipeImageView.layer.cornerRadius = self.recipeImageView.frame.size.width/2;
    self.recipeImageView.layer.masksToBounds = YES;
}
@end
