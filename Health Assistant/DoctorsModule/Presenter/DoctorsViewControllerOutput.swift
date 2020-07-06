//
//  DoctorsPresenterProtocol.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 08.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

protocol DoctorsViewControllerOutput: class {
    var doctorsView: DoctorViewControllerInput? { get set }
    var doctors: [Doctor] { get }
    
    func viewIsReady()
    func userDidPressAddButton()
    func userDidCreateDoctor(specialization: String?)
    func userDidDeleteCell(index: IndexPath)
    func userDidSelectDoctorCell(with index: IndexPath)
}
