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
        
        self.title = event.title
        self.doctorsName = event.doctorsName
        self.startDate = event.startDate
        self.endDate = event.endDate
        self.notes = event.note
        self.selectedLocation = event.location
        self.selectedStatus = event.status
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
            let editedEvent = Event(
                title: title!,
                doctorsName: doctorsName!,
                startDate: startDate,
                endDate: endDate,
                location: selectedLocation,
                status: selectedStatus ?? EventStatus.planned,
                note: notes)
            
            baseView?.eventIsEdited(editedEvent)
        }
    }
    
    
    
}
