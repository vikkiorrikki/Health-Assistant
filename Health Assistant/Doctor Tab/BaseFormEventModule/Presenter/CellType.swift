//
//  CellType.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 17.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

enum CellType {
    case textField(text: String?, tag: TextFieldTag)
    case date(text: String, date:Date, tag: DateCellTag)
    case listPicker(text: String, value: String)
    case textView(String?)
}

enum DateCellTag {
    case start
    case end
}

enum TextFieldTag {
    case title
    case doctorsName
}
