//
//  EventPresenter.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 08.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

class EventPresenter {
    
    weak var eventView: EventTableInput?
    
    var doctor: Doctor
    
    init(doctor: Doctor) {
        self.doctor = doctor
    }
    
    func userDidPressAddEventButton() {
        eventView?.openAddEventPage()
    }
    
    func addNewEvent(with newEvent: Event) {
        doctor.events.append(newEvent)
        eventView?.reloadTable()
    }
    
    func updateEventValue(with editedEvent: Event) {
//        event = editedEvent
        eventView?.reloadTable()
    }
    
    func userDidDeleteEvent(index: IndexPath) {
        doctor.events.remove(at: index.row)
        eventView?.deleteEvent(index: index)
    }
    
    func userDidSelectEventCell(index: IndexPath) {
        let event = doctor.events[index.row]
        eventView?.openEventDetails(with: event)
    }

}
