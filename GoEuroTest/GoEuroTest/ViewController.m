//
//  ViewController.m
//  GoEuroTest
//
//  Created by Faizan Ali on 11/1/16.
//  Copyright © 2016 GoEuro. All rights reserved.
//

#import "ViewController.h"
#import "Constants.h"
#import "TripTableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    tripType = 0;
    filterType = 100;
    
    objTripHandler = [[TripHandler alloc] init];
    self.tblViewTrips.estimatedRowHeight = 60;
    self.tblViewTrips.rowHeight = UITableViewAutomaticDimension;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadData)
                                                 name:@"reachabilityChanged"
                                               object:nil];
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)loadData
{
    
    if(tripType == 0 && objTrainTripArray.count >0)
    {
         [self reloadData:objTrainTripArray];
    }
    else if(tripType == 1 && objBusTripArray.count >0)
    {
        [self reloadData:objBusTripArray];
    }
    else if(tripType == 2 && objFlightTripArray.count >0)
    {
         [self reloadData:objFlightTripArray];
    }
    else
    {
        [objTripHandler getTripsList:tripType Success:^(id responseData)
         {
             
             if(tripType == 0)
             {
                 objTrainTripArray = responseData;
             }
             else if(tripType == 1)
             {
                 objBusTripArray = responseData;
             }
             else
             {
                 objFlightTripArray = responseData;
             }
             [self reloadData:responseData];
             
             
         }];
    }
}
-(void)reloadData:(NSArray*)data
{
    NSString *sortType = @"self.departureTime";
    if(filterType == 101)
    {
        self.btnArrival.enabled = NO;
        sortType = @"self.arrivalTime";
    }
    else if (filterType == 102)
    {
        self.btnHours.enabled = NO;
        sortType = @"self.totalDifference";
    }
    else
    {
        self.btnDeparture.enabled = NO;
    }
    
    NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: sortType
                                                                ascending: YES];
     objTripArray = [data sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];
    [self.tblViewTrips reloadData];
}

#pragma mark TableViewDelegates & DataSource


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return objTripArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Trip *objTrip = [objTripArray objectAtIndex:indexPath.row];
    
    TripTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TripTableViewCell" forIndexPath:indexPath];
    cell.lblTime.text = [NSString stringWithFormat:@"%@ - %@",objTrip.depatureTimeString,objTrip.arrivalTimeString];
    cell.lblHours.text = [NSString stringWithFormat:@"Direct %@",objTrip.hoursString];
    [cell.imgViewLogo sd_setImageWithURL:objTrip.imgUrl placeholderImage:[UIImage imageNamed:@"imgLogo"]];
   
    NSArray *splitStr = [objTrip.priceInEuro componentsSeparatedByString:@"."];
    
    cell.lblPrice.text = [NSString stringWithFormat:@"€%@",splitStr[0]];
    NSString *strSecond = splitStr[1];
    
    if([strSecond intValue]>=10 || strSecond.length >=2)
    {
        cell.lblCents.text = [NSString stringWithFormat:@".%@",strSecond];
    }
    else
    {
       cell.lblCents.text = [NSString stringWithFormat:@".0%@",strSecond];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [CommonMethods showOKAlertView:@"Alert!" withDescription:@"Offer details are not yet implemented!"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)enableAll
{
    self.btnTrain.enabled = YES;
    self.btnBus.enabled = YES;
    self.btnFlight.enabled = YES;
    
}
-(void)animateBar:(float)positiom
{
    self.constraintTSBar.constant = positiom;
    [self animate];

}
-(void)animate
{
    [UIView animateWithDuration:.3 animations:^
     {
         
         [self.view layoutIfNeeded];
         
     }];
}
- (IBAction)trainAction:(id)sender
{
    [self enableAll];
    self.btnTrain.enabled = NO;
    [self animateBar:3];
    tripType = 0;
    [self loadData];
}

- (IBAction)busAction:(id)sender
{
    [self enableAll];
    self.btnBus.enabled = NO;
    [self animateBar:self.btnTrain.frame.size.width];
     tripType = 1;
     [self loadData];
}

- (IBAction)flightAction:(id)sender
{
    [self enableAll];
    self.btnFlight.enabled = NO;
    [self animateBar:self.btnTrain.frame.size.width*2];
     tripType = 2;
     [self loadData];
    
}

- (IBAction)filterAction:(id)sender
{
    self.constraintBSFilterView.constant = 0;
    [self animate];
}

- (IBAction)crossAction:(id)sender
{
    self.constraintBSFilterView.constant = -200;
    [self animate];
}

- (IBAction)filterTypeAction:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    filterType = (int)btn.tag;
    NSArray *data = objTrainTripArray;
    
    self.btnDeparture.enabled = YES;
    self.btnArrival.enabled = YES;
    self.btnHours.enabled = YES;
    [self crossAction:nil];
    
    if(tripType == 1)
    {
        data = objBusTripArray;
    }
    else if(tripType == 2 )
    {
        data = objFlightTripArray;
    }
   
     [self reloadData:data];
}
@end
