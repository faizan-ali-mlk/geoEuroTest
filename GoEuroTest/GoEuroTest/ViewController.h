//
//  ViewController.h
//  GoEuroTest
//
//  Created by Faizan Ali on 11/1/16.
//  Copyright © 2016 GoEuro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TripHandler.h"


@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    
    TripHandler *objTripHandler;
    NSArray *objTripArray;
    NSArray *objTrainTripArray;
    NSArray *objBusTripArray;
    NSArray *objFlightTripArray;
    
    int filterType;
    int tripType;
    
}
@property (weak, nonatomic) IBOutlet UILabel *lblViewTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UIButton *btnTrain;
@property (weak, nonatomic) IBOutlet UIButton *btnBus;
@property (weak, nonatomic) IBOutlet UIButton *btnFlight;
@property (weak, nonatomic) IBOutlet UIView *viewBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTSBar;
@property (weak, nonatomic) IBOutlet UITableView *tblViewTrips;
@property (weak, nonatomic) IBOutlet UIButton *btnFilter;
@property (weak, nonatomic) IBOutlet UIButton *btnCross;
@property (weak, nonatomic) IBOutlet UIButton *btnArrival;
@property (weak, nonatomic) IBOutlet UIButton *btnHours;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBSFilterView;
@property (weak, nonatomic) IBOutlet UIButton *btnDeparture;

- (IBAction)trainAction:(id)sender;
- (IBAction)busAction:(id)sender;
- (IBAction)flightAction:(id)sender;
- (IBAction)filterAction:(id)sender;
- (IBAction)crossAction:(id)sender;
- (IBAction)filterTypeAction:(id)sender;
@end

