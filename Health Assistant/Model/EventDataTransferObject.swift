//
//  EventDataTransferObject.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 07.07.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

struct EventDataTransferObject {
    let title: String
    let doctorsID: UUID
    let doctorsName: String?
    let locationID: UUID
    let startDate: Date
    let endDate: Date
    let status: EventStatus
    let note: String?
}
