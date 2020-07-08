//
//  EventTableViewCell.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 06.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
// nsdateformatter.com

import UIKit

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    func setupCell(with model: Event) {
        titleLabel.text = model.title
        dateLabel.text = model.startDate?.toStringFormat()
        locationLabel.text = model.location?.clinicName
        
        guard  let eventStatus = model.status else { return }
        
        let status = getStatus(from: eventStatus)
        switch status {
        case .planned:
            icon.image = UIImage()
        case .completed:
            icon.image = UIImage(systemName: "checkmark.circle")
        case .canceled:
            icon.image = UIImage(systemName: "multiply.circle")
        }
    }
    
    private func getStatus(from status: NSObject) -> EventStatus {
        guard let eventStatus = EventStatus(rawValue: status.description) else {
            return .planned
        }
        return eventStatus
    }
}
