//
//  ViewController.m
//  NSVMenuButtons
//
//  Created by srinivas on 7/12/16.
//  Copyright © 2016 Microexcel. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSVBellonDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray *bellonsArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *dict  = [[NSMutableDictionary alloc] init];
    [dict setObject:@"one.png" forKey:@"img"];
    [dict setObject:[UIColor redColor] forKey:@"color"];
    [bellonsArray addObject:dict];
    dict  = [[NSMutableDictionary alloc] init];
    [dict setObject:@"two.png" forKey:@"img"];
    [dict setObject:[UIColor cyanColor] forKey:@"color"];
    [bellonsArray addObject:dict];
    dict  = [[NSMutableDictionary alloc] init];
    [dict setObject:@"Three.png" forKey:@"img"];
    [dict setObject:[UIColor purpleColor] forKey:@"color"];
    [bellonsArray addObject:dict];
    dict  = [[NSMutableDictionary alloc] init];
    [dict setObject:@"Four.png" forKey:@"img"];
    [dict setObject:[UIColor greenColor] forKey:@"color"];
    [bellonsArray addObject:dict];
    dict  = [[NSMutableDictionary alloc] init];
    [dict setObject:@"Five.png" forKey:@"img"];
    [dict setObject:[UIColor brownColor] forKey:@"color"];
    [bellonsArray addObject:dict];
    dict  = [[NSMutableDictionary alloc] init];
    [dict setObject:@"six.png" forKey:@"img"];
    [dict setObject:[UIColor orangeColor] forKey:@"color"];
    [bellonsArray addObject:dict];
    
    
    [nsv setBellonTag_y_Padding:20];
    [nsv setBellonTag_x_Width:0.5];
    
    [nsv setBellon_x_Padding:0];
    [nsv setBellon_y_Padding:0];
    
    [nsv setShack_speed:3];
    
    [nsv setBellon_x_Padding:6];
    
    [nsv setBellon_img_key:@"img"];
    [nsv setBellon_color_key:@"color"];
    [nsv setBellon_Tag_color:[UIColor lightGrayColor]];
    [nsv setDelegate:self];
    [nsv configureBellons:bellonsArray];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)didTouchedBellon:(id)dict andBellonTag:(int)bellontag{
    
}

@end
