//
//  CalendarEventTableViewCell.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 15.07.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import UIKit

class CalendarEventTableViewCell: UITableViewCell {

    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var specializationDoctor: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    
    func updateCell(with event: Event) {
        eventName.text = event.title
        startDate.text = event.startDate?.toTimeFormat()
        endDate.text = event.endDate?.toTimeFormat()
        eventLocation.text = event.location?.definition
        specializationDoctor.text = event.doctor?.specialization
    }
    
}
