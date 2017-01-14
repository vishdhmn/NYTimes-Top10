//
//  NYArticlesView.m
//  NYTimes Top10
//
//  Created by vishal dhiman on 14/01/17.
//  Copyright © 2017 vishal dhiman. All rights reserved.
//

#import "NYArticlesView.h"
#import "DataModels.h"

@interface NYArticlesView ()

@property (nonatomic, strong) NSArray *articlesArray;

@end

@implementation NYArticlesView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)initialize
{
    self.articlesArray = [[NSArray alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if(self)
    {
        [self initialize];
    }
    
    return self;
}


#pragma mark - CollectionView
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.row < self.articlesArray.count) {
        NYArticleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"articleCell" forIndexPath:indexPath];
        NYResults *currentArticle = [self.articlesArray objectAtIndex:indexPath.row];
        [cell configureForArticle:currentArticle];
        return cell;
    }
    
    NYArticleLoadingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"loadingCell" forIndexPath:indexPath];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [self getSizeForCellAtIndexPath:indexPath];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeZero;
}

#pragma mark - UICollectionViewDelegate
#pragma mark To do: Add did select methods definition.
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //NYResults *currentArticle = [self.articlesArray objectAtIndex:indexPath.row];
    // ** may be show details page for article**
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    self.articlesArray = [[NSArray alloc] init];
    
    return self.articlesArray.count + 1;
}

-(CGSize)getSizeForCellAtIndexPath:(NSIndexPath*)indexPath{
    
    CGFloat cellWidth = self.articlesCollection.frame.size.width;
    CGFloat width = cellWidth - 20;
    
    NYResults *currentArticle = [self.articlesArray objectAtIndex:indexPath.row];
    
    CGSize constrain = CGSizeMake(width, CGFLOAT_MAX);
    CGFloat height = [currentArticle.abstract boundingRectWithSize:constrain options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
    
    //add image size, title size and date size.
    
    CGSize size = CGSizeMake(width, (width*2.0/3.0) + 78 + height - 18);
    return size;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


@end
