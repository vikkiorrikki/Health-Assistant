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
    weak var delegate: EventTableDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorMessage: UILabel!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        presenter.setupUI()
    }
    
    //MARK: - Actions
    
    @IBAction func addEventButtonPressed(_ sender: UIBarButtonItem) {
        presenter.userDidPressSaveButton()
    }
    
    func checkRequiredFields(title: String?, doctorsName: String?) {
        guard let titleEvent = title, let doctor = doctorsName
            else {
                errorMessage.isHidden = false
                errorMessage.text = "Required fields: Title, Doctor's Name"
                return
        }
        
        presenter.createNewEvent(title: titleEvent, doctorsName: doctor)
    }
    
    func eventIsCreated(with name: Event) {
        delegate?.userCreatedNewEvent(with: name)
        self.dismiss(animated: true)
        print(name)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    //MARK: - Input Methods
    
    func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(UINib(nibName: "TextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: "TextFieldCell")
        tableView.register(UINib(nibName: "DateTableViewCell", bundle: nil), forCellReuseIdentifier: "DateCell")
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListCell")
        tableView.register(UINib(nibName: "TextViewCell", bundle: nil), forCellReuseIdentifier: "TextViewCell")
    }
    
    func showDatePicker(in indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? DateTableViewCell {
            UIView.setAnimationsEnabled(false)
            tableView.beginUpdates()
            cell.datePickerView.isHidden = !cell.datePickerView.isHidden
            
            tableView.endUpdates()
            tableView.deselectRow(at: indexPath, animated: true)
            UIView.setAnimationsEnabled(true)
        }
    }
    
    func showLocationPicker(with locations: [Location], in indexPath: IndexPath) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListVC") as! ListTableViewController
        controller.delegate = self
        controller.setupListVC(with: locations, in: indexPath)
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func showStatusPicker(with statuses: [EventStatus], in indexPath: IndexPath) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListVC") as! ListTableViewController
        controller.delegate = self
        controller.setupListVC(with: statuses, in: indexPath)
        
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
            let cellType = presenter.data[section]?[indexPath.row] else {
            return UITableViewCell()
        }
        
        switch cellType {
        case .textField(let text, let tag):
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! TextFieldTableViewCell
            cell.delegate = self
            cell.updateCell(with: text, tag: tag)
            return cell
            
        case .date(let text, let date, let tag):
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath) as! DateTableViewCell
            cell.delegate = self
            cell.updateCell(text: text, date: date, tag: tag)
            return cell
            
        case .listPicker(let text, let value):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListTableViewCell
            cell.nameLabel.text = text
            cell.valueLabel.text = value
            return cell
            
        case .textView(let text):
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextViewCell", for: indexPath) as! TextViewCell
            cell.delegate = self
            cell.updateCell(with: text)
            return cell
        }
    }
}

//MARK: - UITableViewDelegate

extension AddEventViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.userDidSelectCell(at: indexPath)
    }
}
//MARK: - AddEventDelegate

extension AddEventViewController: AddEventDelegate {
    func userDidSelectElement(with element: ListTableViewControllerElement, in index: IndexPath) {
        presenter.userDidSelectElement(with: element, in: index)
    }
}
//MARK: - TextFieldDelegate

extension AddEventViewController: TextFieldDelegate {
    func userDidChangeTextField(with text: String, tag: TextFieldTag) {
        presenter.userDidChangeTextField(with: text, tag: tag)
    }

}
//MARK: - DateCellDelegate

extension AddEventViewController: DateCellDelegate {
    func userDidChangeDate(with date: Date, tag: DateCellTag) {
        presenter.userDidChangeDate(with: date, tag: tag)
    }
}
//MARK: - TextViewDelegate

extension AddEventViewController: TextViewDelegate {
    func userDidChangeTextView(with text: String) {
        presenter.userDidChangeTextView(with: text)
    }
}
