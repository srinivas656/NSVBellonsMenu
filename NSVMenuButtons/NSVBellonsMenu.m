//
//  NSVBellonsMenu.m
//  NSVMenuButtons
//
//  Created by srinivas on 7/12/16.
//  Copyright © 2016 Microexcel. All rights reserved.
//

#import "NSVBellonsMenu.h"

BOOL isPone ;
@implementation NSVBellonsMenu

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib {
    //[self configureRoot];
    [self defaultvalues];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       // [self configureRoot];
         [self defaultvalues];
    }
    return self;
}

#pragma --mark defaultvalues
// Default values for bellons and bellonsTag , animation etc.


-(void)defaultvalues{
    _bellonTag_y_Padding =20;
    _bellonTag_x_Width = 0.5;
    _shack_speed = 3;
    _bellon_x_Padding = 6;
    _beloonSize = CGSizeMake(50,50);
    Bellon_Tag_color:[UIColor lightGrayColor];
    isPone = NO ;
}

#pragma --mark configureBellons
// This is configure bellon parameters

-(void)configureBellons:(NSMutableArray *)bellons{
    _bellons = bellons ;
    [self addTarget:self action:@selector(rootTouched) forControlEvents:UIControlEventTouchUpInside];
    [self bellonCreations:_bellons];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bellonTapped:)];
    [self.superview addGestureRecognizer:tapGestureRecognizer];
    self.superview.userInteractionEnabled = YES ;
}

#pragma --mark rootTouched
// This is nsv button action method

-(void)rootTouched{
    self.enabled = NO ;
    if (isPone == NO) {
        for (NSMutableDictionary *dict in _bellons) {
            [self createLine:dict];
        }
        isPone = YES ;
        self.enabled = YES ;
    }else{
        for (NSMutableDictionary *dict in _bellons) {
            [self removeBellons:dict];
        }
       [self performSelector:@selector(bellonsRest) withObject:nil afterDelay:3];
        isPone = NO ;
    }
}



#pragma --mark bellonCreations
// This is create the bellons

-(void)bellonCreations:(NSArray *)bellonids{
    
    int xPosition = -100 ;
    int yPostion  = -100 ;
    int i = 0 ;
    for (id dic in bellonids) {
        UIView *_v = [self createBellon:xPosition andYPoint:yPostion andConfigration:dic];
        [dic setObject:_v forKey:@"_view"];
        xPosition = xPosition+100 ;
        if (i == 2) {
            xPosition = -80 ;
            yPostion  = -160 ;
        }else{
       }
        i++;
      }
}

#pragma --mark removeBellons
// This is remove the  bellons

-(void)removeBellons:(NSMutableDictionary *)dict{
    
    UIImageView *_view = [dict valueForKey:@"_view"];
    CAShapeLayer *shapeLayer = [dict valueForKey:@"shapeLayer"];
    CGRect backupFram = CGRectMake(_view.frame.origin.x,_view.frame.origin.y-500,_view.frame.size.width,_view.frame.size.height) ;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3];
    _view.alpha = 0.0;
    _view.frame = backupFram ;
    shapeLayer.strokeColor = (__bridge CGColorRef _Nullable)([UIColor whiteColor]);
    [UIView commitAnimations];
    [shapeLayer removeFromSuperlayer];
    
}

#pragma --mark bellonsRest
// This is reset the  bellons after removing

-(void)bellonsRest{
    for (NSMutableDictionary *dict in _bellons) {
        [[dict valueForKey:@"_view"] removeFromSuperview];
    }
    [self configureBellons:_bellons];
    self.enabled = YES ;
}


