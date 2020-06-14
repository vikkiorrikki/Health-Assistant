//
//  DateTableViewCell.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 14.05.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import UIKit

protocol DateCellDelegate: class {
    func userDidChangeDate(with date: Date, tag: DateCellTag)
}

class DateTableViewCell: UITableViewCell {

    weak var delegate: DateCellDelegate?
    var dateTag: DateCellTag?
    
    @IBOutlet weak var momentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePickerView: UIView! {
        didSet {
            datePickerView.isHidden = true
        }
    }

    @IBOutlet weak var datePicker: UIDatePicker!

    override func awakeFromNib() {
        super.awakeFromNib()
        datePicker.addTarget(self, action: #selector(dateDidChange), for: .valueChanged)
    }
    
    @objc func dateDidChange(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM y  HH:mm"
        dateLabel.text = dateFormatter.string(from: sender.date)
        
        delegate?.userDidChangeDate(with: sender.date, tag: dateTag!)
    }
    
    func updateCell(text: String, date: Date, tag: DateCellTag) {
        dateTag = tag
        momentLabel.text = text
        dateLabel.text = date.toStringFormat()
    }
}
