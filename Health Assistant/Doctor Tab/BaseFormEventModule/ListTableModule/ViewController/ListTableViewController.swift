//
//  ListTableViewController.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 14.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController, ListTableInput {
    
    weak var delegate: BaseEventDelegate?
    var presenter: ListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.listView = self
    }
    
    func showSelectedElement(with element: ListTableViewControllerElement) {
        delegate?.userDidSelectElement(with: element)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.arrayData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = presenter.arrayData[indexPath.row].elementName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.userDidSelectListCell(with: indexPath)
        navigationController?.popViewController(animated: true)
    }
    
}
