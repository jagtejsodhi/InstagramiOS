//
//  JSPhotoDetailsViewController.m
//  InstagramClient
//
//  Created by Jagtej Sodhi on 9/14/15.
//  Copyright © 2015 Jagtej Sodhi. All rights reserved.
//

#import "JSPhotoDetailsViewController.h"
#import "JSDetailsTableViewCell.h"
#import "UIImageView+AFNetworking.h"


@interface JSPhotoDetailsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *detailsTableView;


@end

@implementation JSPhotoDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Details Controller: %@", self.dictionary);
    
    self.detailsTableView.dataSource = self;
    self.detailsTableView.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JSDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"com.jagtej.sodhi.detailsviewcell" forIndexPath:indexPath];
    
    NSString* urlString = self.dictionary[@"url"];
    NSURL* url = [NSURL URLWithString:urlString];
    
    [cell.detailsImageView setImageWithURL:url];
    
    return cell;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
