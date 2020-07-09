//
//  NSObjectExtension.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 09.07.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

extension NSObject {
    func getStatus() -> EventStatus {
        guard let eventStatus = EventStatus(rawValue: self.description) else {
            return .planned
        }
        return eventStatus
    }
}
