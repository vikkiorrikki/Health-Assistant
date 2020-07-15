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

    func startOfMonth() -> Date {
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: comp)!
    }
    
    func endOfMonth() -> Date {
        var comp = DateComponents()
        comp.month = 1
        comp.day = -1
        return Calendar.current.date(byAdding: comp, to: startOfMonth())!
    }
    
    func toTimeFormat() -> String{
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none

        return "\(formatter.string(from: self))"
    }
}
