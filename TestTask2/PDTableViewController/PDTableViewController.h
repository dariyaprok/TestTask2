//
//  PDTableViewController.h
//  TestTask2
//
//  Created by админ on 10/24/15.
//  Copyright (c) 2015 Dariya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "PDAppManager.h"

@interface PDTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, PDAppManagerDelegate, UITextFieldDelegate>

@end
