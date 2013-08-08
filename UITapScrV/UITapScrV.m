//
//  UITapScrV.m
//  xiguateng
//
//  Created by apple on 13-2-20.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "UITapScrV.h"

#define CORNER_RADIUS 10.0f
#define LABEL_MARGIN 5.0f
#define BOTTOM_MARGIN 5.0f
#define FONT_SIZE 13.0f
#define HORIZONTAL_PADDING 7.0f
#define VERTICAL_PADDING 3.0f
#define BACKGROUND_COLOR [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00]
#define TEXT_COLOR [UIColor blackColor]
#define TEXT_SHADOW_COLOR [UIColor whiteColor]
#define TEXT_SHADOW_OFFSET CGSizeMake(0.0f, 1.0f)
#define BORDER_COLOR [UIColor lightGrayColor].CGColor
#define BORDER_WIDTH 1.0f

@implementation UITapScrV

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _textArray=nil;
        // Initialization code
    }
    return self;
}

-(void)dealloc{
    if (_textArray!=nil) {
        [_textArray release];
    }
    [super dealloc];
}

- (void)setTags:(NSArray *)array
{
    _textArray = [[NSMutableArray alloc] initWithArray:array];
    sizeFit = CGSizeZero;
    [self display];
}

- (void)setLabelBackgroundColor:(UIColor *)color
{
    lblBackgroundColor = color;
    [self display];
}



- (void)display
{
    for (UIButton *subview in [self subviews]) {
        [subview removeFromSuperview];
    }
    float totalHeight = 0;
    CGRect previousFrame = CGRectZero;
    BOOL gotPreviousFrame = NO;
    for (int i=0;i<_textArray.count;i++) {
        NSString *text=_textArray[i];
        CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:CGSizeMake(self.frame.size.width, 1500) lineBreakMode:UILineBreakModeWordWrap];
        textSize.width += HORIZONTAL_PADDING*2;
        textSize.height += VERTICAL_PADDING*2;
        UIButton *subBtn = nil;
        if (!gotPreviousFrame) {
            subBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, textSize.width, textSize.height)];
            totalHeight = textSize.height;
        } else {
            CGRect newRect = CGRectZero;
            int num=i;
            while (previousFrame.origin.x + previousFrame.size.width + textSize.width + LABEL_MARGIN > self.frame.size.width||num-1>=(_textArray.count-1)) {
                num++;
                if (num<_textArray.count) {
                    text=_textArray[num];
                    [_textArray exchangeObjectAtIndex:i withObjectAtIndex:num];
                    textSize = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:CGSizeMake(self.frame.size.width, 1500) lineBreakMode:UILineBreakModeWordWrap];
                    textSize.width += HORIZONTAL_PADDING*2;
                    textSize.height += VERTICAL_PADDING*2;
                }
                else{
                    break;
                }
            }
            
            if (previousFrame.origin.x + previousFrame.size.width + textSize.width + LABEL_MARGIN > self.frame.size.width) {
                newRect.origin = CGPointMake(0, previousFrame.origin.y + textSize.height + BOTTOM_MARGIN);
                totalHeight += textSize.height + BOTTOM_MARGIN;
            } else {
                newRect.origin = CGPointMake(previousFrame.origin.x + previousFrame.size.width + LABEL_MARGIN, previousFrame.origin.y);
            }
            newRect.size = textSize;
            subBtn = [[UIButton alloc] initWithFrame:newRect];
        }
        previousFrame = subBtn.frame;
        gotPreviousFrame = YES;
        [subBtn.titleLabel setFont:[UIFont systemFontOfSize:FONT_SIZE]];
        if (!lblBackgroundColor) {
            [subBtn setBackgroundColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.8]];
        } else {
            [subBtn setBackgroundColor:lblBackgroundColor];
        }
        subBtn.tag=1000+i;
        [subBtn setTitleColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1] forState:UIControlStateNormal ];
        [subBtn setTitle:text forState:UIControlStateNormal];
        [subBtn.titleLabel setTextAlignment:UITextAlignmentCenter];
        [subBtn.titleLabel setShadowColor:TEXT_SHADOW_COLOR];
        [subBtn.titleLabel setShadowOffset:TEXT_SHADOW_OFFSET];
        [subBtn.layer setMasksToBounds:YES];
        [subBtn.layer setCornerRadius:CORNER_RADIUS];
        [subBtn addTarget:self action:@selector(subBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [subBtn.layer setBorderColor:BORDER_COLOR];
//        [subBtn.layer setBorderWidth: BORDER_WIDTH];
        [self addSubview:subBtn];
    }
    sizeFit = CGSizeMake(self.frame.size.width, totalHeight + 1.0f);
}

- (CGSize)fittedSize
{
    return sizeFit;
}

-(void)subBtnClick:(UIButton*)sender{
    [_tdelegate didSelectIndex:sender.tag%1000];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
