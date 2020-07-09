//
//  ListPresenter.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 19.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

class ListPresenter {
    
    weak var listView: ListTableInput?
    var arrayData: [ListTableViewControllerElement] = []
    
    init(with data: [ListTableViewControllerElement]) {
        arrayData = data
    }
    
    func userDidSelectListCell(with indexPath: IndexPath) {
        listView?.showSelectedElement(with: arrayData[indexPath.row])
    }
}
