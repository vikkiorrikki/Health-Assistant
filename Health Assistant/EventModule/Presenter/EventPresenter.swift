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
    
    func getDoctorName() -> String? {
        guard let doctorName = storageService.loadDoctor(by: doctorID)?.specialization
            else {
                return nil
        }
        return doctorName
    }
    
    func viewIsReady() {
        eventView?.setupUI()
    }
    
    func updateEvents() {
        if let events = storageService.loadEvents(by: doctorID) {
            self.events = events
        } else {
            eventView?.showErrorAlert(with: "Events are not loaded!")
        }
    }
    
    func userDidPressAddEventButton() {
        eventView?.openAddEventPage(with: doctorID)
    }
    
    func userDidDeleteEvent(index: IndexPath) {
        if storageService.removeEvent(events[index.row]) {
            if let events = storageService.loadEvents(by: doctorID) {
                self.events = events
            } else {
                eventView?.showErrorAlert(with: "Events are not loaded!")
            }
        } else {
            eventView?.showErrorAlert(with: "Event is not removed!")
        }
        
    }
    
    func userDidSelectEventCell(index: IndexPath) {
        let event = events[index.row]
        eventView?.openEventDetails(with: event)
    }

}
