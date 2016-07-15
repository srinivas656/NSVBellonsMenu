//
//  NSVBellonsMenu.h
//  NSVMenuButtons
//
//  Created by srinivas on 7/12/16.
//  Copyright © 2016 Microexcel. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NSVBellonDelegate <NSObject>

-(void)didTouchedBellon:(id)dict andBellonTag:(int)bellontag ;

@end

@interface NSVBellonsMenu : UIButton
@property(nonatomic,weak)id <NSVBellonDelegate>delegate ;
@property(nonatomic,strong)NSMutableArray *bellons ;
@property(nonatomic,strong)NSString *bellon_img_key ;
@property(nonatomic,strong)NSString *bellon_color_key ;
@property(nonatomic,strong)UIColor *bellon_Tag_color ;

@property (nonatomic)CGSize beloonSize ;
@property(nonatomic)float shack_speed ;
@property(nonatomic)float bellonTag_x_Width ;
@property(nonatomic)float bellonTag_x_Padding ;
@property(nonatomic)float bellonTag_y_Padding ;
@property(nonatomic)float bellon_x_Padding;
@property(nonatomic)float bellon_y_Padding;


-(void)configureBellons:(NSMutableArray *)bellons ;

@end
