//
//  EventExtension.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 02.07.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

extension Event {
    var status: EventStatus {
        get {
            if let rawStatus = self.rawStatus {
                return EventStatus(rawValue: rawStatus)!
            } else {
                return EventStatus.planned
            }
        }
        set {
            self.rawStatus = newValue.rawValue
        }
    }
}
