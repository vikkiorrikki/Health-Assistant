//
//  DoctorsPresenter.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 07.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

class DoctorsPresenter: DoctorsPresenterProtocol {
    
    weak var delegate: DoctorViewControllerProtocol?
    
    var doctorsArray = [
        Doctor(
            id: UUID(),
            specialization: "Name",
            events:
            [
                Event(title: "today", doctorsName: "Name", startDate: Date(), endDate: Date(), location: "", status: .planned),
                Event(title: "tomorrow", doctorsName: "Name", startDate: Date(), endDate: Date(), location: "", status: .completed)
            ]
        ),
        Doctor(
            id: UUID(),
            specialization: "Name11",
            events:
            [
                Event(title: "hello", doctorsName: "Name", startDate: Date(), endDate: Date(), location: "", status: .canceled),
                Event(title: "goodbye", doctorsName: "Name", startDate: Date(), endDate: Date(), location: "", status: .planned)
            ]
        )
    ]
    
    func userDidPressAddButton() {
        delegate?.showNewDoctorAlert()
    }
    
    func userDidCreateDoctor(name: String?) {
        if let newTextOfDoctor = name, !newTextOfDoctor.isEmpty {
            let newDoctor = Doctor(
                id: UUID(),
                specialization: newTextOfDoctor,
                events: []
            )
            doctorsArray.append(newDoctor)
            delegate?.reloadTableView()
        }
    }
    
    func userDidDeleteCell(index: IndexPath) {
        doctorsArray.remove(at: index.row)
        delegate?.deleteRow(index: index)
    }
    
    func userDidSelectDoctorCell(with index: IndexPath) {
        let doctor = doctorsArray[index.row]
        delegate?.openEvents(of: doctor) 
    }
}
