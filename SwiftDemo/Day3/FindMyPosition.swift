//
//  FindMyPosition.swift
//  SwiftDemo
//
//  Created by 钱立新 on 2020/9/17.
//  Copyright © 2020 钱立新. All rights reserved.
//

import UIKit
import CoreLocation

class FindMyPosition: UIViewController, CLLocationManagerDelegate {

    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    let locationLab = UILabel()
    let locationStrLab = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bgImageView = UIImageView(frame: view.bounds)
        bgImageView.image = UIImage(named: "phoneBg")
        view.addSubview(bgImageView)
        
        let blurEffect: UIBlurEffect = UIBlurEffect(style: .light)
        let blurView: UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = view.bounds
        view.addSubview(blurView)
        
        locationManager.delegate = self
        
        locationLab.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: 100)
        locationLab.numberOfLines = 0
        locationLab.textAlignment = .center
        locationLab.textColor = UIColor.white
        view.addSubview(locationLab)
        
        locationStrLab.frame = CGRect(x: 0, y: 200, width: self.view.bounds.width, height: 100)
        locationStrLab.numberOfLines = 0
        locationStrLab.textAlignment = .center
        locationStrLab.textColor = UIColor.white
        view.addSubview(locationStrLab)
        
        let findMyLocationBtn = UIButton(type: .custom)
        findMyLocationBtn.frame = CGRect(x: 50, y: self.view.bounds.height - 80, width: self.view.bounds.width - 100, height: 50)
        findMyLocationBtn.setTitle("Find My Position", for: .normal)
        findMyLocationBtn.setTitleColor(UIColor.white, for: .normal)
        findMyLocationBtn.addTarget(self, action: #selector(findMyLocation), for: .touchUpInside)
        view.addSubview(findMyLocationBtn)
        

    }

    @objc func findMyLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.last! as CLLocation
        let locationStr = "lat:\(currentLocation.coordinate.latitude)\nlng:\(currentLocation.coordinate.longitude)"
        locationLab.text = locationStr
    
        reverseGeocode(location:currentLocation)
        locationManager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func reverseGeocode(location: CLLocation) {
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            let mark = placemarks?.first!
            let country = mark?.country
            let city = mark?.locality
            let street = mark?.thoroughfare
            let name = mark?.name
            
            let finalAddress = "\(country ?? ""),\(city ?? ""),\(street ?? ""),\(name ?? "")"
            self.locationStrLab.text = finalAddress
        }
    }
    
    deinit {
        locationManager.stopUpdatingLocation()
    }
}
