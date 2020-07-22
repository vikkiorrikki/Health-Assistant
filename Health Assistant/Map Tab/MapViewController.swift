//
//  MapViewController.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 19.07.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import UIKit
import MapKit

struct Stadium {
    var name: String
    var lattitude: CLLocationDegrees
    var longtitude: CLLocationDegrees
}

class MapViewController: UIViewController{
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let annotationIdentifier = "annotationIdentifier"
    
    let networkService = NetworkService()
    
    var clinics = [Clinic]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        networkService.delegate = self
        networkService.fetchClinics()
//        mapView.userTrackingMode = .follow
        checkLocationServices()
        print("viewDidLoad")
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
        } else {
            let alert = UIAlertController(title: "Location Authorization", message: "You need to turn on location permission!", preferredStyle: .alert)
            present(alert, animated: true)
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            mapView.showsUserLocation = true
        case .restricted:
            break
        case .authorizedAlways:
            break
        }
    }
    
    func fetchClinicsOnMap(_ clinics: [Clinic]) {
        DispatchQueue.main.async {
            for clinic in clinics {
                let annotations = MKPointAnnotation()
                annotations.title = clinic.name
                annotations.coordinate = CLLocationCoordinate2D(latitude:
                    clinic.latitude, longitude: clinic.longitude)
//                self.mapView.showAnnotations([annotations], animated: true)
                self.mapView.addAnnotation(annotations)
                self.mapView.selectAnnotation(annotations, animated: true)
            }
        }
    }
}

//MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) //current annotation is not user location
            else {
                return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.canShowCallout = true
        }
        
        return annotationView
    }
}

//MARK: - MapDelegate

extension MapViewController: MapDelegate {
    func didUpdateClinics(with clinics: [Clinic]) {
        self.clinics = clinics
        fetchClinicsOnMap(clinics)
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
