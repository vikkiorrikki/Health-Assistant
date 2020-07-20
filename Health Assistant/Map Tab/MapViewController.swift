//
//  MapViewController.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 19.07.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import UIKit
import YandexMapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: YMKMapView!
    let TARGET_LOCATION = YMKPoint(latitude: 59.945933, longitude: 30.320045)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.mapWindow.map.move(
        with: YMKCameraPosition(target: TARGET_LOCATION, zoom: 15, azimuth: 0, tilt: 0),
        animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
        cameraCallback: nil)
    }
}
