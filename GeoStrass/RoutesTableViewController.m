//
//  RoutesTableViewController.m
//  GeoStrass
//
//  Created by amadou diallo on 2/19/13.
//  Copyright (c) 2013 unistra. All rights reserved.
//

#import "RoutesTableViewController.h"


#define ROUTE_TYPE_TAG 111
#define ROUTE_IMG_TAG  112
#define ROUTE_DIRECTION_TAG 113
#define ROUTE_RETURN_TAG 114

static NSMutableDictionary* routesDictionnary;

@interface RoutesTableViewController ()

@property(nonatomic,strong) NSMutableArray* tramRoutes;
@property(nonatomic,strong) NSMutableArray* busRoutes;
//@property(nonatomic,strong) NSMutableDictionary* routesDictionnary;

@property BOOL showTramCells;
@property BOOL showBusCells;

@property(nonatomic,strong) UIView* tramHeaderView;
@property(nonatomic,strong) UIView* busHeaderView;

@property(nonatomic,strong) NSMutableArray* headers;

@end

@implementation RoutesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tramRoutes = [[NSMutableArray alloc] init];
    self.busRoutes = [[NSMutableArray alloc] init];
    routesDictionnary = [[NSMutableDictionary alloc] init];
    self.headers = [[NSMutableArray alloc] initWithCapacity:2];
    
  //  self.showBusCells = self.showTramCells = YES;
    
    [self parseRoutesInBackground];
    
    CGRect newBounds = [[self tableView] bounds];
    newBounds.origin.y = newBounds.origin.y + self.routeSearchBar.bounds.size.height;
    [self.tableView setBounds:newBounds];
}

-(void) parseRoutesInBackground
{
    NSLog(@"begin _executeToTheBackground");
    NSOperationQueue *_computeQueue = [[NSOperationQueue alloc] init];
    _computeQueue.name = @"Parsing des fichiers des lignes";
    
    [_computeQueue addOperationWithBlock:
     ^(void)
     {
         [self parseFile:@"routes"];
         
         [[NSOperationQueue mainQueue] addOperationWithBlock:^(void)
          {
              NSLog(@"didFinishComputeRoutes : %d Bus et %d Tram",self.busRoutes.count,self.tramRoutes.count);
              [self.tableView reloadData];
          }];
     }];
}

