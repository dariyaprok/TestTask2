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

@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchBarButton;
@property (weak, nonatomic) IBOutlet UITableView *recipeTableView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (strong, nonatomic) PDAppManager *appManger;
@end

@implementation PDTableViewController

#pragma mark - constants
const NSString static *customTableViewCell = @"PDCustomTableViewCell";
const NSString static *pushRecipeInformationViewControllerSegue = @"PDPushRecipeInformationViewControllerSegue";

#pragma mark - life cycle methods
-(void)viewDidLoad {
    [super viewDidLoad];
    self.appManger =  [PDAppManager sharedAppManager];
    self.appManger.delegate = self;
    [self.appManger getAllRecipes];
    self.searchTextField.delegate = self;
}


#pragma mark - UITableViewDataSource methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDCustomTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:customTableViewCell];
    if (!cell) {
        NSArray* nibFileObjects = [[NSBundle mainBundle] loadNibNamed:customTableViewCell owner:self options:nil];
        cell = [nibFileObjects objectAtIndex:0];
    }
    [cell.recipeImageView setImage:((PDRecipe*)self.appManger.arrayOfRecipes[indexPath.row]).recipeImage];
    cell.recipeNameLabel.text = ((PDRecipe*)self.appManger.arrayOfRecipes[indexPath.row]).title;
    cell.publisherLabel.text = ((PDRecipe*)self.appManger.arrayOfRecipes[indexPath.row]).publisher;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.appManger.arrayOfRecipes.count;
}

#pragma mark - UITableViewDelegate methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.appManger.indexOfSelectedObject = indexPath.row;
    [self.appManger getRecipeAtIndex:indexPath.row];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == self.appManger.arrayOfRecipes.count-1) {
        self.appManger.page ++;
        if(self.appManger.isSearchMode == NO){
            [self.appManger getAllRecipes];
        }
        else{
            [self.appManger searchRecipesWithSerachKey:self.searchTextField.text];
        }
    }
}

#pragma mark - PDAppManagerDelegate methods
- (void)recipesLoadedSuccess{
    [self.recipeTableView reloadData];
}

-(void)recipeGetSuccess{
    [self performSegueWithIdentifier:pushRecipeInformationViewControllerSegue sender:self];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    self.appManger.page =1;
    [self.appManger searchRecipesWithSerachKey:textField.text];
    [self.view setAlpha:1.0];
    self.searchTextField.hidden = YES;
    return YES;
}

#pragma mark - IBAction methods
- (IBAction)searchBarButtonPressed:(id)sender {
    if(self.appManger.isSearchMode == NO){
        self.searchBarButton.title = @"Skip";
        self.searchTextField.hidden = NO;
        [self.view setAlpha:0.5];
    }
    else{
        [self.view setAlpha:1.0];
        self.searchBarButton.title = @"Search";
        self.searchTextField.hidden = YES;
        self.appManger.page =1;
        [self.appManger getAllRecipes];
    }
}

@end
