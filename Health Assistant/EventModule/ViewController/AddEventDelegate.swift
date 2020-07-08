//
//  AddEventDelegate.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 03.07.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

protocol AddEventDelegate: class {
    func userAddedNewEvent(_ event: EventDataTransferObject) //for BaseEventVC
}
