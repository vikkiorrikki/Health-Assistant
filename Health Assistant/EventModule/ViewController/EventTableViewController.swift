//
//  AppointmentTableViewController.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 18.04.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController, EventTableDelegateForPresenter {

    var presenter: EventPresenter!
    weak var delegate: DoctorsTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.eventView = self
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // load data
    }
    
    //MARK: - Input methods
    
    func reloadTable() {
        tableView.reloadData()
    }
    
    func openAddEventPage() {
        let navBar = UINavigationController()
        
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddEventVC") as! BaseEventViewController
        controller.delegateForAddEvent = self
        controller.presenter = AddEventPresenter()
        
        navBar.pushViewController(controller, animated: true)
        present(navBar, animated: true)
    }
    
    func openEventDetails(with event: Event) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventDetailsVC") as! EventDetailsViewController
        controller.delegate = self
        controller.presenter = EventDetailsPresenter(event: event)
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func deleteEvent(index: IndexPath) {
        tableView.deleteRows(at: [index], with: .fade)
    }


    // MARK: - TableView Data Source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.doctor.events.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = presenter.doctor.events[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventTableViewCell
        cell.setupCell(with: event)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let alert = UIAlertController(title: "Are you sure you want to remove Event?", message: nil, preferredStyle: .alert)
            
                alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in
                    self.presenter.userDidDeleteEvent(index: indexPath)
                }))
            
              alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
              self.present(alert, animated: true)
        }

    }
    
    // MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.userDidSelectEventCell(index: indexPath)
    }

    //MARK: - Add New Event
    
    @IBAction func addEventButtonPressed(_ sender: Any) {
        presenter.userDidPressAddEventButton()
    }
    
}

//MARK: - EventTableDelegate

extension EventTableViewController: EventTableDelegate {
    func userCreatedNewEvent(with newEvent: Event) {
        presenter.addNewEvent(with: newEvent)
    }
    
    func updateEventTable(with editedEvent: Event) {
        presenter.updateEventValue(with: editedEvent)
    }
}
