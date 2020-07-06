//
//  AddEventViewController.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 14.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import UIKit

class BaseEventViewController: UIViewController, BaseEventInput {
    
    //MARK: - Properties
    
    var presenter: BaseEventPresenter!
    
    weak var delegateForAddEvent: AddEventDelegate?
    weak var delegateForEditEvent: EventDetailsViewDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var navItem: UINavigationItem!
    
    //MARK: - Life Cycle
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.baseView = self
        presenter.viewDidLoad()
    }
    
    //MARK: - IBActions
    
    @IBAction func addEventButtonPressed(_ sender: UIBarButtonItem) {
        presenter.userDidPressSaveButton()
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    //MARK: - Input Methods
    
    func setupUI(buttonTitle: String, navigationTitle: String) {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: "TextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: "TextFieldCell")
        tableView.register(UINib(nibName: "DateTableViewCell", bundle: nil), forCellReuseIdentifier: "DateCell")
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListCell")
        tableView.register(UINib(nibName: "TextViewCell", bundle: nil), forCellReuseIdentifier: "TextViewCell")
        
        saveButton.title = buttonTitle
        navItem.title = navigationTitle
    }
    
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
        controller.presenter = ListPresenter()
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func reloadRow(indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    //MARK: - Actions With Event
    
    func showValidationError() {
        errorMessage.isHidden = false
        errorMessage.text = "Required fields: Title, Doctor's Name"
    }
    
    func eventIsCreated(with name: Event) {
        delegateForAddEvent?.userAddedNewEvent(name)
        self.dismiss(animated: true)
        print(name)
    }
    
    func eventIsEdited(_ event: Event) {
        delegateForEditEvent?.userEditedEvent(event)
        self.dismiss(animated: true)
        print(event)
    }
    
    //MARK: - Keybords Methods
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        let userInfo = notification.userInfo!
        if let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(
                            top: 0,
                            left: 0,
                            bottom: keyboardScreenEndFrame.height,
                            right: 0
            )
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        tableView.contentInset = UIEdgeInsets()
    }
}

//MARK: - UITableViewDataSource

extension BaseEventViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return (presenter.data.count)
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
            cell.updateCell(text: text, tag: tag, delegate: self)
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
            cell.updateCell(with: text, delegate: self)
            return cell
        }
    }
}

//MARK: - UITableViewDelegate

extension BaseEventViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.userDidSelectCell(at: indexPath)
    }
}
//MARK: - AddEventDelegate

extension BaseEventViewController: BaseEventDelegate {
    func userDidSelectElement(with element: ListTableViewControllerElement, in index: IndexPath) {
        presenter.setSelectedElement(with: element, in: index)
    }
}
//MARK: - TextFieldDelegate

extension BaseEventViewController: TextFieldDelegate {
    func userDidChangeTextField(with text: String, tag: TextFieldTag) {
        presenter.setNewValueToTextField(with: text, tag: tag)
    }

}
//MARK: - DateCellDelegate

extension BaseEventViewController: DateCellDelegate {
    func userDidChangeDate(with date: Date, tag: DateCellTag) {
        presenter.setNewDate(with: date, tag: tag)
    }
}
//MARK: - TextViewDelegate

extension BaseEventViewController: TextViewDelegate {
    func userDidChangeTextView(with text: String?) {
        presenter.setNewValueToTextView(with: text)
    }
}
