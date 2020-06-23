//
//  DoctorsPresenterProtocol.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 08.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

protocol DoctorsPresenterDelegate: class {
    var delegate: DoctorViewControllerDelegate? { get set }
    var doctorsArray: [Doctor] { get }
    
    func userDidPressAddButton()
    func userDidCreateDoctor(name: String?)
    func userDidDeleteCell(index: IndexPath)
    func userDidSelectDoctorCell(with index: IndexPath)
}
