//
//  DateExtension.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 09.07.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

extension Date {
    func toStringFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y  HH:mm"
        return "\(formatter.string(from: self))"
    }
}
