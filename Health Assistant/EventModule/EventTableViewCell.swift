//
//  EventTableViewCell.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 06.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    func setupCell(with model: Event) {
        titleLabel.text = model.title
        dateLabel.text = "23 September 2020"
        locationLabel.text = "21 centure centure"
        
        let status = model.status
        switch status {
        case .planned:
            icon.image = UIImage()
        case .completed:
            icon.image = UIImage(systemName: "checkmark.circle")
        case .canceled:
            icon.image = UIImage(systemName: "multiply.circle")
        default:
            icon.image = UIImage()
        }
    }
}