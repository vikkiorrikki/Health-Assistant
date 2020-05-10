//
//  DoctorViewControllerProtocol.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 08.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import UIKit

protocol DoctorViewControllerProtocol: class {
    func showNewDoctorAlert()
    func reloadTableView()
    func deleteRow(index: IndexPath)
    func createEventController() -> EventTableViewController
    func pushViewControllerToNavigationController(with controller: UITableViewController)
}
