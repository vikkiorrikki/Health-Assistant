//
//  EventDetailsViewDelegate.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 24.06.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

protocol EventDetailsViewInput: class {
    func setUI(for event: Event)
    func setTitle(for event: Event)
    func setLocation(for event: Event)
    func openEditEventPage(for event: Event)
}
