//
//  DoctorsTableViewController.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 18.04.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import UIKit

class DoctorsTableViewController: UITableViewController, DoctorViewControllerInput {

    let presenter: DoctorsViewControllerOutput = DoctorsPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.doctorsView = self
        presenter.viewIsReady()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(presenter.doctors)
    }
    
    // MARK: - Input methods
    
    func setupUI() {
        tableView.tableFooterView = UIView()
    }
    
    func showNewDoctorAlert() {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Doctor", message: "", preferredStyle: .alert)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Doctor"
            textField = alertTextField
        }
        alert.addAction(
            UIAlertAction(title: "Cancel", style: .cancel)
        )
        alert.addAction(
            UIAlertAction(title: "Add Doctor", style: .default) { (action) in
                self.presenter.userDidCreateDoctor(specialization: textField.text)
            }
        )
        
        present(alert, animated: true, completion: nil)
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func showErrorAlert(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    func openEvents(of doctor: Doctor) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventVC") as! EventTableViewController
        controller.delegate = self
        controller.presenter = EventPresenter(doctorID: doctor.id!)
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.doctors.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorCell", for: indexPath)
        cell.textLabel?.text = presenter.doctors[indexPath.row].specialization

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let alert = UIAlertController(title: "Are you sure you want to remove Doctor?", message: nil, preferredStyle: .alert)
            
                alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in
                    self.presenter.userDidDeleteCell(index: indexPath)
                }))
            
              alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
              self.present(alert, animated: true)
        }

    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.userDidSelectDoctorCell(with: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    //MARK: - Add New Doctor
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        presenter.userDidPressAddButton()
    }
}
