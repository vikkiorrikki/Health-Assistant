//
//  AddEventViewControllerDelegate.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 16.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

protocol BaseEventDelegate: class {
    func userDidSelectElement(with element: ListTableViewControllerElement)
}
