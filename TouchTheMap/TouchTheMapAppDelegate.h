//
//  TouchTheMapAppDelegate.h
//  TouchTheMap
//
//  Created by Jonathan Fischer on 12/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface TouchTheMapAppDelegate : NSObject <UIApplicationDelegate, MKMapViewDelegate>
{
    IBOutlet MKMapView *_mapView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
