//
//  GPSView.swift
//  TransportApp
//
//  Created by Marcus  Jennings on 8/12/24.
//
import SwiftUI
import MapKit



struct GPSView: UIViewRepresentable {
    
    let mapView = MKMapView()
    let locationManager = LocationManager()
    
    func makeUIView(context: Context ) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ UIView: UIViewType, context: Context) {
        
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)

    }
    
}

extension GPSView {
    
    class MapCoordinator: NSObject, MKMapViewDelegate {
        let parent:  GPSView
        
        init(parent: GPSView) {
            self.parent = parent
        }
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,
                                               longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            
            parent.mapView.setRegion(region, animated: true)

        }
    }
}

