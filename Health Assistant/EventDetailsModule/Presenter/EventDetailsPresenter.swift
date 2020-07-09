//
//  EventDetailsPresenter.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 24.06.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

class EventDetailsPresenter {
    
    //MARK: - Properties
    
    weak var view: EventDetailsViewInput?
    private var event: Event
    let storageService = StorageService()
    
    init(event: Event) {
        self.event = event
    }
    
    //MARK: - Methods
    
    func viewIsReady(){
        view?.setUI(for: event)
        view?.setTitle(for: event)
        view?.setLocation(for: event)
    }
    
    func getLocation(by locationId: UUID) -> Location {
        return storageService.loadLocation(by: locationId)
    }
    
    func userPressedEditButton() {
        view?.openEditEventPage(for: event)
    }
    
    func updateValueForEditedEvent(_ event: Event) {
        self.event = event
        viewIsReady()
    }
    
}
