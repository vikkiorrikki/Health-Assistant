//
//  Event.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 08.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import  Foundation

enum EventStatus: String, CaseIterable {
    case planned
    case completed
    case canceled
}

extension EventStatus: ListTableViewControllerElement {
    var elementName: String {
        return self.rawValue.capitalized
    }
}
