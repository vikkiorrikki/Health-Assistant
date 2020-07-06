//
//  DoctorsPresenter.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 07.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

class DoctorsPresenter: DoctorsViewControllerOutput {
    
    weak var doctorsView: DoctorViewControllerInput?
    
    let storageService = StorageService()
    
    
    var doctors = [Doctor]() {
        didSet {
            doctorsView?.reloadTableView()
        }
    }
//    var doctors: [Doctor] = [] what's difference?
    
    
    func viewIsReady() {
        doctorsView?.setupUI()
        doctors = storageService.loadDoctors()
    }
    
    func userDidPressAddButton() {
        doctorsView?.showNewDoctorAlert()
    }
    
    func userDidCreateDoctor(specialization: String?) {
        
        storageService.addDoctor()
        
        if let newTextOfDoctor = specialization, !newTextOfDoctor.isEmpty {
            let newDoctor = Doctor(context: storageService.context)
            newDoctor.id = UUID()
            newDoctor.specialization = newTextOfDoctor
            
            storageService.addDoctor()
            doctors = storageService.loadDoctors()
            
            //doctors.append(newDoctor)
            
            
        }
    }
    
    func userDidDeleteCell(index: IndexPath) {
        //storageService.removeDoctor()
        
        doctors.remove(at: index.row)
        doctorsView?.deleteDoctor(index: index)
    }
    
    func userDidSelectDoctorCell(with index: IndexPath) {
        let doctor = doctors[index.row]
        doctorsView?.openEvents(of: doctor) 
    }
}