-(void) parseFile:(NSString*) filePath
{
    NSLog(@"begin parse file : %@",filePath);
    
    NSString* fileRoot = [[NSBundle mainBundle]
                          pathForResource:filePath ofType:@"txt"];
    // read everything from text
    NSString* fileContents =
    [NSString stringWithContentsOfFile:fileRoot
                              encoding:NSUTF8StringEncoding error:nil];
    
    // first, separate by new line
    NSArray* allLinedStrings =
    [fileContents componentsSeparatedByCharactersInSet:
     [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    
    // then break down even further
    NSString* firstLine =
    [allLinedStrings objectAtIndex:0];
    
    NSArray* keys =
    [firstLine componentsSeparatedByCharactersInSet:
     [NSCharacterSet characterSetWithCharactersInString:@","]];
    
    NSString* strsInOneLine;
    
    for (int i=1; i<allLinedStrings.count; i++)
    {
        strsInOneLine = [allLinedStrings objectAtIndex:i];
        
        NSArray* values =
        [strsInOneLine componentsSeparatedByCharactersInSet:
         [NSCharacterSet characterSetWithCharactersInString:@","]];
        
        NSMutableDictionary* dico = [[NSMutableDictionary alloc] initWithCapacity:keys.count];
        
        for (int j=0; j<values.count; j++)
        {
            //NSLog(@"Set Object : %@ forkey %@ ",[values objectAtIndex:j],[keys objectAtIndex:j]);
            [dico setObject:[values objectAtIndex:j]  forKey:[keys objectAtIndex:j]];
        }
        
        Route* route = [[Route alloc] initWithDictionnary:dico];
        
        [routesDictionnary setObject:route forKey:route.routeId]; // route_id
    }
    
    for (Route* route in [routesDictionnary allValues])
    {
        if(route.routeType == Bus)
        {
            [self.busRoutes addObject:route];
        }
        else
        {
            if(route.routeType == Tramway)
            {
                [self.tramRoutes addObject:route];
            }
        }
    }
    
  //  NSLog(@"end parse file : %@ with content : %d",filePath,self.routesDictionnary.count);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Route* route;
    if(indexPath.section == 0)
    {
        route = (Route*)[self.tramRoutes objectAtIndex:indexPath.row];
    }
    else
    {
       route = (Route*)[self.busRoutes objectAtIndex:indexPath.row];
    }
    
    cell.backgroundColor = route.routeTextColor;
}

/*-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return [NSString stringWithFormat:@"%d Lignes de Tram",self.tramRoutes.count];
    else
        return [NSString stringWithFormat:@"%d Lignes de Bus",self.busRoutes.count];
}*/

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section==0 && self.tramHeaderView)
    {
        return self.tramHeaderView;
    }
    
    if(section==1 && self.busHeaderView)
    {
        return self.busHeaderView;
    }
    
    NSLog(@"viewForHeaderInSection %d",section);

    UITableViewCell* headCellView = [self.tableView dequeueReusableCellWithIdentifier:@"headerViewCell"];
    UIImageView* typeIV = (UIImageView*)[headCellView viewWithTag:111];
    NSString* type = (section == 0)? @"tram.jpg" : @"bus.jpg";
    typeIV.image = [UIImage imageNamed:type];
    
    UILabel* detailsLabel = (UILabel*)[headCellView viewWithTag:113];
    detailsLabel.text = [NSString stringWithFormat:@"%d lignes",(section==0)? self.tramRoutes.count : self.busRoutes.count];
    
    UIButton* button = (UIButton*)[headCellView viewWithTag:112];
    button.tag = section;
    [button addTarget:self action:@selector(ShowMoreOrLess:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView* moreOrLessIV = (UIImageView*)[headCellView viewWithTag:115];
    moreOrLessIV.highlighted = (section == 0)? self.showTramCells : self.showBusCells;
    
    if(section == 0 && self.tramRoutes.count > 0)
    {
        self.tramHeaderView = headCellView.contentView;
         [self.headers setObject:(UIView*)[headCellView viewWithTag:116] atIndexedSubscript:0];
    }
    else
        if(section == 1 && self.busRoutes.count > 0)
        {
            self.busHeaderView = headCellView.contentView;
            [self.headers setObject:(UIView*)[headCellView viewWithTag:116] atIndexedSubscript:1];
        }
    
    return [headCellView contentView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        if(self.showTramCells)
            return self.tramRoutes.count;
        else
            return 0;
    }
    else
    {
        if(self.showBusCells)
            return self.busRoutes.count;
        else
            return 0;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"linesCell";
    
    if(indexPath.section == 0)
        CellIdentifier = @"tramCell";
    else
        CellIdentifier = @"busCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

-(void) configureCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    Route* route =
    (indexPath.section == 0)?
    [self.tramRoutes objectAtIndex:indexPath.row] : [self.busRoutes objectAtIndex:indexPath.row];

    UIImageView* routeImageView = (UIImageView*)[cell viewWithTag:ROUTE_IMG_TAG];
    
    routeImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",route.routeShortName]];
    
    UILabel* directionLabel = (UILabel*)[cell viewWithTag:ROUTE_DIRECTION_TAG];
    directionLabel.text = route.oneWayDirection;
    
    UILabel* returnLabel = (UILabel*)[cell viewWithTag:ROUTE_RETURN_TAG];
    returnLabel.text = route.returnWayDirection;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void) ShowMoreOrLess:(id) sender
{
    UIButton* button = (UIButton*) sender;
    if(button.tag == 0)
    {
        if(self.showTramCells)
        {
            [[self.headers objectAtIndex:0] setAlpha:1];
        }
        else
        {
            [[self.headers objectAtIndex:0] setAlpha:0];        }
        
        self.showTramCells = ! self.showTramCells;
    }
    else
    {
        [[self.headers objectAtIndex:1] setAlpha:(self.showBusCells)?1:0];
        self.showBusCells = ! self.showBusCells;
    }
    
    NSIndexSet* indexSet = [NSIndexSet indexSetWithIndex:button.tag];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - Utilitaires

+(Route*) getRouteFromId:(NSString*) routeId
{
    return [routesDictionnary objectForKey:routeId];
}

@end
