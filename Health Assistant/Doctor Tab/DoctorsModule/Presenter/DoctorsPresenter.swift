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
        if let doctors = storageService.loadDoctors() {
            self.doctors = doctors
        } else {
            doctorsView?.showErrorAlert(with: "Doctors are not loaded!")
        }
    }
    
    func userDidPressAddButton() {
        doctorsView?.showNewDoctorAlert()
    }
    
    func userDidCreateDoctor(specialization: String?) {
        guard let specialization = specialization else { return }
        
        if storageService.addDoctor(with: specialization) {
            if let doctors = storageService.loadDoctors() {
                self.doctors = doctors
            } else {
                doctorsView?.showErrorAlert(with: "Doctors are not loaded!")
            }
        } else {
            doctorsView?.showErrorAlert(with: "Doctor is not added!")
        }
        
    }
    
    func userDidDeleteCell(index: IndexPath) {
        if storageService.removeDoctor(doctors[index.row]) {
            if let doctors = storageService.loadDoctors() {
                self.doctors = doctors
            } else {
                doctorsView?.showErrorAlert(with: "Doctors are not loaded!")
            }
        } else {
            doctorsView?.showErrorAlert(with: "Doctor is not removed!")
        }
        
    }
    
    func userDidSelectDoctorCell(with index: IndexPath) {
        let doctor = doctors[index.row]
        doctorsView?.openEvents(of: doctor) 
    }
}
