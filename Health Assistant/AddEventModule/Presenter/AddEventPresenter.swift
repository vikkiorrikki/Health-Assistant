//
//  AddEventPresenter.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 17.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

class AddEventPresenter: AddEventPresenterProtocol {
    
    weak var delegate: AddEventViewController?
    
    let data: [SectionType: [CellType]] =
    [
        .main: [.textField("Title"), .textField("Doctors Name")],
        .dates:
            [.date(text: "Starts", date: Date()),
            .date(text: "Ends", date: Date())],
        .listPickers:
            [.listPicker(text: "Location", value: "Selected"),
             .listPicker(text: "Status", value: "Selected")],
        .note: [.textView]
    ]
    
    let locations = [Location(clinicName: "Saint Petersburg", street: "Nevskiy", houseNumber: 1),
                    Location(clinicName: "Moscow", street: "Nevskiy", houseNumber: 2),
                    Location(clinicName: "Abakan", street: "Nevskiy", houseNumber: 3)
    ]
    var statuses: [EventStatus] = [.planned, .completed, .canceled]
    
    var selectedLocation: Location?
    var selectedStatus: EventStatus?
    
    func userDidSelectCell(with indexPath: IndexPath) {
        let section = SectionType.init(rawValue: indexPath.section)
        
        switch section {
        case .dates:
            delegate?.setupVisibleDatePicker(in: indexPath)
        case .listPickers:
            delegate?.setupListPicker(in: indexPath)
        default:
            return
        }
    }
    
//    func sentData(to controller: UIViewController) {
//
//    }
    
    func userDidSelectElement(_ element: ListTableViewControllerElement) {
        if let element = element as? Location {
            selectedLocation = element
        } else if let element = element as? EventStatus {
            selectedStatus = element
        }
    }
    
}
