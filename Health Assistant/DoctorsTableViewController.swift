//
//  DoctorsTableViewController.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 18.04.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import UIKit

struct Doctor {
    var id: UUID
    var name: String
    var appointments: [Appointment]
}

struct Appointment {
    var name: String
}

class DoctorsTableViewController: UITableViewController {

    var doctorsArray: [Doctor] = [
        Doctor(id: UUID(), name: "Name", appointments: [Appointment(name: "today"), Appointment(name: "tomorrow")]),
        Doctor(id: UUID(), name: "Name11", appointments: [Appointment(name: "hello"), Appointment(name: "goodbye")])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return doctorsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorCell", for: indexPath)

        cell.textLabel?.text = doctorsArray[indexPath.row].name

        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            doctorsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let doctor = doctorsArray[indexPath.row]
        
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppointmentVC") as! AppointmentTableViewController
        controller.doctor = doctor
        
        navigationController?.pushViewController(controller, animated: true)
    }

    //MARK: - Add New Doctor
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Doctor", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Doctor", style: .default) { (action) in
            //what will happen once the user clicks the Add Doctor button on UIAlert
            if let newTextOfDoctor = textField.text {
                self.doctorsArray.append(Doctor(id: UUID(), name: newTextOfDoctor, appointments: []))
                self.tableView.reloadData()
            } else {
                //how to do when nothing happens by clicking on button
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Doctor"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