-(UIView *)createBellon:(float)xPoint andYPoint:(float)yPoint andConfigration:(id)conView {
    
    UIImageView * view = [[UIImageView alloc] initWithFrame:CGRectMake(xPoint,yPoint,_beloonSize.width,_beloonSize.height)];
    view.backgroundColor = [UIColor clearColor];
    view.layer.cornerRadius = view.frame.size.width/2;
    UIImage *conImag = [self mergeBackImage:[self imageFromColor:[conView valueForKey:_bellon_color_key] withFrame:CGRectMake(0, 0, _beloonSize.width,_beloonSize.height)] withFrontImage:[UIImage imageNamed:[conView valueForKey:_bellon_img_key]]];
    view.image =[self maskImage:conImag withMask:[UIImage imageNamed:@"Balloon03.png"]] ;
    view.layer.name = [NSString stringWithFormat:@"%lu",(unsigned long)[_bellons indexOfObject:conView]+1] ;
    [self addSubview:view];
     view.alpha = 0;
    
    //create an animation to follow a circular path
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //interpolate the movement to be more smooth
    pathAnimation.calculationMode = kCAAnimationPaced;
    //apply transformation at the end of animation (not really needed since it runs forever)
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    //run forever
    pathAnimation.repeatCount = INFINITY;
    //no ease in/out to have the same speed along the path
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.duration = _shack_speed;
    
    //The circle to follow will be inside the circleContainer frame.
    //it should be a frame around the center of your view to animate.
    //do not make it to large, a width/height of 3-4 will be enough.
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGRect circleContainer = CGRectInset(view.frame, 23, 23);
    CGPathAddEllipseInRect(curvedPath, NULL, circleContainer);
    
    //add the path to the animation
    pathAnimation.path = curvedPath;
    //release path
    CGPathRelease(curvedPath);
    //add animation to the view's layer
    [view.layer addAnimation:pathAnimation forKey:@"myCircleAnimation"];
    
    
    //create an animation to scale the width of the view
    CAKeyframeAnimation *scaleX = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
    //set the duration
    scaleX.duration = _shack_speed;
    //it starts from scale factor 1, scales to 1.05 and back to 1
    scaleX.values = @[@1.0, @1.05, @1.0];
    //time percentage when the values above will be reached.
    //i.e. 1.05 will be reached just as half the duration has passed.
    scaleX.keyTimes = @[@0.0, @0.5, @1.0];
    //keep repeating
    scaleX.repeatCount = INFINITY;
    //play animation backwards on repeat (not really needed since it scales back to 1)
    scaleX.autoreverses = YES;
    //ease in/out animation for more natural look
    scaleX.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //add the animation to the view's layer
    [view.layer addAnimation:scaleX forKey:@"scaleXAnimation"];
    
    //create the height-scale animation just like the width one above
    //but slightly increased duration so they will not animate synchronously
    CAKeyframeAnimation *scaleY = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
    scaleY.duration = _shack_speed;
    scaleY.values = @[@1.0, @1.05, @1.0];
    scaleY.keyTimes = @[@0.0, @0.5, @1.0];
    scaleY.repeatCount = INFINITY;
    scaleY.autoreverses = YES;
    scaleX.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:scaleY forKey:@"scaleYAnimation"];
    
    return view ;
    
  }

-(void)presentBellonAnimatio:(CAShapeLayer *)shapeLayer andView:(UIImageView *)view{
    //Animate path
    CABasicAnimation *thAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    thAnimation.duration = 1.5f;
    thAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    thAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [shapeLayer addAnimation:thAnimation forKey:@"strokeEnd"];
    
    //Animate colorFill
    CABasicAnimation *fillColorAnimation = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    fillColorAnimation.duration = 1.5f;
    fillColorAnimation.fromValue = (id)[[UIColor clearColor] CGColor];
    fillColorAnimation.toValue = (id)[[UIColor yellowColor] CGColor];
    [shapeLayer addAnimation:fillColorAnimation forKey:@"fillColor"];
    [self performSelector:@selector(doviewAnimation:) withObject:view afterDelay:1.5];
}


#pragma --mark BELLON_TAG METHODS

-(void)createLine:(NSMutableDictionary *)dict{
    
    UIImageView *view = [dict valueForKey:@"_view"] ;
    
    CGPoint basePoint = CGPointMake(self.bounds.origin.x+self.bounds.size.width/2+_bellonTag_x_Padding,self.bounds.origin.y+self.bounds.size.height/2+_bellonTag_y_Padding);
    CGPoint bellonPoint = CGPointMake((view.frame.origin.x+view.frame.size.width/2)+_bellon_x_Padding,view.frame.origin.y+view.frame.size.height+_bellon_y_Padding);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:basePoint];
    [path addLineToPoint:bellonPoint];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = _bellon_Tag_color.CGColor;
    shapeLayer.lineWidth = _bellonTag_x_Width;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    [self.layer addSublayer:shapeLayer];
    [self presentBellonAnimatio:shapeLayer andView:view];
    
    CAKeyframeAnimation *scaleY = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
    scaleY.duration = _shack_speed;
    scaleY.values = @[@1.0, @1.05, @1.0];
    scaleY.keyTimes = @[@0.0, @0.5, @1.0];
    scaleY.repeatCount = INFINITY;
    scaleY.autoreverses = YES;
    [shapeLayer addAnimation:scaleY forKey:@"scaleYAnimation"];
    
    [dict setObject:shapeLayer forKey:@"shapeLayer"];
    
}

