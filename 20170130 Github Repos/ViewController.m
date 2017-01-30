//
//  ViewController.m
//  20170130 Github Repos
//
//  Created by Minhung Ling on 2017-01-30.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

#import "ViewController.h"
#import "Repo.h"
#import "RepoCell.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *repoTableView;
@property NSMutableArray <Repo *> *repoArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.repoArray = [NSMutableArray new];
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/users/mlinglhl/repos"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSArray *repos = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            NSLog(@"jsonerror:%@", jsonError.localizedDescription);
            return;
        }
        for (NSDictionary *repo in repos) {
            Repo *repoObject = [Repo new];
            repoObject.name = repo[@"name"];
            repoObject.html = repo[@"html_url"];
            [self.repoArray addObject:repoObject];
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.repoTableView reloadData];
        }];
    }];
    
    [dataTask resume];
    // Do any additional setup after loading the view, typically from a nib.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.repoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RepoCell *cell = [self.repoTableView dequeueReusableCellWithIdentifier:@"repoCell"];
    cell.repo = self.repoArray[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
