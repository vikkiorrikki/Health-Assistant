//
//  Event.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 08.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import  Foundation

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

extension Date {
    func toStringFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y  HH:mm"
        return "\(formatter.string(from: self))"
    }
}

extension NSObject {
    func getStatus() -> EventStatus {
        guard let eventStatus = EventStatus(rawValue: self.description) else {
            return .planned
        }
        return eventStatus
    }
}

