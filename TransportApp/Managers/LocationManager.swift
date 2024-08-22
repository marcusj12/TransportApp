//
//  LocationManager.swift
//  TransportApp
//
//  Created by Marcus  Jennings on 8/12/24.
//
import SwiftUI
import CoreLocation
import FirebaseAuth
import MapKit
import FirebaseFirestore

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    
    override init() {
        // Most accurate user location
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // Function used to gain permissions to use location
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !locations.isEmpty else { return }
        locationManager.stopUpdatingLocation()
    }
    
}
