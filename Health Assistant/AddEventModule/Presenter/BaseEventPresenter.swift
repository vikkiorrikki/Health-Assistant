//
//  AddEventPresenter.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 17.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

class BaseEventPresenter {
    
    //MARK: - Data
    
    init(event: Event?) {
        if let editEvent = event {
            self.event = editEvent
            title = editEvent.title
            doctorsName = editEvent.doctorsName
            startDate = editEvent.startDate as! Date
            endDate = editEvent.endDate as! Date
            notes = editEvent.note
            selectedLocation = editEvent.location
            selectedStatus = editEvent.status
        }
    }
    
    weak var delegate: AddEventViewController?
    var event: Event?
    
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
    
    //MARK: - Methods
    
    func setupUI() {
        delegate?.setupUI()
    }
    
    //MARK: - Create Event
    
    func userDidPressSaveButton() {
        assert(false, "You must override this method!")
    }
    
    //MARK: - Open List Cells
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
    
    //MARK: - Change Fields
    
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
