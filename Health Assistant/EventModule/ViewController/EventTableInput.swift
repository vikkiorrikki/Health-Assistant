//
//  EventTableDelegateForPresenter.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 01.07.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

protocol EventTableInput: class {
    func setupUI()
    func openAddEventPage(with doctorsID: UUID)
    func reloadTable()
    func deleteEvent(index: IndexPath)
    func openEventDetails(with event: Event)
}
