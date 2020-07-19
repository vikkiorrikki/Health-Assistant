//
//  CalendarInput.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 16.07.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

protocol CalendarInput: class {
    func setupUI()
    func reloadTableView()
    func openEventDetails(of event: Event)
    func showErrorAlert(with message: String)
    func updateCalendar()
}
