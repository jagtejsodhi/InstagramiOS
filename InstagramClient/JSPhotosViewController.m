//
//  JSPhotosViewController.m
//  InstagramClient
//
//  Created by Jagtej Sodhi on 9/14/15.
//  Copyright (c) 2015 Jagtej Sodhi. All rights reserved.
//

#import "JSPhotosViewController.h"
#import "JSCustomTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "JSPhotoDetailsViewController.h"

@interface JSPhotosViewController ()
@property (nonatomic) NSDictionary *responseDictionary;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation JSPhotosViewController
@synthesize responseDictionary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.myCustomTableView insertSubview:self.refreshControl atIndex:0];
    
    NSURL *url = [NSURL URLWithString:@"https://api.instagram.com/v1/media/popular?client_id=14b7ebe3f3474f8096f1057ada6556b6"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        [self.myCustomTableView reloadData];
        
        //[self printDictionary:responseDictionary];
    }];
    
    
    self.myCustomTableView.dataSource = self;
    self.myCustomTableView.delegate = self;
    self.myCustomTableView.rowHeight = 320;
}

- (void)onRefresh {
    NSURL *url = [NSURL URLWithString:@"https://api.instagram.com/v1/media/popular?client_id=14b7ebe3f3474f8096f1057ada6556b6"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        [self.myCustomTableView reloadData];
        
        [self.refreshControl endRefreshing];
    }];
}

- (void)printDictionary:(NSDictionary*)dictionary
{
    NSLog(@"response: %@", dictionary);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - table view methods
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JSCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"com.jagtej.sodhi.firstcellview" forIndexPath:indexPath];
        
    NSString* urlString = responseDictionary[@"data"][indexPath.row][@"images"][@"standard_resolution"][@"url"];
    NSURL* url = [NSURL URLWithString:urlString];
    
    [cell.myCustomImageView setImageWithURL:url];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    JSPhotoDetailsViewController* photoDetailsViewController = [segue destinationViewController];
    NSIndexPath* indexPath = [self.myCustomTableView indexPathForCell:sender];
        
    photoDetailsViewController.dictionary = responseDictionary[@"data"][indexPath.row][@"images"][@"standard_resolution"];
    
     //Get the new view controller using [segue destinationViewController].
     //Pass the selected object to the new view controller.
}


@end
