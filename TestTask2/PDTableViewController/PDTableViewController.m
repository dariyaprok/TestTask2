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
@property (weak, nonatomic) IBOutlet UISegmentedControl *sortedSegmantBarButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

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
    [self.activityIndicator startAnimating];
    self.activityIndicator.hidden = NO;
    self.view.alpha = 0.5;
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

-(void)allRecipesLoadedSuccess{
    if(self.appManger.isSearchMode == YES){
        self.appManger.sortedMode = @"r";
        self.sortedSegmantBarButton.selectedSegmentIndex = 1;
    }
    if(self.appManger.arrayOfRecipes.count == 0){
        [self.recipeTableView reloadData];
    }
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
    self.view.alpha = 1.0;
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    self.appManger.page =1;
    [self.activityIndicator startAnimating];
    self.activityIndicator.hidden = NO;
    self.view.alpha = 0.5;
    [self.appManger searchRecipesWithSerachKey:textField.text];
    self.searchTextField.hidden = YES;
    return YES;
}

#pragma mark - IBAction methods
- (IBAction)searchBarButtonPressed:(id)sender {
    if(self.appManger.isSearchMode == NO){
        self.sortedSegmantBarButton.hidden = YES;
        self.searchBarButton.title = @"Skip";
        self.searchTextField.hidden = NO;
        [self.view setAlpha:0.5];
    }
    else{
        //[self.view setAlpha:1.0];
        self.sortedSegmantBarButton.hidden = NO;
        self.searchBarButton.title = @"Search";
        self.searchTextField.hidden = YES;
        self.appManger.page =1;
        [self.activityIndicator startAnimating];
        self.activityIndicator.hidden = NO;
        self.view.alpha = 0.5;
        [self.appManger getAllRecipes];
    }
}
- (IBAction)sortBarButtonPressed:(UISegmentedControl*)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.appManger.sortedMode = @"t";
            break;
        case 1:
            self.appManger.sortedMode = @"r";
            break;
    }
    self.appManger.page = 1;
    [self.activityIndicator startAnimating];
    self.activityIndicator.hidden = NO;
    self.view.alpha = 0.5;
    [self.appManger getAllRecipes];
}


@end
