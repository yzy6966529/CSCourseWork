//
//  ViewController.swift
//  MyLocationMap
//
//  Created by Mitja Hmeljak on 2017-10-25.
//  Copyright © 2017 A290/A590 Fall 2017 - mitja. All rights reserved.
//

import UIKit

import MapKit //

class ViewController: UIViewController,
    // the ViewController will be also the CLLocationManagerDelegate:
    CLLocationManagerDelegate {


    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    
    var shouldTrackLog = true
    
    @IBAction func textSwitch(_ sender: Any) {
        if shouldTrackLog{
            shouldTrackLog = false
        }else{
            shouldTrackLog = true
        }
    }
    @IBAction func centerSwitch(_ sender: Any) {
        myMapView.userTrackingMode = .follow
    }
    
    let locationManager = CLLocationManager()
    var longitudeValue : Double = 0.0
    var latitudeValue : Double = 0.0
    var isMapToBeUpdated = true
    var numOfTrackedLocations = 0

    @IBOutlet weak var myTextLogView: UITextView!

    @IBOutlet weak var myMapView: MKMapView!

    @IBOutlet weak var myButtonOutlet: UIButton!

    @IBAction func myButtonAtion(_ sender: AnyObject) {

        if self.isMapToBeUpdated {
            self.isMapToBeUpdated = false
            self.myButtonOutlet.setTitle("Start", for: UIControlState())
            self.myButtonOutlet.backgroundColor = UIColor.green

        } else {
            self.isMapToBeUpdated = true
            self.myButtonOutlet.setTitle("Stop", for: UIControlState())
            self.myButtonOutlet.backgroundColor = UIColor.red
        }


    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        // to use the Location Manager when our app is running in foreground:
        
        self.locationManager.requestWhenInUseAuthorization()

        // to always use Location Manager:
        //         self.locationManager.requestAlwaysAuthorization()

        if (CLLocationManager.locationServicesEnabled()) {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
        
    }



    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]) {

        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        // get the last of all updated locations:
        let location:CLLocation = locations[locations.count - 1]
        // The altitude, measured in meters:
        let theAltitudes = manager.location!.altitude
        
        if shouldTrackLog == true {
        self.myTextLogView.text = self.myTextLogView.text +
            "\n\(locValue.latitude) \(locValue.longitude)"
        print("location = \(locValue.latitude) \(locValue.longitude)")
        }
        
        self.longitudeLabel.text = "\(locValue.longitude)"
        self.latitudeLabel.text = "\(locValue.latitude)"
        self.longitudeValue = (locValue.longitude)
        self.latitudeValue = (locValue.latitude)
        self.altitudeLabel.text = "\(theAltitudes)"
        self.speedLabel.text = "\(location.speed)"
        
        
        if self.isMapToBeUpdated == true {
            self.addAnnotationToMap()
        }


    }


    func addAnnotationToMap(){

        let location = CLLocationCoordinate2D(
            latitude: self.latitudeValue,
            longitude: self.longitudeValue
        )

        let span = MKCoordinateSpanMake(0.5, 0.5)
        let region = MKCoordinateRegion(center: location, span: span)

        self.myMapView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "location \(self.numOfTrackedLocations) was \(self.longitudeValue), \(latitudeValue)"
        let date = Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.hour, .minute, .second], from: date)
        let hour = components.hour
        let minutes = components.minute
        let seconds = components.second
        annotation.subtitle = "at \(hour ?? 0):\(minutes ?? 0):\(seconds ?? 0)"
        self.myMapView.addAnnotation(annotation)
        self.numOfTrackedLocations += 1
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

