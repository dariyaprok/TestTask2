//
//  PDRecipe.h
//  TestTask2
//
//  Created by админ on 10/24/15.
//  Copyright (c) 2015 Dariya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDRecipe : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *publisher;
@property (strong, nonatomic) NSString *ingredients;
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSString *recipeUrl;
@property (strong, nonatomic) NSString *socialRank;
@end
