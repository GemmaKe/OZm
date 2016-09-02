//
//  ActivityMapViewController.swift
//  OZ
//
//  Created by val on 21/08/2016.
//  Copyright © 2016 Qing. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ActivityMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var activity: ActivityModel!
    @IBOutlet var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var destination:CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        //Load location list of activity to the map
        destination = CLLocationCoordinate2D(latitude: activity.lat!,longitude: activity.lng!)
        
        //Locate user's current location
        self.locationManager.delegate = self
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.startUpdatingLocation()
        
        self.mapView.showsUserLocation = true
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Set pin button to get navigation. Reference : http://stackoverflow.com/questions/24467408/swift-add-mkannotationview-to-mkmapview
    func mapView(mapView: MKMapView, viewForAnnotation annotation:MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            
        } else {
            pinView?.annotation = annotation
        }
        
        let button = UIButton(type: .DetailDisclosure) as UIButton
        button.setImage(UIImage(named: "Navigation.png"), forState: UIControlState.Normal)
        
        pinView?.rightCalloutAccessoryView = button
        return pinView
        
    }
    
    // navigation from current location to destination
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl ) {
        if control == view.rightCalloutAccessoryView {
            //get destination
            destination = CLLocationCoordinate2D(latitude: activity.lat!,longitude: activity.lng!)
            let placeMark = MKPlacemark(coordinate: destination, addressDictionary: nil)
            let dest = MKMapItem(placemark: placeMark)
            let request = MKDirectionsRequest()
            request.source = MKMapItem.mapItemForCurrentLocation()
            
            request.destination = dest
            
            request.requestsAlternateRoutes = true
            request.transportType = .Walking
            
            let direction = MKDirections(request: request)
            
            direction.calculateDirectionsWithCompletionHandler { [unowned self] response, error in
                guard let unwrappedResponse = response else { return }
                
                for route in unwrappedResponse.routes {
                    self.mapView.addOverlay(route.polyline)
                    self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                }
            }
            
        }
    }
    
    func locationManager(manager: CLLocationManager,didUpdateLocations location:[CLLocation])
    {
        // get current location
        let location = location.last
        
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.01,0.01)
        
        let region = MKCoordinateRegion(center: center, span: span)
        
        self.mapView.setRegion(region, animated: true)
        
        self.locationManager.stopUpdatingLocation()
        
        // set pin title
        let cf = MKCoordinateRegionMake(CLLocationCoordinate2DMake(activity.lat!, activity.lng!), MKCoordinateSpanMake(0.1766154, 0.153035))
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(activity.lat!, activity.lng!)
        annotation.title = self.activity.title
        
        mapView.addAnnotation(annotation)
        mapView.setRegion(cf, animated: true)
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Errors " + error.localizedDescription)
    }
    
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.blueColor()
        return renderer
    }
    
    
    
}
