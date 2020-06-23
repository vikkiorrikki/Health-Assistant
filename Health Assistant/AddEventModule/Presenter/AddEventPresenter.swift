//
//  AddEventPresenter.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 20.06.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

class AddEventPresenter: BaseEventPresenter {
    
    override func userDidPressSaveButton() {
        guard let title = title, let doctorName = doctorsName else {
            super.delegate?.showValidationError()
            return
        }
        
        let newEvent = Event(
            title: title,
            doctorsName: doctorName,
            startDate: startDate,
            endDate: endDate,
            location: selectedLocation,
            status: selectedStatus ?? EventStatus.planned,
            note: notes)
        
        super.delegate?.eventIsCreated(with: newEvent)
    }
    
}
