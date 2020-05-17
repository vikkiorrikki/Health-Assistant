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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

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

    //MARK: - Add New Event
    
    @IBAction func addEventButtonPressed(_ sender: Any) {
        let navBar = UINavigationController()
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddEventVC") as! AddEventViewController
        navBar.pushViewController(controller, animated: true)
        present(navBar, animated: true)
    }
}
