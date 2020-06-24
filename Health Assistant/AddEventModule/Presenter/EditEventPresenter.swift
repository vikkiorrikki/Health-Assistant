//
//  EditEventPresenter.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 15.06.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

class EditEventPresenter: BaseEventPresenter {
    
    override func userDidPressSaveButton() {
        
        if title == nil || title == "" || doctorsName == nil || doctorsName == "" {
            addView?.showValidationError()
            
        } else {
            let editedEvent = Event(
                title: title!,
                doctorsName: doctorsName!,
                startDate: startDate,
                endDate: endDate,
                location: selectedLocation,
                status: selectedStatus ?? EventStatus.planned,
                note: notes)
            
            addView?.eventIsEdited(editedEvent)
        }
    }
    
    
    
}
