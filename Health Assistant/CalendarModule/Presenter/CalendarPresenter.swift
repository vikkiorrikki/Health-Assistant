//
//  CalendarPresenter.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 16.07.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

class CalendarPresenter {
    weak var calendarView: CalendarInput?
    
    let storageService = StorageService()
    var events = [Event]() {
        didSet {
            calendarView?.reloadTableView()
        }
    }
    
    func viewIsReady() {
        calendarView?.setupUI()
        updateEvents(for: Date())
    }
    
    func updateEvents(for date: Date) {
        events = storageService.loadEvents(in: date)!
    }
    
    func isEvents(in date: Date) -> Bool {
        let events = storageService.loadEvents(in: date)
        if events?.count != 0 {
            return true
        } else {
            return false
        }
    }
}
