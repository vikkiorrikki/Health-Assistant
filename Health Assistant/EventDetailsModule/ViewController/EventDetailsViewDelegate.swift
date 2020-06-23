//
//  EventDetailsViewDelegate.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 24.06.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

protocol EventDetailsViewDelegate: class {
    func setUI(for event: Event)
    func setTitleColor(for event: Event)
    func userPressedEditButton(for event: Event)
    func updateEventTable(with editedEvent: Event)
}
