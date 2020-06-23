//
//  EventPresenter.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 08.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

class EventPresenter {
    
    weak var delegate: EventTableViewController?
    
    var doctor: Doctor?
    var event: Event?
    
    func userDidPressAddEventButton() {
        delegate?.userDidPressAddEventButton()
    }
    
    func userCreatedNewEvent(with newEvent: Event) {
        doctor?.events.append(newEvent)
        delegate?.reloadTable()
    }
    
    func updateEventTable(with editedEvent: Event) {
        event = editedEvent
        delegate?.reloadTable()
    }
    
    func userDidSelectEventCell(index: IndexPath) {
        delegate?.userDidSelectEventCell(with: index)
        event = doctor?.events[index.row]
    }

}
