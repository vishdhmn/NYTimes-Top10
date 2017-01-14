//
//  NYArticlesView.h
//  NYTimes Top10
//
//  Created by vishal dhiman on 14/01/17.
//  Copyright © 2017 vishal dhiman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYArticlesCollectionView.h"

@interface NYArticlesView : UIView <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet NYArticlesCollectionView *articlesCollection;

@end
