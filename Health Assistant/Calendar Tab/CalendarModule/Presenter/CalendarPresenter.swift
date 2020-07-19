//
//  CalendarPresenter.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 16.07.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

class CalendarPresenter {
    weak var calendarVC: CalendarInput?
    
    let storageService = StorageService()
    var events = [Event]() {
        didSet {
            calendarVC?.reloadTableView()
        }
    }
    var lastShownDate = Date()
    
    func viewIsReady() {
        calendarVC?.setupUI()
    }
    
    func updateEvents(for date: Date) {
        events = storageService.loadEvents(in: date)!
        calendarVC?.updateCalendar()
    }
    
    func isEvents(in date: Date) -> Bool {
        let events = storageService.loadEvents(in: date)
        if events?.count != 0 {
            return true
        } else {
            return false
        }
    }
    
    func userDidSelectCalendarEventCell(with indexPath: IndexPath) {
        let event = events[indexPath.row]
        calendarVC?.openEventDetails(of: event)
    }
    
    func userDidDeleteEventinCalendar(index: IndexPath) {
        let startDate = events[index.row].startDate
        if storageService.removeEvent(events[index.row]) {
            if let events = storageService.loadEvents(in: startDate!) {
                self.events = events
                calendarVC?.updateCalendar()
            } else {
                calendarVC?.showErrorAlert(with: "Events are not loaded!")
            }
        } else {
            calendarVC?.showErrorAlert(with: "Event is not removed!")
        }
    }
}
