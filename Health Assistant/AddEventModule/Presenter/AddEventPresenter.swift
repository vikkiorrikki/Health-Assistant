//
//  AddEventPresenter.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 17.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

class AddEventPresenter {
    
    weak var delegate: AddEventViewController?
    
    var data: [SectionType: [CellType]] {
        [
            .main: [.textField(text: title ?? "Title", tag: .title), .textField(text: doctorsName ?? "Doctors Name", tag: .doctorsName)],
            .dates:
                [.date(text: "Starts", date: startDate, tag: .Start),
                 .date(text: "Ends", date: endDate, tag: .End)],
            .listPickers:
                [.listPicker(text: "Location", value: selectedLocation?.clinicName ?? "Select"),
                 .listPicker(text: "Status", value: selectedStatus?.rawValue.capitalized ?? EventStatus.planned.rawValue.capitalized)],
            .note: [.textView(notes ?? "Notes")]
        ]
    }
    
    let locations = [Location(clinicName: "Saint Petersburg", street: "Nevskiy", houseNumber: 1),
                    Location(clinicName: "Moscow", street: "Nevskiy", houseNumber: 2),
                    Location(clinicName: "Abakan", street: "Nevskiy", houseNumber: 3)
    ]
    var statuses: [EventStatus] = [.planned, .completed, .canceled]
    
    
    var title: String?
    var doctorsName: String?
    var startDate = Date()
    var endDate = Date()
    var notes: String?
    var selectedLocation: Location?
    var selectedStatus: EventStatus?
    
    func setupUI(){
        delegate?.setupUI()
    }
    
    func userDidPressSaveButton() -> Event {
        guard let titleEvent = title, let doctor = doctorsName, let location = selectedLocation, let status = selectedStatus, let note = notes
            else {
                print("Not all field are filled")
                return Event(title: "", doctorsName: "", startDate: Date(), endDate: Date(), location: Location(clinicName: "", street: "", houseNumber: 0), status: .planned, note: "")
        }

        let newEvent = Event(
            title: titleEvent,
            doctorsName: doctor,
            startDate: startDate,
            endDate: endDate,
            location: location,
            status: status,
            note: note
        )
        
//        let newEvent = Event(title: title, doctorsName: doctorsName, startDate: startDate, endDate: endDate, location: selectedLocation, status: selectedStatus, note: notes)
        print(newEvent)
        return newEvent
        
    }
    
    func userDidSelectCell(at indexPath: IndexPath) {
        let section = SectionType.init(rawValue: indexPath.section)
        
        switch section {
        case .dates:
            delegate?.showDatePicker(in: indexPath)
        case .listPickers:
            if indexPath.row == 0 {
                delegate?.showLocationPicker(with: locations, in: indexPath)
            } else if indexPath.row == 1 {
                delegate?.showStatusPicker(with: statuses, in: indexPath)
            }
        default:
            return
        }
    }
 
    func userDidSelectElement(with element: ListTableViewControllerElement, in index: IndexPath) {
        if let element = element as? Location {
            selectedLocation = element
        } else if let element = element as? EventStatus {
            selectedStatus = element
        }
        delegate?.reloadRow(indexPath: index)
    }
    
    func userDidChangeTextField(with text: String, tag: TextFieldTag) {
        if tag == .title {
            title = text
        } else if tag == .doctorsName {
            doctorsName = text
        }
    }
    
    func userDidChangeDate(with date: Date, tag: DateCellTag) {
        if tag == .Start {
            startDate = date
        } else if tag == .End {
            endDate = date
        }
    }
    
    func userDidChangeTextView(with text: String) {
        notes = text
    }
}