#pragma --mark BELLON_ANIMATION METHODS

-(void)doviewAnimation:(UIImageView *)vi{
    
    CGRect backupFram = vi.frame ;
    vi.frame = CGRectMake((vi.frame.origin.x+vi.frame.size.width/2)+10,vi.frame.origin.y+vi.frame.size.height-5,0, 0) ;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.5f];
    vi.alpha = 1;
    vi.frame = backupFram ;
    [UIView commitAnimations];
}

#pragma --mark IMAGE METHODS

- (UIImage *)imageFromColor:(UIColor *)color withFrame:(CGRect)rect {
    if (color == nil) {
        color = [UIColor redColor];
    }
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image ;
}

- (UIImage *)mergeBackImage:(UIImage *)backImage withFrontImage:(UIImage *)frontImage
{
    UIImage *newImage;
    CGRect rect = CGRectMake(0, 0, backImage.size.width, backImage.size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [backImage drawInRect:rect];
    [frontImage drawInRect:rect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage*)maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGImageRef maskImageRef = [maskImage CGImage];
    
    // create a bitmap graphics context the size of the image
    CGContextRef mainViewContentContext = CGBitmapContextCreate (NULL, maskImage.size.width, maskImage.size.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colorSpace);
    
    if (mainViewContentContext==NULL)
        return NULL;
    
    CGFloat ratio = 0;
    ratio = maskImage.size.width/ image.size.width;
    
    if(ratio * image.size.height < maskImage.size.height) {
        ratio = maskImage.size.height/ image.size.height;
    }
    
    CGRect rect1  = {{0, 0}, {maskImage.size.width, maskImage.size.height}};
    CGRect rect2  = {{-((image.size.width*ratio)-maskImage.size.width)/2 , -((image.size.height*ratio)-maskImage.size.height)/2}, {image.size.width*ratio, image.size.height*ratio}};
    
    CGContextClipToMask(mainViewContentContext, rect1, maskImageRef);
    CGContextDrawImage(mainViewContentContext, rect2, image.CGImage);
    
    // Create CGImageRef of the main view bitmap content, and then
    // release that bitmap context
    CGImageRef newImage = CGBitmapContextCreateImage(mainViewContentContext);
    CGContextRelease(mainViewContentContext);
    UIImage *theImage = [UIImage imageWithCGImage:newImage];
    CGImageRelease(newImage);
    // return the image
    return theImage;
}


#pragma --mark BELLON ACTION METHODS

- (IBAction)bellonTapped:(id)sender
{
    CALayer *tappedbellon;
    UITapGestureRecognizer *theTapper = (UITapGestureRecognizer *)sender;
    CGPoint touchPoint = [theTapper locationInView:self.superview];
    tappedbellon = [self.superview.layer.presentationLayer hitTest:touchPoint];
    
    if (tappedbellon.name != nil)  {
        UIImageView *_view = [[_bellons objectAtIndex:[tappedbellon.name integerValue]-1] valueForKey:@"_view"];
        
        CGRect backupFram = CGRectMake(_view.frame.origin.x,_view.frame.origin.y-500,_view.frame.size.width,_view.frame.size.height) ;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:3];
        _view.alpha = 0.0;
        _view.frame = backupFram ;
        [UIView commitAnimations];
        
        [_delegate didTouchedBellon:[_bellons objectAtIndex:[tappedbellon.name integerValue]-1] andBellonTag:[tappedbellon.name intValue]-1];
        NSLog(@"%@",[_bellons objectAtIndex:[tappedbellon.name integerValue]-1]);
       // [self.currentShapeLayer removeFromSuperlayer];

    }
    
}

@end
