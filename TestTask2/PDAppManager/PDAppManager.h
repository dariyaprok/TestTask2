//
//  PDAppManager.h
//  TestTask2
//
//  Created by админ on 10/24/15.
//  Copyright (c) 2015 Dariya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDRecipe.h"

@protocol PDAppManagerDelegate

@optional
-(void)recipesLoadedSuccess;
-(void)recipeGetSuccess;

@end



@interface PDAppManager : NSObject

@property (nonatomic, strong) NSMutableArray *arrayOfRecipes;
@property (nonatomic, weak) id<PDAppManagerDelegate> delegate;
@property (nonatomic, strong) NSString *sortedMode;
@property (nonatomic, strong) PDRecipe *selectedRecipe;
@property NSInteger indexOfSelectedObject;
@property NSInteger page;
@property BOOL isSearchMode;

+ (instancetype)sharedAppManager;
- (void)getAllRecipes;
- (void)getRecipeAtIndex: (NSInteger)index;
- (void)searchRecipesWithSerachKey: (NSString*)searchKey;

@end
