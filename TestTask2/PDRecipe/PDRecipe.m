//
//  PDRecipe.m
//  TestTask2
//
//  Created by админ on 10/24/15.
//  Copyright (c) 2015 Dariya. All rights reserved.
//

#import "PDRecipe.h"

@implementation PDRecipe


-(UIImage*)recipeImage{
    if(!_recipeImage){
        _recipeImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageUrl]]];
    }
    return _recipeImage;
}
@end
