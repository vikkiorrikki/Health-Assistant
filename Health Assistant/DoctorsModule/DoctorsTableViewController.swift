//
//  DoctorsTableViewController.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 18.04.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import UIKit

class DoctorsTableViewController: UITableViewController, DoctorViewControllerProtocol {

    let presenter: DoctorsPresenterProtocol = DoctorsPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.delegate = self
        
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Input methods
    
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
                self.presenter.userDidCreateDoctor(name: textField.text)
            }
        )
        
        present(alert, animated: true, completion: nil)
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func deleteRow(index: IndexPath) {
        tableView.deleteRows(at: [index], with: .fade)
    }
    
    func createEventController() -> EventTableViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventVC") as! EventTableViewController
    }
    
    func pushViewControllerToNavigationController(with controller: UITableViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return presenter.doctorsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorCell", for: indexPath)
        cell.textLabel?.text = presenter.doctorsArray[indexPath.row].specialization

        return cell
    }
    
    // Override to support editing the table view.
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
        presenter.userOpenedEvents(with: indexPath)
    }

    //MARK: - Add New Doctor
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        presenter.userDidPressAddButton()
    }
}