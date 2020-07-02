//
//  ListTableDelegate.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 30.06.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

protocol ListTableDelegate: class {
    func showSelectedElement(with element: ListTableViewControllerElement, in index: IndexPath)
}
