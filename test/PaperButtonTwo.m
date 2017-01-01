//
//  PaperButton.m
//  Popping
//
//  Created by André Schneider on 12.05.14.
//  Copyright (c) 2014 André Schneider. All rights reserved.
//

#import "PaperButtonTwo.h"
#import "POP/POP.h"

@interface PaperButtonTwo()
@property(nonatomic) CALayer *topLayer;

@property(nonatomic) CALayer *bottomLayer;
@property(nonatomic) BOOL showMenu;

- (void)touchUpInsideHandler:(PaperButtonTwo *)sender;
- (void)animateToMenu;
- (void)animateToClose;
- (void)setup;
- (void)removeAllAnimations;
@end

@implementation PaperButtonTwo

+ (instancetype)button
{
    return [self buttonWithOrigin:CGPointZero];
}

+ (instancetype)buttonWithOrigin:(CGPoint)origin
{
    return [[self alloc] initWithFrame:CGRectMake(origin.x,
                                                  origin.y,
                                                  24,
                                                  17)];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - Instance methods

- (void)tintColorDidChange
{
    CGColorRef color = [self.tintColor CGColor];
    self.topLayer.backgroundColor = color;

    self.bottomLayer.backgroundColor = color;
}

#pragma mark - Private Instance methods

- (void)animateToMenu
{
    [self removeAllAnimations];

    CGFloat height = CGRectGetHeight(self.topLayer.bounds);

   

    POPBasicAnimation *positionTopAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionTopAnimation.duration = 0.3;
    positionTopAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.bounds),
                                                                         roundf(CGRectGetMinY(self.bounds)+(4.5*height)))];

    POPBasicAnimation *positionBottomAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionTopAnimation.duration = 0.3;
    positionBottomAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.bounds),
                                                                            roundf(CGRectGetMaxY(self.bounds) - 4*height))];

    POPSpringAnimation *transformTopAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    transformTopAnimation.toValue = @(-1.55);
    transformTopAnimation.springBounciness = 20.f;
    transformTopAnimation.springSpeed = 20;
    transformTopAnimation.dynamicsTension = 1000;

    POPSpringAnimation *transformBottomAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    transformBottomAnimation.toValue = @(0);
    transformBottomAnimation.springBounciness = 20.0f;
    transformBottomAnimation.springSpeed = 20;
    transformBottomAnimation.dynamicsTension = 1000;

    [self.topLayer pop_addAnimation:positionTopAnimation forKey:@"positionTopAnimation"];
    [self.topLayer pop_addAnimation:transformTopAnimation forKey:@"rotateTopAnimation"];

    [self.bottomLayer pop_addAnimation:positionBottomAnimation forKey:@"positionBottomAnimation"];
    [self.bottomLayer pop_addAnimation:transformBottomAnimation forKey:@"rotateBottomAnimation"];
}

- (void)animateToClose
{
    [self removeAllAnimations];
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));


    POPBasicAnimation *positionTopAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionTopAnimation.toValue = [NSValue valueWithCGPoint:center];
    positionTopAnimation.duration = 0.3;

    POPBasicAnimation *positionBottomAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionBottomAnimation.toValue = [NSValue valueWithCGPoint:center];
    positionTopAnimation.duration = 0.3;

    POPSpringAnimation *transformTopAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    transformTopAnimation.toValue = @(M_PI_4);
    transformTopAnimation.springBounciness = 20.f;
    transformTopAnimation.springSpeed = 20;
    transformTopAnimation.dynamicsTension = 1000;

    POPSpringAnimation *transformBottomAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    transformBottomAnimation.toValue = @(-M_PI_4);
    transformBottomAnimation.springBounciness = 20.0f;
    transformBottomAnimation.springSpeed = 20;
    transformBottomAnimation.dynamicsTension = 1000;

    [self.topLayer pop_addAnimation:positionTopAnimation forKey:@"positionTopAnimation"];
    [self.topLayer pop_addAnimation:transformTopAnimation forKey:@"rotateTopAnimation"];
    
    [self.bottomLayer pop_addAnimation:positionBottomAnimation forKey:@"positionBottomAnimation"];
    [self.bottomLayer pop_addAnimation:transformBottomAnimation forKey:@"rotateBottomAnimation"];
}

- (void)touchUpInsideHandler:(PaperButtonTwo *)sender
{
    if (self.showMenu) {
        [self animateToMenu];
    } else {
        [self animateToClose];
    }
    self.showMenu = !self.showMenu;
}

- (void)setup
{
    CGFloat height = 2.f;
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat cornerRadius =  1.f;
    CGColorRef color = [self.tintColor CGColor];

    self.topLayer = [CALayer layer];
    self.topLayer.frame = CGRectMake(0, CGRectGetMidY(self.bounds)-(height/2), width, height);
    self.topLayer.cornerRadius = cornerRadius;
    self.topLayer.backgroundColor = color;
    self.topLayer.transform = CATransform3DMakeRotation(80.09, 0, 0, 0.9);

  

    self.bottomLayer = [CALayer layer];
    self.bottomLayer.frame =CGRectMake(0, CGRectGetMidY(self.bounds)-(height/2), width, height);;
    self.bottomLayer.cornerRadius = cornerRadius;
    self.bottomLayer.backgroundColor = color;

    [self.layer addSublayer:self.topLayer];

    [self.layer addSublayer:self.bottomLayer];

    [self addTarget:self
             action:@selector(touchUpInsideHandler:)
   forControlEvents:UIControlEventTouchUpInside];
}

- (void)removeAllAnimations
{
    [self.topLayer pop_removeAllAnimations];

    [self.bottomLayer pop_removeAllAnimations];
}



@end
