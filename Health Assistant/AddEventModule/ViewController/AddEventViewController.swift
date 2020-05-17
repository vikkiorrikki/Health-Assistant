//
//  AddEventViewController.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 14.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import UIKit

enum SectionType: Int {
    case main
    case dates
    case listPickers
    case note
}

enum CellType {
    case textField(String)
    case date(text: String, date:Date)
    case listPicker(text: String, value: String)
    case textView
}

class AddEventViewController: UIViewController, AddEventViewControllerDelegate {
    
    //MARK: - Properties
    
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

    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    //MARK: - Actions
    
    @IBAction func addEventButtonPressed(_ sender: UIBarButtonItem) {
//        let newEvent = Event(title: , doctorsName: , startDate: inputDates[], endDate: inputDates[], location: location, status: status)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    //MARK: - Methods
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(UINib(nibName: "TextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: "TextFieldCell")
        tableView.register(UINib(nibName: "DateTableViewCell", bundle: nil), forCellReuseIdentifier: "DateCell")
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListCell")
        tableView.register(UINib(nibName: "TextViewCell", bundle: nil), forCellReuseIdentifier: "TextViewCell")
    }
    
    //MARK: - Delegate methods
    
    func userDidSelectElement(_ element: ListTableViewControllerElement) {
        if let element = element as? Location {
            selectedLocation = element
        } else if let element = element as? EventStatus {
            selectedStatus = element
        }
    }
}

    //MARK: - UITableViewDataSource

extension AddEventViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    //MARK: - numberOfRowsInSection
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = SectionType.init(rawValue: section) else {
            return 0
        }
        return data[section]?.count ?? 0
    }
    
    //MARK: - cellForRowAt
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = SectionType.init(rawValue: indexPath.section),
            let cell = data[section]?[indexPath.row] else {
            return UITableViewCell()
        }
        
        switch cell {
        case .textField(let text):
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! TextFieldTableViewCell
            cell.textField.placeholder = text
            return cell
        case .date(let text, let date):
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath) as! DateTableViewCell
            cell.updateCell(text: text, date: date)
            return cell
            
        case .listPicker(let text, let value):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListTableViewCell
            cell.nameLabel.text = text
            cell.valueLabel.text = value
            if indexPath.row == 0 {
                cell.valueLabel.text = selectedLocation?.clinicName ?? "Select"
            } else {
                cell.valueLabel.text = selectedStatus?.rawValue.capitalized ?? EventStatus.planned.rawValue.capitalized
            }
            return cell
        case .textView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextViewCell", for: indexPath) as! TextViewCell
            return cell
        }
    }
}

//MARK: - UITableViewDelegate

extension AddEventViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let section = SectionType.init(rawValue: indexPath.section)
        
        switch section {
        case .dates:
            if let cell = tableView.cellForRow(at: indexPath) as? DateTableViewCell {
                cell.datePickerView.isHidden = !cell.datePickerView.isHidden
                tableView.beginUpdates()

                tableView.endUpdates()
                tableView.deselectRow(at: indexPath, animated: true)
            }
        case .listPickers:
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListVC") as! ListTableViewController
            controller.delegate = self
            
            if indexPath.row == 0 {
                controller.arrayData = locations
            } else {
                controller.arrayData = statuses
            }
            navigationController?.pushViewController(controller, animated: true)
        default:
            return
        }
    }
}
