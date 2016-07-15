# NSVBellonsMenu
Create Menu like flying bellons with animations and custom modification

NSVBellons Menu is like show th menu or options as like as fyling bellons . The menu buttons are fyling as real time bellons with beautiful andimation .

**Integratin**
Drag & Drop or import the NSVBellonsMenu - h , m files in your project

**Configration**

Import  the Header file in your class and create UIBUtton in xib or stroy board and change class as NSVBellonsMenu .

**Declaration**

 IBOutlet NSVBellonsMenu *nsv ;
 **set delegat**
 [nsv setDelegate:self];
  **Bellons Tag Configuration**
   [nsv setBellonTag_y_Padding:20];
   [nsv setBellonTag_x_Width:0.5];
   
  **Bellons  Configuration**
    [nsv setBellon_x_Padding:0];
   [nsv setBellon_y_Padding:0];
    [nsv setBellon_x_Padding:6];
    
**Animation speed Configuration**
    [nsv setShack_speed:3];
**Bellons Image Configuration**
   [nsv setBellon_img_key:@"img"];
**Bellons background color Configuration** 
    [nsv setBellon_color_key:@"color"];
**Bellons Tag color Configuration**
    [nsv setBellon_Tag_color:[UIColor lightGrayColor]];
  
  **Delegate Method ** 
    
    -(void)didTouchedBellon:(id)dict andBellonTag:(int)bellontag{
  }
    

  **Example**

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
 


