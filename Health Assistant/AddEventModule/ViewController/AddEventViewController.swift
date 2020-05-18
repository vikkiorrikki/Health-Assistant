//
//  AddEventViewController.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 14.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {
    
    //MARK: - Properties
    
    let presenter = AddEventPresenter()
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        setupTableView()
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
    //MARK: - Input Methods
    
    func setupVisibleDatePicker(in indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? DateTableViewCell {
            cell.datePickerView.isHidden = !cell.datePickerView.isHidden
            tableView.beginUpdates()

            tableView.endUpdates()
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func setupListPicker(in indexPath: IndexPath) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListVC") as! ListTableViewController
        controller.presenter.delegate = self
        
        if indexPath.row == 0 {
            controller.presenter.arrayData = presenter.locations
            controller.presenter.listCellIndexPath = indexPath
        } else {
            controller.presenter.arrayData = presenter.statuses
            controller.presenter.listCellIndexPath = indexPath
        }
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func reloadRow(indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

    //MARK: - UITableViewDataSource

extension AddEventViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.data.count
    }
    
    //MARK: - numberOfRowsInSection
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = SectionType.init(rawValue: section) else {
            return 0
        }
        return presenter.data[section]?.count ?? 0
    }
    
    //MARK: - cellForRowAt
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = SectionType.init(rawValue: indexPath.section),
            let cell = presenter.data[section]?[indexPath.row] else {
            return UITableViewCell()
        }
        
        switch cell {
        case .textField(let text):
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! TextFieldTableViewCell
            cell.updateCell(with: text)
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
                cell.valueLabel.text = presenter.selectedLocation?.clinicName ?? "Select"
            } else {
                cell.valueLabel.text = presenter.selectedStatus?.rawValue.capitalized ?? EventStatus.planned.rawValue.capitalized
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
        presenter.userDidSelectCell(with: indexPath)
    }
}
