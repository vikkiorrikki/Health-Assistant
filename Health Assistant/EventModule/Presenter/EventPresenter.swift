//
//  EventPresenter.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 08.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

class EventPresenter {
    
    weak var delegate: EventTableViewController?
    
    var doctor: Doctor?
    
    func userCreatedNewEvent(with newEvent: Event) {
        doctor?.events.append(newEvent)
        delegate?.reloadTeble()
    }

}
