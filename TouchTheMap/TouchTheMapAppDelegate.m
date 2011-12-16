//
//  TouchTheMapAppDelegate.m
//  TouchTheMap
//
//  Created by Jonathan Fischer on 12/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TouchTheMapAppDelegate.h"

@implementation TouchTheMapAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [_mapView setShowsUserLocation:YES];
    
    // Set up a gesture recognizer to let me catch taps.  I only want to catch single taps, which
    // is kind of difficult.  In order for single taps to work, double taps have to fail.  I can't
    // attach an empty double tap recognizer because it'll interfere with the MapView's internal 
    // double tap recognizer, and then zooms won't work.
    //
    // What I'm doing here is grabbing a list of attached gesture recognizers and finding the internal
    // double tap one, and then telling my single tap one that the double tap must fail
    
    UIGestureRecognizer *builtInDoubleTap = nil;
    NSArray *gestureRecognizers = [_mapView gestureRecognizers];
    for (UIGestureRecognizer *recognizer in gestureRecognizers) {
        if ([recognizer class] == [UITapGestureRecognizer class]) {
            if ([(UITapGestureRecognizer *)recognizer numberOfTapsRequired] == 2) {
                NSLog(@"Found double tap recognizer: %@", recognizer);
                builtInDoubleTap = recognizer;
                break;
            }
        }
    }
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleMapTap:)];
    [tapGesture requireGestureRecognizerToFail:builtInDoubleTap];
    [_mapView addGestureRecognizer:tapGesture];
    [tapGesture release];

    [[self window] makeKeyAndVisible];
    return YES;
}

- (void)dealloc
{
    [_mapView release];
    [_window release];
    [super dealloc];
}

#pragma mark MKMapViewDelegate methods
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D loc = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    [_mapView setRegion:region animated:YES];
}

#pragma mark UIGestureRecognizer targets
- (void)handleMapTap:(id)sender
{
    UITapGestureRecognizer *tapGesture = (UITapGestureRecognizer*)sender;
    
    CGPoint tapPoint = [tapGesture locationInView:_mapView];
    CLLocationCoordinate2D coord = [_mapView convertPoint:tapPoint toCoordinateFromView:_mapView];
    
    NSUInteger numberOfTouches = [tapGesture numberOfTouches];
    
    if (numberOfTouches == 1) {
        NSLog(@"Tap location was %.0f, %.0f", tapPoint.x, tapPoint.y);
        NSLog(@"World coordinate was longitude %f, latitude %f", coord.longitude, coord.latitude);
    } else {
        NSLog(@"Number of touches was %d, ignoring", numberOfTouches);
    }
}

@end
