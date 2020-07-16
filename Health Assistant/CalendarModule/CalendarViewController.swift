//
//  CalendarViewController.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 15.07.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import UIKit
import CVCalendar

class CalendarViewController: UIViewController, CVCalendarMenuViewDelegate, CVCalendarViewDelegate {
    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var eventsTableView: UITableView!
    
    let storageService = StorageService()
    var events = [Event]() {
        didSet {
            eventsTableView.reloadData()
        }
    }
    var amountEvents = 0
    let date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuView.menuViewDelegate = self
        calendarView.calendarDelegate = self
        calendarView.calendarAppearanceDelegate = self
        calendarView.animatorDelegate = self
        navItem.title = CVDate(date: Date()).commonDescription
        
        eventsTableView.dataSource = self
        eventsTableView.delegate = self
        eventsTableView.tableFooterView = UIView()
        
        events = storageService.loadEvents(in: date)!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        events = storageService.loadEvents(in: date)!
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        menuView.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
    }
    
    func presentationMode() -> CalendarMode {
        return .monthView
    }
    
    func firstWeekday() -> Weekday {
        return .monday
    }

    func presentedDateUpdated(_ date: CVDate) { //update current month label in nav bar
        navItem.title = date.commonDescription
        
        if let date = date.convertedDate() {
            events = storageService.loadEvents(in: date)!
        }
    }
    
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarEventCell", for: indexPath) as! CalendarEventTableViewCell
        cell.eventName.text = events[indexPath.row].title
        cell.startDate.text = events[indexPath.row].startDate?.toTimeFormat()
        cell.endDate.text = events[indexPath.row].endDate?.toTimeFormat()
        cell.eventLocation.text = events[indexPath.row].location?.clinicName
        cell.specializationDoctor.text = events[indexPath.row].doctor?.specialization
        
        return cell
    }
    
    
}


