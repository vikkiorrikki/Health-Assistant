//
//  EventPresenter.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 08.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

class EventPresenter {
    
    //MARK: - Properties
    
    weak var eventView: EventTableInput?
    let storageService = StorageService()
    
    var doctorID: UUID
    var events = [Event]() {
        didSet {
            eventView?.reloadTable()
        }
    }
    
    //MARK: - Methods
    
    init(doctorID: UUID) {
        self.doctorID = doctorID
    }
    
    func viewIsReady() {
        eventView?.setupUI()
    }
    
    func updateEvents() {
        events = storageService.loadEvents(with: doctorID)
    }
    
    func userDidPressAddEventButton() {
        eventView?.openAddEventPage(with: doctorID)
    }
    
    func userDidDeleteEvent(index: IndexPath) {
        storageService.removeEvent(events[index.row])
        events = storageService.loadEvents(with: doctorID)
    }
    
    func userDidSelectEventCell(index: IndexPath) {
        let event = events[index.row]
        eventView?.openEventDetails(with: event)
    }

}
