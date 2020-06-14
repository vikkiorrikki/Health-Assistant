//
//  AppointmentTableViewController.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 18.04.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController {

    let presenter = EventPresenter()
    weak var delegate: DoctorsTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    //MARK: - Input methods
    
    func reloadTable() {
        tableView.reloadData()
    }
    
    func userDidPressAddEventButton() {
        let navBar = UINavigationController()
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddEventVC") as! AddEventViewController
        controller.delegate = self
        navBar.pushViewController(controller, animated: true)
        present(navBar, animated: true)
    }
    
    func userDidSelectEventCell(with index: IndexPath) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventDetailsVC") as! EventDetailsViewController
        controller.delegate = self
        controller.event = presenter.doctor?.events[index.row]
        navigationController?.pushViewController(controller, animated: true)
    }


    // MARK: - TableView Data Source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.doctor?.events.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let event = presenter.doctor?.events[indexPath.row] else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventTableViewCell
        cell.setupCell(with: event)

        return cell
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
        presenter.userCreatedNewEvent(with: newEvent)
    }
}
