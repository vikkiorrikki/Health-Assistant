//
//  BaseEventInput.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 02.07.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

protocol BaseEventInput: class {
    func setupUI(buttonTitle: String, navigationTitle: String)
    func setupNotifications()
    func showDatePicker(in indexPath: IndexPath)
    func showLocationPicker(with locations: [Location], in indexPath: IndexPath)
    func showStatusPicker(with statuses: [EventStatus], in indexPath: IndexPath)
    func reloadRow(indexPath: IndexPath)
    func showValidationError()
    func eventIsCreated(with name: EventDataTransferObject)
    func eventIsEdited(_ event: Event)
}
