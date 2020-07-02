//
//  DoctorViewControllerProtocol.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 08.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

protocol DoctorViewControllerDelegate: class {
    func showNewDoctorAlert()
    func reloadTableView()
    func deleteDoctor(index: IndexPath)
    func openEvents(of doctor: Doctor)
}


