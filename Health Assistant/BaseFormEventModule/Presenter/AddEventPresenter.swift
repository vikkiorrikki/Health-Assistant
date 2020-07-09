//
//  AddEventPresenter.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 20.06.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

class AddEventPresenter: BaseEventPresenter {
    
    init(doctorsID: UUID) {
        super.init()
        self.doctorsID = doctorsID
    }
    
    override func setButtonTitle() -> String? {
        "Add"
    }
    
    override func setNavigationTitle() -> String? {
        "New Event"
    }
    
    override func userDidPressSaveButton() {
        
        if title == nil || title == "" || doctorsName == nil || doctorsName == "" {
            baseView?.showValidationError()
            
        } else {
            let newEvent = EventDataTransferObject(
                title: title!,
                doctorsID: doctorsID,
                doctorsName: doctorsName,
                locationID: locationID,
                startDate: startDate,
                endDate: endDate,
                status: selectedStatus ?? EventStatus.planned,
                note: notes)

//            let newEvent = Event(
//                title: title!,
//                doctorsName: doctorsName!,
//                startDate: startDate,
//                endDate: endDate,
//                location: selectedLocation,
//                status: selectedStatus ?? EventStatus.planned,
//                note: notes)
            print("before")
            storageService.addEvent(from: newEvent)
            print("in")
            baseView?.eventIsCreated()
            print("after")
        }
    }
    
}
