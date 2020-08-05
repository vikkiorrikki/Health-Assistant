//
//  ClinicData.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 22.07.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

struct ClinicData: Codable {
    let features: [Feature]
}

struct Feature: Codable {
    let geometry: Geometry
    let properties: Properties
}

struct Geometry: Codable {
    let coordinates: [Double]
}

struct Properties: Codable {
    let name: String
    let description: String
    let CompanyMetaData: CompanyMetaData
}

struct CompanyMetaData: Codable {
    let id: String
}
