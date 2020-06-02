//
//  Doctor.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 08.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

struct Doctor {
    let id: UUID
    let specialization: String
    var events: [Event]
}
