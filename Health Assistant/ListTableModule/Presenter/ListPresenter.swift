//
//  ListPresenter.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 19.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

class ListPresenter {
    
    weak var delegate: AddEventViewController?
    var arrayData: [ListTableViewControllerElement] = []
    var listCellIndexPath: IndexPath = []
    
    func userDidSelectListCell(with indexPath: IndexPath) {
        delegate?.presenter.userDidSelectElement(arrayData[indexPath.row])
        delegate?.reloadRow(indexPath: listCellIndexPath)
        
    }
}
