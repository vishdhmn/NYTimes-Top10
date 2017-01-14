//
//  ViewController.h
//  NYTimes Top10
//
//  Created by vishal dhiman on 14/01/17.
//  Copyright © 2017 vishal dhiman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYArticlesView.h"

@interface ViewController : UIViewController

@property (nonatomic, weak) IBOutlet NYArticlesView *articleView;
@property (weak, nonatomic) IBOutlet UISearchBar *articleSearchBar;


@end

