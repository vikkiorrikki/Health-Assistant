//
//  EventPresenter.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 08.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

class EventPresenter {
    
    weak var eventView: EventTableViewController?
    
    var doctor: Doctor?
    var event: Event?
    
    func userDidPressAddEventButton() {
        eventView?.userDidPressAddEventButton()
    }
    
    func userCreatedNewEvent(with newEvent: Event) {
        doctor?.events.append(newEvent)
        eventView?.reloadTable()
    }
    
    func updateEventTable(with editedEvent: Event) {
        event = editedEvent
        eventView?.reloadTable()
    }
    
    func userDidSelectEventCell(index: IndexPath) {
        eventView?.userDidSelectEventCell(with: index)
        event = doctor?.events[index.row]
    }

}
