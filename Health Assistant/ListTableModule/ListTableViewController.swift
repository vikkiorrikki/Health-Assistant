//
//  ListTableViewController.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 14.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import UIKit

protocol ListTableViewControllerElement {
    var elementName: String { get }
}

class ListTableViewController: UITableViewController {
    
    weak var delegate: AddEventViewControllerDelegate?
    var arrayData: [ListTableViewControllerElement] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = arrayData[indexPath.row].elementName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.userDidSelectElement(arrayData[indexPath.row])
        
        navigationController?.popViewController(animated: true)
    }
    
}
