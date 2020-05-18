//
//  CellType.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 17.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

enum CellType {
    case textField(String)
    case date(text: String, date:Date)
    case listPicker(text: String, value: String)
    case textView
}
