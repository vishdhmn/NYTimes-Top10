//
//  NYArticleCell.h
//  NYTimes Top10
//
//  Created by vishal dhiman on 14/01/17.
//  Copyright © 2017 vishal dhiman. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NYResults;

@interface NYArticleCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *abstractLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

-(void) configureForArticle:(NYResults*)article;

@end
