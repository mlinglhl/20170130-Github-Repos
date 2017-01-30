//
//  RepoCell.m
//  20170130 Github Repos
//
//  Created by Minhung Ling on 2017-01-30.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

#import "RepoCell.h"

@interface RepoCell ()
@property (weak, nonatomic) IBOutlet UILabel *repoName;
@property (weak, nonatomic) IBOutlet UILabel *repoURL;

@end

@implementation RepoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setRepo:(Repo *)repo {
    _repo = repo;
    self.repoName.text = repo.name;
    self.repoURL.text = repo.html;
}

@end
