//
//  JSPhotosViewController.h
//  InstagramClient
//
//  Created by Jagtej Sodhi on 9/14/15.
//  Copyright (c) 2015 Jagtej Sodhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSPhotosViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myCustomTableView;

- (void)printDictionary:(NSDictionary*)dictionary;

@end
