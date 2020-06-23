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
        guard let title = title, let doctorName = doctorsName else {
            super.delegate?.showValidationError()
            return
        }
        
        let editedEvent = Event(
            title: title,
            doctorsName: doctorName,
            startDate: startDate,
            endDate: endDate,
            location: selectedLocation,
            status: selectedStatus ?? EventStatus.planned,
            note: notes)
        
        super.delegate?.eventIsEdited(editedEvent)
    }
    
    
    
}
