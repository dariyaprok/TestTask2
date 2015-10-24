//
//  PDTableViewController.m
//  TestTask2
//
//  Created by админ on 10/24/15.
//  Copyright (c) 2015 Dariya. All rights reserved.
//

#import "PDTableViewController.h"
#import "PDCustomTableViewCell.h"
#import "PDRecipe.h"

@interface PDTableViewController()

@property (weak, nonatomic) IBOutlet UITableView *recipeTableView;
@property (strong, nonatomic) PDAppManager *appManger;
@end

@implementation PDTableViewController

#pragma mark - constants
const NSString static *customTableViewCell = @"PDCustomTableViewCell";

#pragma mark - life cycle methods
-(void)viewDidLoad {
    self.appManger =  [PDAppManager sharedAppManager];
    self.appManger.delegate = self;
    [self.appManger getAllRecipes];
}


#pragma mark - UITableViewDelegate methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDCustomTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:customTableViewCell];
    if (!cell) {
        NSArray* nibFileObjects = [[NSBundle mainBundle] loadNibNamed:customTableViewCell owner:self options:nil];
        cell = [nibFileObjects objectAtIndex:0];
    }
    [cell.recipeImageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:((PDRecipe*)self.appManger.arrayOfRecipes[indexPath.row]).imageUrl]]]];
    cell.recipeNameLabel.text = ((PDRecipe*)self.appManger.arrayOfRecipes[indexPath.row]).title;
    cell.publisherLabel.text = ((PDRecipe*)self.appManger.arrayOfRecipes[indexPath.row]).publisher;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.appManger.arrayOfRecipes.count;
}

#pragma mark - PDAppManagerDelegate methods
- (void)recipesLoadedSuccess{
    [self.recipeTableView reloadData];
}
@end
