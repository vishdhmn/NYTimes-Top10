//
//  NYArticleLoadingCell.h
//  NYTimes Top10
//
//  Created by vishal dhiman on 14/01/17.
//  Copyright © 2017 vishal dhiman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NYArticleLoadingCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingActivity;


@end
