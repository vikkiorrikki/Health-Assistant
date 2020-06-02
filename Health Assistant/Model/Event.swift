//
//  Event.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 08.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import  Foundation

struct Event {
    let title: String
    let doctorsName: String //can be several dostors for one title
//    let specialization: String?
    let startDate: Date?
    let endDate: Date?
    let location: Location?
    let status: EventStatus
    let note: String?
}

enum EventStatus: String, CaseIterable {
    case planned
    case completed
    case canceled
}

extension EventStatus: ListTableViewControllerElement {
    var elementName: String {
        return self.rawValue.capitalized
    }
}

