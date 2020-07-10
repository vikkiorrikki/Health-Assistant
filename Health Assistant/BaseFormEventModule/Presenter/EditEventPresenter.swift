//
//  EditEventPresenter.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 15.06.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

class EditEventPresenter: BaseEventPresenter {
    
    init(event: Event) {
        super.init()
        
        self.eventId = event.id
        self.title = event.title
        self.doctorsName = event.doctorsName
        self.startDate = event.startDate!
        self.endDate = event.endDate!
        self.notes = event.note
        self.selectedStatus = event.status?.getStatus()
        self.doctorsID = event.doctorsId!
        self.locationID = event.locationId
        self.selectedLocation = event.location
        
        print(event)
    }
    
    override func setButtonTitle() -> String? {
        return "Save"
    }
    
    override func setNavigationTitle() -> String? {
        return "Edit Event"
    }
    
    override func userDidPressSaveButton() {
        
        if title == nil || title == "" || doctorsName == nil || doctorsName == "" {
            baseView?.showValidationError()
            
        } else {
            guard let eventId = self.eventId else { return }
            
            let editedTransferEvent = EventDataTransferObject(
            id: eventId,
            title: title!,
            doctorsID: doctorsID,
            doctorsName: doctorsName,
            locationID: locationID,
            startDate: startDate,
            endDate: endDate,
            status: selectedStatus ?? EventStatus.planned,
            note: notes)
            
            if storageService.updateEvent(from: editedTransferEvent) {
                let editedEvent = storageService.loadEvent(by: eventId)
                baseView?.eventIsEdited(editedEvent) 
            } else {
                baseView?.showErrorAlert()
            }
        }
    }
}
