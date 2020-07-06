//
//  EventTableDelegate.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 02.06.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

protocol EditEventDelegate: class {
    func updateEventTable(with editedEvent: Event) //for EventDetailsVC
}
