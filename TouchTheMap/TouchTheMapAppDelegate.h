//
//  TouchTheMapAppDelegate.h
//  TouchTheMap
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface TouchTheMapAppDelegate : NSObject <UIApplicationDelegate, MKMapViewDelegate>
{
    IBOutlet MKMapView *_mapView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
