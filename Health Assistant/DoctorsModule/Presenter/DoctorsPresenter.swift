//
//  DoctorsPresenter.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 07.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

class DoctorsPresenter: DoctorsViewControllerOutput {
    
    //MARK: - Properties
    
    weak var doctorsView: DoctorViewControllerInput?
    let storageService = StorageService()
    
    var doctors = [Doctor]() {
        didSet {
            doctorsView?.reloadTableView()
        }
    }
    
    //MARK: - Methods
    
    func viewIsReady() {
        doctorsView?.setupUI()
        doctors = storageService.loadDoctors()
    }
    
    func userDidPressAddButton() {
        doctorsView?.showNewDoctorAlert()
    }
    
    func userDidCreateDoctor(specialization: String?) {
        guard let specialization = specialization else { return }
        
        storageService.addDoctor(with: specialization)
        doctors = storageService.loadDoctors()
    }
    
    func userDidDeleteCell(index: IndexPath) {
        storageService.removeDoctor(doctors[index.row])
        doctors = storageService.loadDoctors()
        
        doctorsView?.deleteDoctor(index: index)
    }
    
    func userDidSelectDoctorCell(with index: IndexPath) {
        let doctor = doctors[index.row]
        doctorsView?.openEvents(of: doctor) 
    }
}
