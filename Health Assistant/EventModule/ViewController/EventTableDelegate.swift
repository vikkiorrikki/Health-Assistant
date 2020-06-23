//
//  EventTableDelegate.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 02.06.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

protocol EventTableDelegate: class {
    func userCreatedNewEvent(with newEvent: Event)
    func updateEventTable(with editedEvent: Event)
    func reloadTable()
}
