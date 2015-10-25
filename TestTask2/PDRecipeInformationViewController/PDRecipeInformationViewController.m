//
//  PDRecipeInformationViewController.m
//  TestTask2
//
//  Created by админ on 10/24/15.
//  Copyright (c) 2015 Dariya. All rights reserved.
//

#import "PDRecipeInformationViewController.h"
#import "PDAppManager.h"

@interface PDRecipeInformationViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *recipeImageView;
@property (weak, nonatomic) IBOutlet UITableView *ingredientsTableView;
@property (strong, nonatomic) PDAppManager* appManager;
@end

@implementation PDRecipeInformationViewController

#pragma mark - constatnts
static NSString const *tableViewIngredientsCellIdentifier = @"PDTableViewIngredientsCellIdentifier";

#pragma mark - life cycle methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.recipeImageView.layer.cornerRadius = self.recipeImageView.frame.size.width/2;
    self.recipeImageView.layer.masksToBounds = YES;
    self.appManager = [PDAppManager sharedAppManager];
    self.recipeImageView.image = self.appManager.selectedRecipe.recipeImage;
    self.navigationItem.title = self.appManager.selectedRecipe.title;
    self.ingredientsTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}

#pragma mark - UITableViewDataSource methods
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:tableViewIngredientsCellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewIngredientsCellIdentifier];
    }
    cell.textLabel.text = (NSString*)self.appManager.selectedRecipe.ingredients[indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.appManager.selectedRecipe.ingredients.count;
}
@end
