//
//  PickyViewController.swift
//  Picky
//
//  Created by Aaron Chen on 12/30/17.
//  Copyright © 2017 ACDev. All rights reserved.
//

import UIKit
import CoreLocation

class PickyViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var navItem: UINavigationItem!
    
    @IBOutlet var pickyView: PickyView!
    
    var locationManager = CLLocationManager()
    
    var fData : FilterData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navItem.hidesBackButton = true
        // Do any additional setup after loading the view.
        pickyView.setDefaults(data: fData)
        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == .authorizedAlways {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            fData.location = location
            manager.stopUpdatingLocation()
        }
    }
    
    func receiveData(data: FilterData) {
        fData = data
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "pickytorestaurant" {
            //give a notification if no location services allowed
            return CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() == .authorizedAlways
        }
        return true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (fData.isDriving, fData.price) = pickyView.exportFilter()
        if let dvc = segue.destination as? RestaurantViewController {
            dvc.receiveData(data: fData)
        }
    }
}
