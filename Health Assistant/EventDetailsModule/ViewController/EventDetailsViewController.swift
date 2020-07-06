//
//  EventDetailsViewController.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 13.06.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController, EventDetailsViewInput, EventDetailsViewDelegate {
    
    //MARK: - Properties
    
    weak var delegate: EditEventDelegate?
    var presenter: EventDetailsPresenter!

    //MARK: - IBOutlets
    
    @IBOutlet weak var titleEvent: UILabel!
    @IBOutlet weak var locationEvent: UILabel!
    @IBOutlet weak var fromDate: UILabel!
    @IBOutlet weak var toDate: UILabel!
    @IBOutlet weak var doctorsName: UILabel!
    @IBOutlet weak var notes: UILabel!
    @IBOutlet weak var notesTitle: UILabel!
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        presenter.viewDidLoad()
    }
    
    //MARK: - Input Methods
    
    func setUI(for event: Event) {
        titleEvent.text = event.title
        fromDate.text = "from \(event.startDate.toStringFormat())"
        toDate.text = "to \(event.endDate.toStringFormat())"
        doctorsName.text = event.doctorsName
        
        if let location = event.location {
            locationEvent.text = "\(location.elementName)"
            locationEvent.isHidden = false
        } else {
            locationEvent.isHidden = true
        }
        
        if event.note != nil && event.note != "" {
            notes.text = event.note
            notesTitle.isHidden = false
            notes.isHidden = false
        } else {
            notesTitle.isHidden = true
            notes.isHidden = true
        }

    }
    
    func setTitleColor(for event: Event) {
        if event.status == EventStatus.completed {
            titleEvent.textColor = .systemGreen
        } else if event.status == EventStatus.canceled {
            titleEvent.textColor = .red
        }
    }
    
    func openEditEventPage(for event: Event) {
        let navBar = UINavigationController()
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddEventVC") as! BaseEventViewController
        controller.delegateForEditEvent = self
        controller.presenter = EditEventPresenter(event: event)
        
        navBar.pushViewController(controller, animated: true)
        present(navBar, animated: true)
    }
    
    //MARK: - IBActions
    
    @IBAction func editButtonPressed(_ sender: Any) {
        presenter.userPressedEditButton()
    }
    
    //MARK: - Users Actions
    
    func userEditedEvent(_ event: Event) {
        presenter.updateValueForEditedEvent(event)
    }

    func editedEventIsSaved(with editedEvent: Event) {
        delegate?.updateEventTable(with: editedEvent)
    }
}
