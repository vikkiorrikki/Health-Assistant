//
//  CalendarViewController.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 15.07.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import UIKit
import CVCalendar

class CalendarViewController: UIViewController, CVCalendarMenuViewDelegate, CVCalendarViewDelegate, CalendarInput {
    
    //MARK: - Properties
    
    let presenter = CalendarPresenter()
    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var eventsTableView: UITableView!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.calendarView = self
        presenter.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.updateEvents(for: Date())
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        menuView.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
    }
    
    //MARK: - Input Methods
    
    func setupUI() {
        menuView.menuViewDelegate = self
        calendarView.calendarDelegate = self
        calendarView.calendarAppearanceDelegate = self
        calendarView.animatorDelegate = self
        navItem.title = CVDate(date: Date()).commonDescription
        
        eventsTableView.dataSource = self
        eventsTableView.delegate = self
        eventsTableView.tableFooterView = UIView()
    }
    
    func reloadTableView() {
        eventsTableView.reloadData()
    }
    
    //MARK: - CalendarViewDelegate
    
    func presentationMode() -> CalendarMode {
        return .monthView
    }
    
    func firstWeekday() -> Weekday {
        return .monday
    }

    func presentedDateUpdated(_ date: CVDate) { //update current month label in nav bar
        navItem.title = date.commonDescription
        
        if let date = date.convertedDate() {
            presenter.updateEvents(for: date)
        }
    }
    
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarEventCell", for: indexPath) as! CalendarEventTableViewCell
        cell.updateCell(with: presenter.events[indexPath.row])
        return cell
    }
}