//
//  EventDetailsViewController.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 13.06.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController {

    @IBOutlet weak var titleEvent: UILabel!
    @IBOutlet weak var locationEvent: UILabel!
    @IBOutlet weak var fromDate: UILabel!
    @IBOutlet weak var toDate: UILabel!
    @IBOutlet weak var doctorsName: UILabel!
    @IBOutlet weak var notes: UILabel!
    @IBOutlet weak var notesTitle: UILabel!
    
    weak var delegate: EventTableDelegate?
    
    var event: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        guard let event = self.event
            else { return }
        
        setTitleColor()
        
        titleEvent.text = event.title
        fromDate.text = "from \(event.startDate.toStringFormat())"
        toDate.text = "to \(event.endDate.toStringFormat())"
        doctorsName.text = event.doctorsName
        
        if let location = event.location {
            locationEvent.text = "\(location.elementName)"
        } else {
            locationEvent.isHidden = true
        }
        
        if let note = event.note {
            notes.text = note
        } else {
            notesTitle.isHidden = true
            notes.isHidden = true
        }

    }
    
    func setTitleColor() {
        if event?.status == EventStatus.completed {
            titleEvent.textColor = .systemGreen
        } else if event?.status == EventStatus.canceled {
            titleEvent.textColor = .red
        }
    }


}
