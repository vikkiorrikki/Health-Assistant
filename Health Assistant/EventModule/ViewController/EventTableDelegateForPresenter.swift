//
//  EventTableDelegateForPresenter.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 01.07.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

protocol EventTableDelegateForPresenter: class {
    func openAddEventPage()
    func reloadTable()
    func deleteEvent(index: IndexPath)
    func openEventDetails(with event: Event)
}
