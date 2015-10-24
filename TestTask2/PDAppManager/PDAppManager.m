//
//  PDAppManager.m
//  TestTask2
//
//  Created by админ on 10/24/15.
//  Copyright (c) 2015 Dariya. All rights reserved.
//

#import "PDAppManager.h"
#import <AFNetworking/AFHTTPRequestOperation.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>
@interface PDAppManager ()

@property (nonatomic, strong) AFHTTPRequestOperationManager* operationManager;
@end

@implementation PDAppManager

//static NSNum page = 1;

#pragma mark - constants
static NSString const *APIKey = @"4e55e5de8033fa5b384228ae21b7d2cd";
static NSString const *APISearchMethod = @"http://food2fork.com/api/search";
static NSString const *APIGetMethod = @"http://food2fork.com/api/get";

+ (instancetype)sharedAppManager {
    static dispatch_once_t token;
    static PDAppManager *sharedAppManager;
    dispatch_once(&token, ^{
        sharedAppManager = [PDAppManager new];
    });
    return sharedAppManager;
}

-(instancetype)init {
    self = [super init];
    if(self) {
        self.operationManager = [AFHTTPRequestOperationManager manager];
        self.page = 1;
        self.sortedMode = @"t";
    }
    return self;
}

- (void)getAllRecipes {
    if(self.page == 1 && self.arrayOfRecipes){
        [self.arrayOfRecipes removeAllObjects];
    }
    if(!self.arrayOfRecipes){
        self.arrayOfRecipes = [[NSMutableArray alloc] init];
    }
    NSDictionary *parameters = @{@"key":APIKey, @"sort":self.sortedMode, @"page":[NSNumber numberWithInt:self.page]};
    [self.operationManager GET:APISearchMethod parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger am =(NSInteger)[responseObject objectForKey:@"count"];
        for(id obj in [responseObject objectForKey:@"recipes"]) {
            PDRecipe *newRecipe = [PDRecipe new];
            newRecipe.recipeId = [obj objectForKey:@"recipe_id"];
            newRecipe.imageUrl = [obj objectForKey:@"image_url"];
            newRecipe.publisher = [obj objectForKey:@"publisher"];
            newRecipe.title = [obj objectForKey:@"title"];
            [self.arrayOfRecipes addObject:newRecipe];
        }
        [self.delegate recipesLoadedSuccess];
        NSLog(@"%@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

- (void)getRecipeAtIndex: (NSInteger)index {
    self.selectedRecipe = self.arrayOfRecipes[index];
    if(!self.selectedRecipe.ingredients){
    NSDictionary *parameters = @{@"key":APIKey, @"rId":self.selectedRecipe.recipeId};
    [self.operationManager GET:APIGetMethod parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.selectedRecipe.ingredients = [NSArray arrayWithArray:[[responseObject objectForKey:@"recipe"] objectForKey: @"ingredients"]];
        [self.delegate recipeGetSuccess];
        NSLog(@"%@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    }
    else {
        [self.delegate recipeGetSuccess];
    }
}
@end
