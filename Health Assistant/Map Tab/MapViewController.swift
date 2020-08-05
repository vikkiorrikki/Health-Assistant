//
//  MapViewController.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 19.07.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController{
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let annotationIdentifier = "annotationIdentifier"
    
    let repository = LocationsRepository()
    var locations = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.userTrackingMode = .follow
        checkLocationServices()

        if let cachedLocations = repository.getCachedLocations() {
            showClinicsOnMap(cachedLocations)
        }
        
        repository.fetchLocations {[weak self] (locations, error) in
            if let clinics = locations {
                // SUCCESS
                self?.showClinicsOnMap(clinics)
            }
            if let error = error {
                // FAILURE
                self?.failedLoadingClinics(error: error)
            }
        }
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
    
    func showClinicsOnMap(_ clinics: [Location]) {
        DispatchQueue.main.async {
            for clinic in clinics {
                let annotations = MKPointAnnotation()
                annotations.title = clinic.name
                annotations.subtitle = clinic.definition
                annotations.coordinate = CLLocationCoordinate2D(latitude:
                    clinic.latitude, longitude: clinic.longitude)
                
                self.mapView.showAnnotations([annotations], animated: true)
                self.mapView.addAnnotation(annotations)
//                self.mapView.selectAnnotation(annotations, animated: true)
            }
        }
    }
    
    func updateLocations(_ locations: [Location]) {
        showClinicsOnMap(locations)
    }

    func failedLoadingClinics(error: Error) {
        print(error)
    }
}

//MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation else { return }
        let placeName = (annotation.title)!
        let placeInfo = (annotation.subtitle)!

        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) //current annotation is not user location
            else {
                return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        }
        
        return annotationView
    }
}
