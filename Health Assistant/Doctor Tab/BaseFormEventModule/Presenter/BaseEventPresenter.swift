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
    
    weak var baseView: BaseEventInput?
    let storageService = StorageService()
    let locationRepository = LocationsRepository()
    
    var data: [SectionType: [CellType]] {
        [
            .main:
                [.textField(text: title, tag: .title),
                 .textField(text: doctorsName, tag: .doctorsName)],
            .dates:
                [.date(text: "Starts", date: startDate, tag: .start),
                 .date(text: "Ends", date: endDate, tag: .end)],
            .listPickers:
                [.listPicker(text: "Location", value: selectedLocation?.definition ?? "Select"),
                 .listPicker(text: "Status", value: selectedStatus?.rawValue.capitalized ?? EventStatus.planned.rawValue.capitalized)],
            .note: [.textView(notes)]
        ]
    }
    
    var locations: [Location]?
    var statuses: [EventStatus] = [.planned, .completed, .canceled]
    
    var eventId: UUID?
    var title: String?
    var doctorsName: String?
    var startDate = Date()
    var endDate = Date()
    var notes: String?
    var selectedLocation: Location?
    var selectedStatus: EventStatus?
    var locationID: Int64?
    var doctorsID: UUID!
    
    //MARK: - Methods
    
    final func viewIsReady() {
        guard let buttonTitle = setButtonTitle(), let navigationTitle = setNavigationTitle()
            else {
                return
        }
        
        baseView?.setupUI(buttonTitle: buttonTitle, navigationTitle: navigationTitle)
        baseView?.setupNotifications()
        
        initLocation()
    }
    
    private func initLocation() {
        if let locations = self.locationRepository.getCachedLocations() {
            self.locations = locations
        }
        if self.locations!.isEmpty {
            DispatchQueue.global(qos: .utility).async {
                self.locationRepository.fetchLocations {[weak self] (locations, error) in
                    if let error = error {
                        DispatchQueue.main.async {
                            self?.baseView?.showErrorAlert(with: "\(error)")
                        }
                    } else {
                        DispatchQueue.main.async {
                            self?.locations = locations!
                        }
                    }
                }
            }
        }
        
    }
    
    //MARK: - Create Event
    
    func userDidPressSaveButton() {
        assert(false, "You must override this method!")
    }
    
    // MARK: Private methods
    
    func setButtonTitle() -> String? {
        assert(false, "You must override this method!")
        return nil
    }
    
    func setNavigationTitle() -> String? {
        assert(false, "You must override this method!")
        return nil
    }
    
    //MARK: - Open List Cells
    
    final func userDidSelectCell(at indexPath: IndexPath) {
        let section = SectionType.init(rawValue: indexPath.section)
        
        switch section {
        case .dates:
            baseView?.showDatePicker(in: indexPath)
        case .listPickers:
            if indexPath.row == 0 {
                baseView?.showLocationPicker(with: locations ?? [Location](), in: indexPath)
            } else if indexPath.row == 1 {
                baseView?.showStatusPicker(with: statuses, in: indexPath)
            }
        default:
            return
        }
    }
    
    final func setSelectedElement(with element: ListTableViewControllerElement) {
        if let element = element as? Location {
            selectedLocation = element
            locationID = element.id
        } else if let element = element as? EventStatus {
            selectedStatus = element
        }
        baseView?.reloadTable()
    }
    
    //MARK: - Change Fields
    
    final func setNewValueToTextField(with text: String, tag: TextFieldTag) {
        if tag == .title {
            title = text
        } else if tag == .doctorsName {
            doctorsName = text
        }
    }
    
    final func setNewDate(with date: Date, tag: DateCellTag) {
        if tag == .start {
            startDate = date
            if endDate < startDate {
                endDate = startDate
                baseView?.reloadTable()
            }
        } else if tag == .end {
            endDate = date
        }
    }
    
    final func setNewValueToTextView(with text: String?) {
        notes = text
    }
}
