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
        
        if title == nil || title == "" || doctorsName == nil || doctorsName == "" {
            addView?.showValidationError()
            
        } else {
            let newEvent = Event(
                title: title!,
                doctorsName: doctorsName!,
                startDate: startDate,
                endDate: endDate,
                location: selectedLocation,
                status: selectedStatus ?? EventStatus.planned,
                note: notes)
            
            addView?.eventIsCreated(with: newEvent)
        }
    }
    
}
