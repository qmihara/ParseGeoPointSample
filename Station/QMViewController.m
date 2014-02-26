//
//  QMViewController.m
//  Station
//
//  Created by Kyusaku Mihara on 2014/02/26.
//  Copyright (c) 2014年 epohsoft. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <Parse/Parse.h>

#import "QMViewController.h"
#import "QMStation.h"

@interface QMViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation QMViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        if (error) {
            NSLog(@"error %@", [error localizedDescription]);
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            return;
        }

        MKCoordinateRegion region = self.mapView.region;
        region.center = CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude);
        region.span.latitudeDelta = 0.02;
        region.span.longitudeDelta = 0.02;
        [self.mapView setRegion:region animated:YES];

        PFQuery *query = [QMStation query];
        [query whereKey:@"location" nearGeoPoint:geoPoint];
        query.limit = 20;
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error) {
                NSLog(@"error %@", [error localizedDescription]);
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                return;
            }

            for (QMStation *station in objects) {
                MKPointAnnotation *pin = [MKPointAnnotation new];
                pin.title = station.name;
                pin.coordinate = CLLocationCoordinate2DMake(station.location.latitude, station.location.longitude);
                [self.mapView addAnnotation:pin];
            }
        }];
    }];
}

#pragma mark - Map view delegate methods

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString *PinIdentifier = @"Pin";
    MKPinAnnotationView *pinAnnotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:PinIdentifier];
    if (!pinAnnotationView) {
        pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:PinIdentifier];
        pinAnnotationView.animatesDrop   = YES;
        pinAnnotationView.canShowCallout = YES;
        return pinAnnotationView;
    }

    pinAnnotationView.annotation = annotation;
    return pinAnnotationView;
}

@end
