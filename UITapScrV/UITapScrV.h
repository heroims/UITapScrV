//
//  UITapScrV.h
//  xiguateng
//
//  Created by apple on 13-2-20.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol UITapDelegate <NSObject>

-(void)didSelectIndex:(int)index;

@end

@interface UITapScrV : UIScrollView{
    CGSize sizeFit;
    UIColor *lblBackgroundColor;
}

@property (nonatomic, retain) NSMutableArray *textArray;
@property (nonatomic, assign)id<UITapDelegate> tdelegate;

- (void)setLabelBackgroundColor:(UIColor *)color;
- (void)setTags:(NSArray *)array;
- (void)display;
- (CGSize)fittedSize;

@end
