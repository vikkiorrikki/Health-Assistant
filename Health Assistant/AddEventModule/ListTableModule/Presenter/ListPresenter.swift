//
//  ListPresenter.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 19.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

class ListPresenter {
    
    weak var delegate: ListTableViewController?
    var arrayData: [ListTableViewControllerElement] = []
    var listCellIndexPath: IndexPath = []
    
    func setupData(with array: [ListTableViewControllerElement], in index: IndexPath) {
        arrayData = array
        listCellIndexPath = index
    }
    
    
    func userDidSelectListCell(with indexPath: IndexPath) {
        delegate?.userDidSelectElement(with: arrayData[indexPath.row], in: listCellIndexPath)
    }
}
