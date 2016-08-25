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

    var searchTitle: String!
    @IBOutlet var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var destination:CLLocationCoordinate2D!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        //Load location list of activity to the map

        //Locate user's current location
        self.locationManager.delegate = self
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.startUpdatingLocation()
        
        self.mapView.showsUserLocation = true

        //Location of activity
        self.searchLocation()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchLocation() {
        let replaced = searchTitle.stringByReplacingOccurrencesOfString(" ", withString: "+")
//        searchTitle.stringByReplacingOccurrencesOfString(" ", withString: "+")
        let requestURL: NSURL = NSURL(string: "https://maps.googleapis.com/maps/api/geocode/json?address=victoria+" + replaced + "&key=AIzaSyCP_DRut117GrxZc3r0Gm9XuFGICUegZ8s")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()

        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            //Get http response and if status is ok, read content of it
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                do{
                    //Get news item one layer by one layer
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
                    print(json)
                    let results = json.objectForKey("results") as! NSArray
                    //                    let result = query.objectForKey("results") as! NSDictionary
                    let items : NSMutableArray = []
                    for item in (results as NSArray)
                    {
                        let geo = item.objectForKey("geometry") as! NSDictionary
                        let loc = geo.objectForKey("location") as! NSDictionary
                        items.addObject(loc)
                    }
                    
                    self.readJson(items)
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }

    func readJson(items: NSMutableArray) {
        //Duplicate title, description, link and image url from json response to self array
        for activity in (items as NSMutableArray )
        {
            //Get title
            let lat = activity["lat"] as! CLLocationDegrees
            let lng = activity["lng"] as! CLLocationDegrees
            destination = CLLocationCoordinate2D(latitude: lat,longitude: lng)
            let cf = MKCoordinateRegionMake(CLLocationCoordinate2DMake(lat, lng), MKCoordinateSpanMake(0.1766154, 0.153035))
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(lat, lng)
            annotation.title = searchTitle
            
//            annotation. .rightCalloutAccessoryView = button
            mapView.addAnnotation(annotation)
            mapView.setRegion(cf, animated: true)

      
        }
    }

    func locationManager(manager: CLLocationManager,didUpdateLocations location:[CLLocation])
    {
        let location = location.last
        
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.01,0.01)
        
        let region = MKCoordinateRegion(center: center, span: span)
        
        self.mapView.setRegion(region, animated: true)
        
        self.locationManager.stopUpdatingLocation()
        
        //get destination
        
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
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Errors" + error.localizedDescription)
    }
    
//    @IBAction func showDestination(sender: AnyObject) {
//        
//    }
//    
//    
//    @IBAction func addPin(sender: AnyObject) {
//        
//        let location = sender.locationInView(self.mapView)
//        
//        let coordinate = self.mapView.convertPoint(location, toCoordinateFromView: self.mapView)
//        
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = coordinate
//        annotation.title = "Destination"
//        annotation.subtitle = "Let have some fun"
//        
//        let placeMark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
//        
//        destination = MKMapItem(placemark: placeMark)
////        self.locationMap.removeAnnotations(listOldDestination)
////        self.locationMap.addAnnotation(annotation)
////        listOldDestination.append(annotation)
//    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.blueColor()
        return renderer
    }
    


}
