//
//  MapDelegate.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 22.07.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

protocol MapDelegate {
    func didFailWithError(error: Error)
    func didUpdateClinics(with clinics: [Clinic])
}
